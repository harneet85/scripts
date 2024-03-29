#!/bin/bash
########################################################
#########################################################
## CREATED BY HARNEET SINGH 
## DATE - 26 JUNE 20202
## Purpose - To run commands on multiple host 
##          in a single session , multiple panes window.
########################################################

#user=harneet
#ppassword=anchal@85
user=in0090g5
ppassword=Windows12345
#command="toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/main.py "
#command="toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/main2.py "
command="export TERM=xterm;toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/mysshpass.py --password $ppassword ssh -t $user@"

while getopts ":t" opt
	do
		case ${opt} in
		t)	command="toxsocks ssh -l $user"
			poff="off"
			;;
		\? )
     			echo "Invalid Option: -$OPTARG" 1>&2
     			exit 1
     			;;
  		esac
	done
shift $((OPTIND -1))

			echo $command
echo $@

###########################
#### Variables ############
##########################

# Python Handles your username / password 
# effective when need to run multiple commands on 
# multiple servers
#command="toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/main.py" 

# use below to connect to multiple servers
# but will have to provide password to
# individual pane
#command="toxsocks ssh -l $user"

# Hardcode a command you need to execute remotely
#rcommand=top

# scripts argument count and array
count="$#"
hosts=( $@ )


################ Welcome function #######################

function welcome() {
	printf "\n\t\t###############################"
	printf "\n\t\t## CREATED BY HARNEET SINGH ##"
	printf "\n\t\t###############################\n\n"
}


################ check argument function #############

function checkArg() {
	if (( "$count" < "1" )) ; then
		echo "
		--------Error-------------
		Minimum one host required 
		--------------------------
		Usage -
			script host1 host2 host3 ......
		( to use toxsocks Python command )	

		Or	script -t host1 host2 host3 ......
		( to use toxsocks ssh session )

		"
	exit 1
	fi
}

############ Re-initiate TACAS connections #############

function tacas(){
	a=`ps -ef| grep -i tac.sh | grep -v grep`
	if [ ! -z "$a" ]; then
		echo "Tacas connection is alive "
		
	else
		nohup /home/harneet/scripts/tac.sh &
		a=true
		while $a ;do if grep "23 rules" /home/harneet/scripts/tac.log ;then echo "Tacas executed on all three sites" ; a=false; else echo "Tacas still starting...." ; sleep 1; fi; done
	fi
}




############## Pass command to execute remotely ########

remoteCommand() {
	if [ -z "$rcommand" ]; then
		echo "Require command to execute on remote servers: [ENTER] "
		read rcommand
		if [ ! -z "$rcommand" ]; then
			rcommand=\"$rcommand\"
		fi
		echo "command passed : $rcommand"
	fi
}



################ Main function ######################

starttmux() {

#hosts=( ${aarg[@]} )
#count=$carg
export TERM=xterm
tmux new -s harneet -d "$command""${hosts[0]} $rcommand; bash"
tmux setenv TERM xterm
#echo tmux new -s harneet -d "$command ${hosts[0]} \" $rcommand \"; bash"
#exit 1
#tmux new -s harneet -d "$command 100.112.8.217; bash"
hosts=("${hosts[@]:1}")
    
for i in "${hosts[@]}"; do
	if (( $count % 2 )) ; then
		tmux split-window -dv "$command""$i $rcommand; bash"
	else
		tmux split-window -dh "$command""$i $rcommand; bash" 
	fi
	count=$((count-1))
    done
tmux select-layout tiled
}

############# Start execution #####################

welcome
checkArg
if [  "$poff" != "off" ]; then
	remoteCommand
fi
tacas
sleep 2
starttmux
tmux attach

######## SCRIPT END #############################

