#!/bin/bash

## Padding function for ring alignment
## Three arguments (STRING, LEFT_PADDING, RIGHT_PADDING) 
pad() {
    [ "$#" -lt 3 ] && return

    local text="$1"
    local left="$2"
    local right="$3"

    printf "%*s%s%*s" "$left" "" "$text" "$right" ""
}

## Function for Rod and Ring graphics after each transfer 
graphic_gen(){
	
	if ((INPUT % 2 == 0)) ; then
		COUNT=INPUT+1;
	else 
		COUNT=INPUT;
	fi

	len_A=${#A[@]}
	len_B=${#B[@]}
	len_C=${#C[@]}

	f=-1
	g=-1
	h=-1
	
	for ((t = $COUNT ; t >= 0 ; t--)); do 
	
		echo
	
		string_a=""
		string_b=""
		string_c=""

		if ((t < len_A)); then
			disk_a=${A[$f]}
			((f--))
			for ((m = 0 ; m < disk_a ; m++)); do
				string_a+="="
			done
			if ((disk_a % 2 == 0)); then
                                echo -n  "$(pad $string_a $((COUNT/2 - disk_a/2)) $((COUNT/2 - disk_a/2 + 1)) )"
                        else
                                echo -n  "$(pad $string_a $((COUNT/2 - disk_a/2)) $((COUNT/2 - disk_a/2)) )"
                        fi
			
		
		else 
			if ((COUNT % 2 == 0)); then
				echo -n  "$(pad "|" $((COUNT / 2 - 1)) $((COUNT/2)) )"
			else 
				echo -n  "$(pad "|" $((COUNT / 2 )) $((COUNT/2)) )"
			fi
		fi
	
		echo -n "     "
	
		if ((t < len_B)); then
			disk_b=${B[$g]}
			((g--))
                        for ((m = 0 ; m < disk_b ; m++)); do
                                string_b+="="
                        done
                        if ((disk_b % 2 == 0)); then
				echo -n  "$(pad $string_b $((COUNT/2 - disk_b/2)) $((COUNT/2 - disk_b/2 + 1)) )"
                        else
                                echo -n  "$(pad $string_b $((COUNT/2 - disk_b/2)) $((COUNT/2 - disk_b/2)) )"
                        fi 

                else
                        if ((COUNT % 2 == 0)); then
                                echo -n "$(pad "|" $((COUNT / 2 - 1)) $((COUNT/2)) )"
		        else 
                                echo -n  "$(pad "|" $((COUNT / 2 )) $((COUNT/2)) )"
                        fi
                fi
	
		echo -n "     "
	
		if ((t < len_C)); then
			disk_c=${C[$h]}
                        ((h--))
			for ((m = 0 ; m < disk_c ; m++)); do
                                string_c+="="
                        done
                        if ((disk_c % 2 == 0)); then
                                echo -n  "$(pad $string_c $((COUNT/2 - disk_c/2)) $((COUNT/2 - disk_c/2 +1)) )"
                        else
                                echo -n  "$(pad $string_c $((COUNT/2 - disk_c/2)) $((COUNT/2 - disk_c/2)) )"
                        fi
                else
                        if ((COUNT % 2 == 0)); then
                                echo -n "$(pad "|" $((COUNT / 2 - 1)) $((COUNT/2)) )"
                	else
                                echo -n  "$(pad "|" $((COUNT / 2 )) $((COUNT/2)) )"
                        fi
		fi
	done
	
	echo
	
	## Loop for printing the rod names
	for ((i = 0 ; i < 3 ; i++)); do 
	 
		for ((j = 1 ; j <= $COUNT ; j++)); do 
			if ((j == COUNT / 2 + 1)); then
				echo -n ${peg[$i]};
			else
				echo -n " "; 
			fi
				
		done
		echo -n "     "
	done

	
	
}

hanai_exchange(){
        if [ $1 == 0 ]; then
                return 0;
        fi

        ## Recursive call to the hanai_exchange function !!!!!
        hanai_exchange $(($1-1)) $2 $4 $3

        

	graphic_gen
	
	echo ""
	echo ""
        echo $2 to $3
        echo ""
	echo ""

	if [ $2 == "A" ]; then
		TEMP=${A[-1]}
		unset A[-1]
		A=("${A[@]}")
		if [ $3 == "B" ]; then			
			B+=($TEMP);
		elif [ $3 == "C" ]; then
			C+=($TEMP);
		fi

	elif [ $2 == "B" ]; then
		TEMP=${B[-1]}
		unset B[-1]
		B=("${B[@]}")
		if [ $3 == "A" ]; then			
			A+=($TEMP);
		elif [ $3 == "C" ]; then
			C+=($TEMP);
		fi

	elif [ $2 == "C" ]; then
		TEMP=${C[-1]}
		unset C[-1]
		C=("${C[@]}")
		if [ $3 == "A" ]; then			
			A+=($TEMP);
		elif [ $3 == "B" ]; then
			B+=($TEMP);
		fi
	fi
	
	

        ## Recursive call to the hanai_exchange function !!!!!
        hanai_exchange $(($1-1)) $4 $3 $2
}

SOURCE="A"
HELP="B"
DEST="C"

A=()
B=()
C=()
peg=("A" "B" "C")

echo Input the number of disks in the tower :
read INPUT

for ((i = $INPUT ; i > 0 ; i-- )); do 
	A+=($i); 
done


hanai_exchange $INPUT $SOURCE $DEST $HELP
graphic_gen

