#!/bin/bash

 #+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+
 #|V|A|L|I|D|A|T|E| |F|O|L|D|E|R|S|
 #+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+

function validateFolder {

  #$1: Directory $2:Owner
  DIRECTORY=$1
  OWNER=$2

  if [ -d $DIRECTORY ]
  then
    FILES_PERMISION_FOLDER=$( stat -c %A $DIRECTORY | sed 's/.\(.\)\(.\)\(.\).\+/\1\2/' )
    FILES_OWNER=$( stat --format '%U' $DIRECTORY )
    if [ $FILES_PERMISION_FOLDER = "rw" -a $FILES_OWNER = $OWNER ]
    then
      return 0
    else
      return 1
    fi
  else
        return 1
  fi

}

 #+-+-+-+-+-+-+ +-+-+-+-+-+
 #|R|E|M|O|V|E| |D|U|M|P|S|
 #+-+-+-+-+-+-+ +-+-+-+-+-+

function removePreDumps {

  #$1:$DUMP_FOLDER $2:$DUMP_REGEX
  DIRECTORY=$1
  FILES=$2
  if rm -rf $DIRECTORY/$FILES*  &> /dev/null
  then
    return 0
  else
    return 1
  fi
}

 #+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+
 #|P|R|I|N|T| |L|O|G| |M|E|S|S|A|G|E|
 #+-+-+-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+

function tallar {

  #$1:Message $2:$LOG_FOLDER $3:$LOG_FILE $4:MY_CUSTOM

  MESSAGE=$1
  FOLDER=$2
  FILE=$3
  MY_CUSTOM=$4
  BANNER="DUMP MANAGER"
  MESSAGE_1="Log opened for writing on file $FOLDER/$FILE"
  MESSAGE_2="Old dump files removed!"
  MESSAGE_3="Database PMON Found active!"
  MESSAGE_4="PMON not found or Database OPEN_MODE Incorrect, Database not active, aborting procedure."
  MESSAGE_5="Elegant EXIT called!"
  MESSAGE_6="Data pump directory exist!"
  MESSAGE_7="Data pump missing configuration in database!"
  MESSAGE_8="Dump parameter file permissions and owner OK!"
  MESSAGE_9="Dump parameter file permissions or owner problems, aborting!"
  MESSAGE_10="Dump export process completed!"
  MESSAGE_11="Dump export process failed!"
  MESSAGE_12="Dump or Dispatch folder doesn't exist or owner user incorrect!"
  MESSAGE_13="Old dumps not removed or process failed!"
  MESSAGE_14="For some cosmical reason the dump log doesn't have any coincidence fro the error or sucess!"
  MESSAGE_15="Export dump log is ok, user can see the content!"
  MESSAGE_16="Dump files were generated!"
  MESSAGE_17="Process for moving files from Dump folder to Dispatch folder failed!"
  MESSAGE_18="File Manager not starting!"
  MESSAGE_19="Waiting for the files to complete the transference!"
  MESSAGE_20="Problems present when stopping File Manager!"
  MESSAGE_21="Archive failed!"
  MESSAGE_22="Process completed suscessfully. Kindly check File Manager logs for transference details!"
  MESSAGE_23="Not poassible to remove the old dump backup file!"
  MESSAGE_60="Starting Dump process!"
  MESSAGE_61="Cluster is online and Database is ONLINE or PARTIAL, following up!"
  MESSAGE_62="Cluster not online or Group not ONLINE in this node, stopping the process!"
  case $MESSAGE in
  1)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_1" >> $FOLDER/$FILE ;;
  2)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_2" >> $FOLDER/$FILE ;;
  3)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_3" >> $FOLDER/$FILE ;;
  4)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_4" >> $FOLDER/$FILE ;;
  5)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_5" >> $FOLDER/$FILE ;;
  6)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_6" >> $FOLDER/$FILE ;;
  7)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_7" >> $FOLDER/$FILE ;;
  8)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_8" >> $FOLDER/$FILE ;;
  9)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_9" >> $FOLDER/$FILE ;;
  10)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_10" >> $FOLDER/$FILE ;;
  11)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_11" >> $FOLDER/$FILE ;;
  12)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_12" >> $FOLDER/$FILE ;;
  13)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_13" >> $FOLDER/$FILE ;;
  14)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_14" >> $FOLDER/$FILE ;;
  15)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_15" >> $FOLDER/$FILE ;;
  16)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_16" >> $FOLDER/$FILE ;;
  17)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_17" >> $FOLDER/$FILE ;;
  18)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_18" >> $FOLDER/$FILE ;;
  19)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_19" >> $FOLDER/$FILE ;;
  20)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_20" >> $FOLDER/$FILE ;;
  21)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_21" >> $FOLDER/$FILE ;;
  22)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_22" >> $FOLDER/$FILE ;;
  23)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_23" >> $FOLDER/$FILE ;;
  60)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_60" >> $FOLDER/$FILE ;;
  61)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_60" >> $FOLDER/$FILE ;;
  62)
    DATE=$( date )
    echo "[ $DATE ]:[ $BANNER ]:$MESSAGE_60" >> $FOLDER/$FILE ;;
  C)
    DATE=$( date )
    MY_CUSTOM_CLEAR=$( echo $MY_CUSTOM | sed -e 's/%/ /g' )
    echo "[ $DATE ]:[ $BANNER ]:$MY_CUSTOM_CLEAR" >> $FOLDER/$FILE ;;
  esac
}

 #+-+-+-+-+-+-+-+ +-+-+-+-+
 #|O|P|E|N|I|N|G| |L|O|G|S|
 #+-+-+-+-+-+-+-+ +-+-+-+-+

