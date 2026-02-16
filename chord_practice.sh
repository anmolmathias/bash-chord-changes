#! /bin/bash

counter=1

while getopts c:t:p: flag
do
	case $flag in
		c) chords=($OPTARG);;
		t) time=${OPTARG};;
		p) pause=${OPTARG};;
	esac
done

if [[ -z "$time" ]]
then
	time=60
fi

if [[ -z "$pause" ]]
then
	pause=2
fi

gen_chord () {
	current_chord=${chords[$((RANDOM%${#chords[@]}))]}
}

set_chord () {
	gen_chord
	if [[ $current_chord = $previous_chord ]] 
	then
		for chord in ${chords[@]} 
		do
			gen_chord
			if [[ $current_chord != $previous_chord ]]
			then
				previous_chord=$current_chord
				break
			fi
		done
	else
		previous_chord=$current_chord
	fi	
}

gen_chord 
previous_chord=$current_chord
echo ""
echo "Practicing ${#chords[@]} chords at intervals of $pause seconds for $time cycles"
echo "Get ready."
echo " "
sleep 1
echo "."
sleep 1
echo "."
sleep 1
echo "."
echo " "

while [ $counter -le $time ]
do
	sleep $pause
	set_chord
	echo "$current_chord"
	echo " "
	((counter++))
done

sleep 1
echo "ALL DONE"
