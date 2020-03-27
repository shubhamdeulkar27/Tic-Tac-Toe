#!/bin/bash -x

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

reset
assign
toss
print
gameCheck

#CHECKING WIN OR TIE OR TURN PLAYER
if [ $gameStatus != 1 ]
then
	echo "Game Over"
	echo "$player Win"
elif [ $gameStatus == 1 ] && [ $turnCounter == 9 ]
then
	echo "Its A Tie"
else
	if [ $player == $PLAYER ]
	then
		player=$CPU
	else
		player=$PLAYER
	fi
fi