function openLogFile {

  #$1:$LOG_FOLDER $2:$LOG_FILE
  FOLDER=$1
  FILE=$2
  if touch $FOLDER/$FILE &> /dev/null
  then
    return 0
  else
    return 1
  fi
}

 #+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+
 #|V|A|L|I|D|A|T|E| |P|M|O|N| |P|R|O|C|E|S|S|
 #+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+

function checkPMON {

  #NO PARAMETERS
  PROCESS=$( ps -fea | grep pmon | grep -v grep | awk ' { print $8 } ' )
  PROCESS_STRING="X$PROCESS"
  if [ $PROCESS_STRING = "Xora_pmon_orcl" ]
  then
    return 0
  else
    return 1
  fi
}

 #+-+-+-+-+-+-+-+ +-+-+-+-+
 #|E|L|E|G|A|N|T| |E|X|I|T|
 #+-+-+-+-+-+-+-+ +-+-+-+-+

function elegantExit {

  #$1:$LOG_FOLDER $2:$LOG_FILE
  MY_OUTPUT_CODE=500
  ( exit $MY_OUTPUT_CODE )
}

 #+-+-+-+-+-+ +-+-+-+-+
 #|E|X|P|D|P| |D|U|M|P|
 #+-+-+-+-+-+ +-+-+-+-+

function expdpDump {

  #1:$EXPORT_FILE
  PAR_FILE=$1
  EXPDP="/home/oracle/app/oracle/product/11.2.0/dbhome_1/bin/expdp"
  if $EXPDP parfile=$PAR_FILE
  then
    return 0
  else
    return 60
  fi
}

 #+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+
 #|V|A|L|I|D|A|T|E| |D|A|T|A| |P|U|M|P|
 #+-+-+-+-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+

function validateDataPump {

  #1:Input file 2:Output file
  INPUT_FILE=$1
  OUTPUT_FILE=$2
  SQL_PLUS="/home/oracle/app/oracle/product/11.2.0/dbhome_1/bin/sqlplus"
  MYRANDOM=$RANDOM
  if $SQL_PLUS -S / as sysdba < $INPUT_FILE | egrep '[X]' | awk -F, ' { print $2 } ' > $OUTPUT_FILE.$MYRANDOM
  then
    MY_RESPONSE=$( cat $OUTPUT_FILE.$MYRANDOM )
    rm -rf $OUTPUT_FILE.$MYRANDOM
    if [ $MY_RESPONSE -eq 1 ]
    then
      return 0
    else
      return 50
    fi
  else
    return 50
  fi
}

 #+-+-+-+-+-+ +-+-+ +-+-+-+-+
 #|C|H|E|C|K| |D|B| |M|O|D|E|
 #+-+-+-+-+-+ +-+-+ +-+-+-+-+

function checkDBMode {

  #1:Input file 2:Output file
  INPUT_FILE=$1
  OUTPUT_FILE=$2
  SQL_PLUS="/home/oracle/app/oracle/product/11.2.0/dbhome_1/bin/sqlplus"
  MYRANDOM=$RANDOM

  #echo $INPUT_FILE
  #echo $OUTPUT_FILE

  if $SQL_PLUS -S / as sysdba < $INPUT_FILE | egrep '[X]' | awk -F, ' { print $2 } ' > $OUTPUT_FILE.$MYRANDOM
  then
    MY_RESPONSE=$( cat $OUTPUT_FILE.$MYRANDOM | sed -e 's/ /_/g' )
    rm -rf $OUTPUT_FILE.$MYRANDOM
    if [ $MY_RESPONSE = "READ_WRITE" ]
    then
      return 0
    else
      return 50
    fi
  else
    return 50
  fi
}

 #+-+-+-+-+-+-+-+-+ +-+-+-+-+-+
 #|V|A|L|I|D|A|T|E| |F|I|L|E|S|
 #+-+-+-+-+-+-+-+-+ +-+-+-+-+-+

