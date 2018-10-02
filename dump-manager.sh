#!/bin/bash

# +-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+-+
# |D|U|M|P| |M|A|N|A|G|E|R| |M|T|N| |S|W|A|Z|I|L|A|N|D|
# +-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+-+

# FUNCTIONS
source /usr/share/dump-manager-1.0-0/lib/functions.sh

# GLOBAL DEFINITIONS
MY_DATE=$( date +%Y%m%d-%H%M%S-%s )
MY_HOME="/usr/share/dump-manager-1.0-0"
LOGGER="/bin/logger"
EXPDP="/opt/oracle/product/11gR2/db/bin/expdp"
MY_TMP="tmp/output"
MY_TMP_FOLDER="tmp"
BKP_FOLDER="backup"
SENT_FILE_EXTENSION="sent"

# DUMP DIRECTORY & USER
DUMP_FOLDER="/usr/share/dump-manager-1.0-0/dumps"
DUMP_REGEX="export_"
EXPORT_LOG="exports_ecw.log"
PARALLEL=1
OWNER="oracle"

# DISPATCH FOLDER
DISPATCH_FOLDER="/usr/share/dump-manager-1.0-0/dispatch"
FILEMANAGER="/usr/share/dump-manager-1.0-0/bin/filemanager"

# LOG FOLDER & FILE
LOG_FOLDER="/var/log/dump-manager"
LOG_FILE="dump-manager-$MY_DATE"

# EXPORT FILE
EXPORT_FILE="/usr/share/dump-manager-1.0-0/sql/export_new.par"
DATA_PUMP_FILE_INPUT="sql/data_pump.sql"
OPEN_MODE_FILE_INPUT="sql/open_mode.sql"

# MAIN
# 1. OPEN LOG FILE
if validateFolder $LOG_FOLDER $OWNER
then
  #----------LOG FOLDER & OWNER OK.
  if openLogFile $LOG_FOLDER $LOG_FILE
  then
    # LOG OPEN CORRECTLY.
    $LOGGER -p local3.info -t INFO -s "DUMP MANAGER: Log opened for writing on file $LOG_FOLDER/$LOG_FILE" &> /dev/null
    tallar 1 $LOG_FOLDER $LOG_FILE
  else
    $LOGGER -p local3.warning -t WARNING -s "DUMP MANAGER: Not possible to create the log file at $LOG_FOLDER/$LOG_FILE" &> /dev/null
  fi
else
  $LOGGER -p local3.warning -t WARNING -s "DUMP MANAGER: Log folder doesn't exist or owner user incorrect for $LOG_FOLDER" &> /dev/null
fi

#if checkClusterStatus
#then
#  tallar 61 $LOG_FOLDER $LOG_FILE
#else
#  tallar 62 $LOG_FOLDER $LOG_FILE
#  tallar 5 $LOG_FOLDER $LOG_FILE
#  elegantExit
#fi

