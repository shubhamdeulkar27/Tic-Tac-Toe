#!/bin/bash -x

#VARIABLES
winMove="."
blockMove="."

#FUNCTION TO RESET THE BOARD
function reset(){
	gameStatus=1
	turnCounter=0
	board=(. . . . . . . . .)
}

#FUNCTION TO ASSIGN LETTER TO THE PLAYER
function assign(){
	random=$(( RANDOM%2 ))
	if (( $random==0 ))
	then
		PLAYER="X"
		CPU="O"
	else
		PLAYER="O"
		CPU="X"
	fi
}

#FUNCTION TO TOSS
function toss(){
	coin=$(( RANDOM%2 ))
	if (( $coin==0 ))
	then
		player=$PLAYER
	else
		player=$CPU
	fi
}

#FUNCTION TO PRINT BOARD
function print(){
	echo "r\c 0 1 2"
	echo "0   ${board[0]} ${board[1]} ${board[2]}"
	echo "1   ${board[3]} ${board[4]} ${board[5]}"
	echo "2   ${board[6]} ${board[7]} ${board[8]}"
}

#FUNCTIONS TO PLAY GAME
#FOR PLAYER
function playerPlay(){
	read -p "Enter r : " x
	read -p "Enter c : " y
	local index=$(( $x*3+$y ))
	if [ ${board[$index]} == "." ]
	then
		board[$index]=$PLAYER
	else
		echo "You can't place There."
		playerPlay
	fi
}
#FOR CPU(COMPUTER)
function cpuPlay(){
	local index=0
	checkWinMove
	checkBlockMove
	if [ $winMove != "." ]
	then
		index=$winMove
	elif [ $blockMove != "." ]
	then
		index=$blockMove
	elif [ $winMove == "." ] && [ $blockMove == "." ] &&
		  [ ${board[0]} == "." ] || [ ${board[2]} == "." ] ||
		  [ ${board[6]} == "." ] || [ ${board[8]} == "." ]
	then
		corner=$(( RANDOM%4 ))
		case $corner in
			0)
				index=0
			;;
			1)
				index=2
			;;
			2)
				index=6
			;;
			3)
				index=8
			;;
			*)
				echo "Invalid"
			;;
		esac
	elif [ $winMove == "." ] && [ $blockMove == "." ] &&
		  [ ${board[0]} != "." ] || [ ${board[2]} != "." ] ||
		  [ ${board[6]} != "." ] || [ ${board[8]} != "." ]
	then
		index=4
	else
		x=$(( RANDOM%3 ))
		y=$(( RANDOM%3 ))
		index=$(( $x*3+$y ))
	fi
	if [ ${board[$index]} == "." ]
	then
		board[$index]=$CPU
	else
		cpuPlay
	fi
}

#FUNCTION TO CHECK WIN
function check(){
	if [ ${board[$1]} != "." ] && [ ${board[$1]} == ${board[$2]} ] && [ ${board[$2]} == ${board[$3]} ]
	then
		gameStatus=0
	fi
}

function gameCheck(){
	check 0 1 2
	check 3 4 5
	check 6 7 8
	check 0 3 6
	check 1 4 7
	check 2 5 8
	check 0 4 8
	check 2 4 6
}

#FUNCTION FOR CHECKING WIN MOVE
function checkMove(){
	if [[ ${board[$1]} == "." ]] && [[ ${board[$2]} == $CPU ]] && [[ ${board[$3]} == $CPU ]] ||
		[[ ${board[$2]} == "." ]] && [[ ${board[$1]} == $CPU ]] && [[ ${board[$3]} == $CPU ]] ||
		[[ ${board[$3]} == "." ]] && [[ ${board[$2]} == $CPU ]] && [[ ${board[$1]} == $CPU ]]
	then
		if [ ${board[$1]} == "." ]
		then
			winMove=$1
		elif [ ${board[$2]} == "." ]
		then
			winMove=$2
		elif [ ${board[$3]} == "." ]
		then
			winMove=$3
		fi
	fi
}

function checkWinMove(){
	checkMove 0 1 2
	checkMove 3 4 5
	checkMove 6 7 8
	checkMove 0 3 6
	checkMove 1 4 7
	checkMove 2 5 8
	checkMove 0 4 8
	checkMove 2 4 6
}

#FUNCTION TO CHECK Opponent WIN MOVE AND BLOCK IT
function checkOpMove(){
	if [ ${board[$1]} == "." ] && [ ${board[$2]} == $PLAYER ] && [ ${board[$3]} == $PLAYER ] ||
		[ ${board[$2]} == "." ] && [ ${board[$1]} == $PLAYER ] && [ ${board[$3]} == $PLAYER ] ||
		[ ${board[$3]} == "." ] && [ ${board[$2]} == $PLAYER ] && [ ${board[$1]} == $PLAYER ]
	then
		if [ ${board[$1]} == "." ]
		then
			blockMove=$1
		elif [ ${board[$2]} == "." ]
		then
			blockMove=$2
		elif [ ${board[$3]} == "." ]
		then
			blockMove=$3
		fi
	fi
}

function checkBlockMove(){
	checkOpMove 0 1 2
	checkOpMove 3 4 5
	checkOpMove 6 7 8
	checkOpMove 0 3 6
	checkOpMove 1 4 7
	checkOpMove 2 5 8
	checkOpMove 0 4 8
	checkOpMove 2 4 6
}

#PLAYING GAME
reset
assign
toss
print
while [ true ]
do
	(( turnCounter++ ))
	if [ $player == $PLAYER ]
	then
		playerPlay
	elif [ $player == $CPU ]
	then
		cpuPlay
	fi
	print
	gameCheck

	#CHECKING WIN OR TIE OR TURN PLAYER
	if [ $gameStatus != 1 ]
	then
		echo "Game Over"
		echo "$player Win"
		break
	elif [ $gameStatus == 1 ] && [ $turnCounter == 9 ]
	then
		echo "Its A Tie"
		break
	else
		if [ $player == $PLAYER ]
		then
			player=$CPU
		else
			player=$PLAYER
		fi
	fi

	if [ $turnCounter == 9 ]
	then
		break
	fi
done
