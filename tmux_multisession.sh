#!/bin/bash
########################################################
#########################################################
## CREATED BY HARNEET SINGH 
## DATE - 26 JUNE 20202
## Purpose - To run commands on multiple host 
##          in a single session , multiple panes window.
########################################################

###########################
#### Variables ############
##########################

command="toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/main.py"
#rcommand=top
carg="$#"
aarg=( $@ )


################ Welcome function #######################

function welcome() {
	printf "\n\t\t###############################"
	printf "\n\t\t## CREATED BY HARNEET SINGH ##"
	printf "\n\t\t###############################\n\n"
}

################ check argument function #############

checkArg() {
	if (( "$carg" < "1" )) ; then
		echo "
		--------Error-------------
		Minimum one host required 
		--------------------------
		Usage -
			script host1 host2 host3 ......
		"
	exit 1
	fi
}

############## Pass command to execute remotely ########

remoteCommand() {
	if [ -z "$rcommand" ]; then
		echo "Require command to execute on remote servers: [ENTER] "
		read rcommand
	
	fi
}


################ Main function ######################

starttmux() {

hosts=( ${aarg[@]} )
count=$carg

tmux new -s harneet -d "$command ${hosts[0]} \" $rcommand \"; bash"
hosts=("${hosts[@]:1}")
    
for i in "${hosts[@]}"; do
	if (( $count % 2 )) ; then
		tmux split-window -dv "$command $i \" $rcommand \"; bash"
	else
		tmux split-window -dh "$command $i \" $rcommand \"; bash" 
	fi
	count=$((count-1))
    done
tmux select-layout tiled
}

############# Start execution #####################

welcome
checkArg
remoteCommand
starttmux
tmux attach

######## SCRIPT END #############################