# 2. REMOVE OLD DUMPS
if validateFolder $DUMP_FOLDER $OWNER
then
  #----------DUMP FOLDER & OWNER ARE OK.
  if removePreDumps $DUMP_FOLDER $DUMP_REGEX && removePreDumps $DISPATCH_FOLDER $DUMP_REGEX
  then
    tallar 2 $LOG_FOLDER $LOG_FILE
    #----------OLD DUMPS CORRECTLY REMOVED.
    # 3. Generate dump file.
    if checkPMON && checkDBMode $MY_HOME/$OPEN_MODE_FILE_INPUT $MY_HOME/$MY_TMP
    then
      tallar 3 $LOG_FOLDER $LOG_FILE
      #----------READY TO START THE DUMP PROCESS.
      #----------VALIDATE DATA PUMP DIRECTORY.
      if validateDataPump $MY_HOME/$DATA_PUMP_FILE_INPUT $MY_HOME/$MY_TMP
      then
        tallar 6 $LOG_FOLDER $LOG_FILE
        if validateFile $EXPORT_FILE $OWNER
        then
          #----------DUMP PARAMETER FILE OK.
          tallar 8 $LOG_FOLDER $LOG_FILE
          tallar 60 $LOG_FOLDER $LOG_FILE
          if expdpDump $EXPORT_FILE
          then
            #----------EXPORT PROCESS COMPLETED.
            tallar 10 $LOG_FOLDER $LOG_FILE
            #----------VALIDATE EXPORT LOG.
            if validateFile $DUMP_FOLDER/$EXPORT_LOG $OWNER
            then
              tallar 15 $LOG_FOLDER $LOG_FILE
              #----------VALIDATE EXPORT LOG.
              if dumpValidation $DUMP_FOLDER $EXPORT_LOG
              then
                tallar 16 $LOG_FOLDER $LOG_FILE
                for i in $( ls $DUMP_FOLDER/$DUMP_REGEX* )
                do
                  MY_DUMP_FILE_FINAL_NAME=$i
                  MY_DUMP_FILE_FINAL_SIZE=$( du -h $i | awk ' { print $1 } ' )
                  MY_MESSAGE_FINAL="Final file: $MY_DUMP_FILE_FINAL_NAME Size:$MY_DUMP_FILE_FINAL_SIZE"
                  MY_MESSAGE_TO_TALLAR=$( echo $MY_MESSAGE_FINAL | sed -e 's/ /%/g' )
                  tallar C $LOG_FOLDER $LOG_FILE $MY_MESSAGE_TO_TALLAR
                done
                if validateFolder $DISPATCH_FOLDER $OWNER
                then
                  if moveToDispatch $DUMP_FOLDER $DISPATCH_FOLDER $DUMP_REGEX $PARALLEL $MY_HOME/$MY_TMP_FOLDER
                  then
                    if $FILEMANAGER start 
                    then
                      MY_MESSAGE_FINAL="File Manager started correctly!"
                      MY_MESSAGE_TO_TALLAR=$( echo $MY_MESSAGE_FINAL | sed -e 's/ /%/g' )
                      tallar C $LOG_FOLDER $LOG_FILE $MY_MESSAGE_TO_TALLAR
                      if checkTransference $MY_HOME/$BKP_FOLDER $DUMP_REGEX $PARALLEL $MY_TMP_FOLDER
                      then
                        if $FILEMANAGER stop
                        then
                          MY_MESSAGE_FINAL="File Manager stopped correctly!"
                          MY_MESSAGE_TO_TALLAR=$( echo $MY_MESSAGE_FINAL | sed -e 's/ /%/g' )
                          tallar C $LOG_FOLDER $LOG_FILE $MY_MESSAGE_TO_TALLAR
                          if archiveLogs $DUMP_FOLDER $BACKUP_FOLDER $EXPORT_LOG $SENT_FILE_EXTENSION
                          then
                            if cleanUpOldBackup $MY_HOME/$BKP_FOLDER
                            then
                              echo OK
                              tallar 22 $LOG_FOLDER $LOG_FILE
                              tallar 5 $LOG_FOLDER $LOG_FILE
                              elegantExit
                            else
                              tallar 23 $LOG_FOLDER $LOG_FILE
                              tallar 5 $LOG_FOLDER $LOG_FILE
                              elegantExit
                            fi
                          else
                            tallar 21 $LOG_FOLDER $LOG_FILE
                            tallar 5 $LOG_FOLDER $LOG_FILE
                            elegantExit
                          fi
                        else
                          tallar 20 $LOG_FOLDER $LOG_FILE
                          tallar 5 $LOG_FOLDER $LOG_FILE
                          elegantExit
                        fi
                      else
                        tallar 19 $LOG_FOLDER $LOG_FILE
                        tallar 5 $LOG_FOLDER $LOG_FILE
                        elegantExit
                      fi             
                    else
                      tallar 18 $LOG_FOLDER $LOG_FILE
                      tallar 5 $LOG_FOLDER $LOG_FILE
                      elegantExit
                    fi
                  else
                    tallar 17 $LOG_FOLDER $LOG_FILE
                    tallar 5 $LOG_FOLDER $LOG_FILE
                    elegantExit
                  fi
                else
                  tallar 12 $LOG_FOLDER $LOG_FILE
                  tallar 5 $LOG_FOLDER $LOG_FILE
                  elegantExit
                fi
              else
                tallar 14 $LOG_FOLDER $LOG_FILE
                tallar 5 $LOG_FOLDER $LOG_FILE
                elegantExit
              fi
            else
             tallar 14 $LOG_FOLDER $LOG_FILE
             tallar 5 $LOG_FOLDER $LOG_FILE
             elegantExit
            fi
          else
            tallar 11 $LOG_FOLDER $LOG_FILE
            tallar 5 $LOG_FOLDER $LOG_FILE
            elegantExit
          fi
        else
          tallar 9 $LOG_FOLDER $LOG_FILE
          tallar 5 $LOG_FOLDER $LOG_FILE
          elegantExit
        fi        
      else
        tallar 7 $LOG_FOLDER $LOG_FILE
        tallar 5 $LOG_FOLDER $LOG_FILE
        elegantExit
      fi
    else
      tallar 4 $LOG_FOLDER $LOG_FILE
      tallar 5 $LOG_FOLDER $LOG_FILE
      elegantExit
    fi
  else
    tallar 13 $LOG_FOLDER $LOG_FILE
    tallar 5 $LOG_FOLDER $LOG_FILE
    elegantExit
  fi
else
  tallar 12 $LOG_FOLDER $LOG_FILE
  tallar 5 $LOG_FOLDER $LOG_FILE
  elegantExit
fi