function validateFile {

  #$1:File $2:Owner
  FILE=$1
  OWNER=$2
  FILES_PERMISION_FILE=$( stat -c %A $FILE | sed 's/.\(.\)\(.\)\(.\).\+/\1\2/' )
  FILES_OWNER=$( stat --format '%U' $FILE )

  if [ $FILES_PERMISION_FILE = "rw" ]
  then
    if [ $FILES_OWNER = $OWNER ]
    then
      return 0
    else
      return 40
    fi
  else
    return 40
  fi
}

 #+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
 #|D|U|M|P| |V|A|L|I|D|A|T|I|O|N|
 #+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+

function dumpValidation {

  #$1:$DUMP_FOLDER $2:$EXPORT_LOG
  DUMP_FOLDER=$1
  EXPORT_LOG=$2

  FINISH=$( cat $DUMP_FOLDER/$EXPORT_LOG | egrep "Job \"SYS\".\"SYS_EXPORT_TABLE_" | egrep 'successfully|completed' )
  if [ -z "$FINISH" ]
  then
    return 60
  else
    return 0
  fi
}

 #+-+-+-+-+ +-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+
 #|M|O|V|E| |F|I|L|E|S| |T|O| |D|I|S|P|A|T|C|H| |F|O|L|D|E|R|
 #+-+-+-+-+ +-+-+-+-+-+ +-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+

function moveToDispatch {

  #1:$DUMP_FOLDER 2:$DISPATCH_FOLDER 3:$DUMP_REGEX 4:$PARALLEL 5:$MY_TEMP_FOLDER
  DUMP_FOLDER=$1
  DISPATCH_FOLDER=$2
  DUMP_REGEX=$3
  PARALLEL_VALUE=$4
  MY_TMP_FOLDER=$5
  COUNTER=0
  CKSUM="/usr/bin/cksum"

  #echo DUMP_FOLDER $DUMP_FOLDER
  #echo DISPATCH_FOLDER $DISPATCH_FOLDER
  #echo DUMP_REGEX $DUMP_REGEX
  #echo PARALLEL_VALUE $PARALLEL_VALUE
  #echo MY_TMP_FOLDER $MY_TMP_FOLDER

  if ls $MY_TMP_FOLDER/static_transference.tmp &> /dev/null
  then
    rm -rf $MY_TMP_FOLDER/static_transference.tmp
    touch $MY_TMP_FOLDER/static_transference.tmp
  else
    touch $MY_TMP_FOLDER/static_transference.tmp
  fi

  cd $DUMP_FOLDER
  for i in $( ls $DUMP_REGEX* )
  do
    FILE_CORE=$( echo $i | awk -F. ' { print $1 } ' )
    NEW_FILE_NAME=$FILE_CORE.dmp
    if mv $i $NEW_FILE_NAME
    then
      if mv $NEW_FILE_NAME $DISPATCH_FOLDER
      then
        COUNTER=$( expr $COUNTER + 1 )
        CKSUM_FILE=$( $CKSUM $DISPATCH_FOLDER/$NEW_FILE_NAME | awk ' { print $1 } ' )
        echo "$NEW_FILE_NAME,$CKSUM_FILE,1" >> $MY_TMP_FOLDER/static_transference.tmp
      else
        CKSUM_FILE=$( $CKSUM $DUMP_FOLDER/$NEW_FILE_NAME | awk ' { print $1 } ' )
        echo "$NEW_FILE_NAME,$CKSUM_FILE,0" >> $MY_TMP_FOLDER/static_transference.tmp
      fi
    else
      return 60
    fi
  done
  
  if [ $COUNTER -eq $PARALLEL_VALUE ]
  then
    return 0
  else
    return 60
  fi
}

 #+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+
 #|C|H|E|C|K| |T|R|A|N|S|F|E|R|E|N|C|E| |S|T|A|T|U|S|
 #+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+

