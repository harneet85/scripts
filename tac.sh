log=/home/harneet/scripts/tac.log
USER1=harneesi
PASS1=Gurnaazkaur1234
USER2=IN0090G5
PASS2=Taruarorakaur123
URL1=https://129.39.151.35:950/
URL2=https://9.140.49.20:950/
URL3=https://129.39.136.163:950/
mv $log $log.$(date +%d.%m.%y)
cat /dev/null > $log
date | tee -a $log
while : ; do
	for i in $URL1 $URL2; do 
		echo "Re-authenticating for UK $i"
   		ID=$(curl -k $i 2>/dev/null | grep ID | sed 's/.*value="//' | sed 's/">.*//')
   		curl -s -d "ID=$ID&STATE=1&DATA=$USER1" -k $i >> $log
   		curl -s -d "ID=$ID&STATE=2&DATA=$PASS1" -k $i >> $log
   		#curl -s -d "ID=$ID&STATE=3&DATA=1&submit=Submit" -k $i | grep -i authenticated| tee -a $log
   		curl -s -d "ID=$ID&STATE=3&DATA=1&submit=Submit" -k $i| grep -i authorized|awk -F">" '{print $3}'|sed 's?<BR??g' | tee -a $log
	done
                echo "Re-authenticating for Spain https://129.39.136.163:950/"
                ID=$(curl -k $URL3 2>/dev/null | grep ID | sed 's/.*value="//' | sed 's/">.*//')
                curl -s -d "ID=$ID&STATE=1&DATA=$USER2" -k $URL3 >> $log
                curl -s -d "ID=$ID&STATE=2&DATA=$PASS2" -k $URL3 >> $log
                curl -s -d "ID=$ID&STATE=3&DATA=1&submit=Submit" -k $URL3 | grep -i authorized|awk -F">" '{print $3}'|sed 's?<BR??g' | tee -a $log
	echo " ">> $log
	sleep 900
done
