#! /bin/bash

while getopts c:t: flag
do
	case $flag in
		c) chords=($OPTARG);;
		t) time=${OPTARG};;
	esac
done

if [[ -z "$time" ]]
then
	time=60
fi

get_chord () {
	current_chord=${chords[$((RANDOM%${#chords[@]}))]}
}

check_dup () {
	if [[ $current_chord = $previous_chord ]] 
	then
		for chord in ${chords[@]} 
		do
			get_chord
			if [[ $chord != $previous_chord ]]
			then
				current_chord=$chord
				previous_chord=$current_chord
				break
			fi
		done
else
	previous_chord=$current_chord
	fi	
}

echo ""
echo "Practicing ${#chords[@]} chords for $time cycles"
get_chord 
previous_chord=$current_chord
counter=1
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
	sleep 2
	get_chord
	check_dup
	echo "$current_chord"
	echo " "
	((counter++))
done
sleep 1
echo "ALL DONE"