function checkTransference {

  #1:$BACKUP_FOLDER 2:$DUMP_REGEX 3:$PARALLEL 4:$MY_TMP_FOLDER

  BACKUP_FOLDER=$1
  DUMP_REGEX=$2
  PARALLEL_VALUE=$3
  MY_TMP_FOLDER=$4
  FILE_COUNTER=0
  COINCIDENCE_COUNTER=0
  CKSUM="/usr/bin/cksum"
  
  #echo BACKUP_FOLDER $BACKUP_FOLDER
  #echo DUMP_REGEX $DUMP_REGEX 
  #echo PARALLEL_VALUE $PARALLEL_VALUE
  #echo MY_TMP_FOLDER $MY_TMP_FOLDER

  cd $BACKUP_FOLDER
  while [ $FILE_COUNTER -ne $PARALLEL_VALUE ]
  do
   FILE_COUNTER=$( find . -name $DUMP_REGEX* | wc -l )
  done

  for i in $( ls $DUMP_REGEX* )
  do
    FILE_NAME=$( echo $i | awk -F. ' { print $1"."$2 } ' )
    CKSUM_FILE=$( $CKSUM $i | awk ' { print $1 } ' )
    if grep "$FILE_NAME,$CKSUM_FILE" $MY_TMP_FOLDER/static_transference.tmp &> /dev/null
    then
      COINCIDENCE_COUNTER=$( expr $COINCIDENCE_COUNTER + 1 )
    fi
  done
  if [ $COUNTER -eq $PARALLEL_VALUE ]
  then
    return 0
  else
    return 60
  fi
}

 #+-+-+-+-+-+-+-+ +-+-+-+-+
 #|A|R|C|H|I|V|E| |L|O|G|S|
 #+-+-+-+-+-+-+-+ +-+-+-+-+

function archiveLogs {

  #1:$DUMP_FOLDER 2:$BACKUP_FOLDER 3:$EXPORT_LOG 4:$SENT_FILE_EXTENSION

  DUMP_FOLDER=$1
  BACKUP_FOLDER=$2
  EXPORT_LOG=$3
  SENT_FILE_EXTENSION=$4
  DATE=$( date +%Y%m%d-%H%M%S-%s )

  cd $BACKUP_FOLDER
  if [ -d $DATE ]
  then
    mv $DUMP_FOLDER/$EXPORT_LOG $BACKUP_FOLDER/$DATE
  else
    mkdir $DATE
    mv $DUMP_FOLDER/$EXPORT_LOG $BACKUP_FOLDER/$DATE
  fi
  for i in $( ls *$SENT_FILE_EXTENSION )
  do
    mv $i $DATE
  done
  if tar -cvzf $DATE.tar.gz $DATE &> /dev/null
  then
    rm -rf $DATE
    return 0
  else
    return 50
  fi
}

 #+-+-+-+-+-+ +-+-+ +-+-+-+ +-+-+-+-+-+-+-+
 #|C|L|E|A|N| |U|P| |O|L|D| |B|A|C|K|U|P|S|
 #+-+-+-+-+-+ +-+-+ +-+-+-+ +-+-+-+-+-+-+-+

function cleanUpOldBackup {

  #1:$BACKUP_FOLDER

  BACKUP_FOLDER=$1
  YESTERDAY=$( date --date='1 day ago' '+%Y%m%d' )
  
  cd $BACKUP_FOLDER
  if ls *$YESTERDAY* &> /dev/null
  then
    for i in $( ls *$YESTERDAY* )
    do
      if rm -rf $i
      then
        echo $i
        return 0
      else
        return 50
      fi
    done
  else
    return 0
  fi
}

 #+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+
 #|C|H|E|C|K| |C|L|U|S|T|E|R| |S|T|A|T|U|S|
 #+-+-+-+-+-+ +-+-+-+-+-+-+-+ +-+-+-+-+-+-+

function checkClusterStatus {
 
  # NO PARAMETERS
 
  HASYS="/opt/VRTS/bin/hasys"
  HAGRP="/opt/VRTS/bin/hagrp"
  HASTATUS="/opt/VRTS/bin/hastatus"

  MY_HOSTNAME=$( hostname )
  MY_STATE_IN_CLUSTER=$( $HASYS -state $MY_HOSTNAME )
  MY_DATABASE_GROUP=$( $HAGRP -list | awk ' { print $1 } ' | sort -u | egrep '[dD]atabase' )
  MY_DATABASE_GROUP_STATUS=$( $HASTATUS -summ | grep $MY_DATABASE_GROUP | grep $MY_HOSTNAME | awk ' { print $6 } ' )

  #echo MY_HOSTNAME $MY_HOSTNAME
  #echo MY_STATE_IN_CLUSTER $MY_STATE_IN_CLUSTER
  #echo MY_DATABASE_GROUP $MY_DATABASE_GROUP
  #echo MY_DATABASE_GROUP_STATUS $MY_DATABASE_GROUP_STATUS

  if [ $MY_STATE_IN_CLUSTER = "RUNNING" ]
  then
    if [ $MY_DATABASE_GROUP_STATUS = "ONLINE" -o $MY_DATABASE_GROUP_STATUS = "PARTIAL" ]
    then
      return 0
    else
      return 60
    fi
  else
    return 60
  fi
}
