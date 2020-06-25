#!/bin/bash
# toxsocks ssh -l in0090g5-multi
# D.Kovalov
# Based on http://linuxpixies.blogspot.jp/2011/06/tmux-copy-mode-and-how-to-control.html

# a script to toxsocks ssh -l in0090g5 multiple servers over multiple tmux panes

command="toxsocks /home/harneet/PycharmProjects/tsb1/venv/bin/python /home/harneet/PycharmProjects/tsb1/main.py"
#rcommand=top



if (( "$#" < "1" )) ; then
echo "
--------Error-------------
Minimum one host required 
--------------------------
Usage -
	script host1 host2 host3 ......
"
exit 1
fi


if [ -z "$rcommand" ]; then
	echo "Require command to execute on remote servers: [ENTER] "
	read rcommand
	
fi


hosts=( $@ )
starttmux() {

count=${#hosts[@]}
echo $count
echo ${hosts[@]}


tmux new -s harneet -d "$command ${hosts[0]} \" $rcommand \"; bash"
#tmux new -s harneet -d "alias;tt ${hosts[0]}; bash"
#tmux new -s harneet -d 
#tmux send-keys -t "harneet:0" "tt ${hosts[0]}" enter
hosts=("${hosts[@]:1}")
    
for i in "${hosts[@]}"; do
	if (( $count % 2 )) ; then
		tmux split-window -dv "$command $i \" $rcommand \"; bash"
		#z=$((100/$count));tmux split-window -dv -p $z "$command $i \" $rcommand \"; bash"
		#z=$((100/$count));tmux split-window -dh -p $z ; tmux send-keys "tt $i" enter
	else
		tmux split-window -dh "$command $i \" $rcommand \"; bash" 
		#z=$((100/$count));tmux split-window -dh -p $z "$command $i \" $rcommand \"; bash" 
	fi
	count=$((count-1))
    done
tmux select-layout tiled
}

HOSTS=${HOSTS:=$*}

starttmux
tmux attach
