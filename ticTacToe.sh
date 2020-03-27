#!/bin/bash -x

#FUNCTION TO RESET THE BOARD
function reset(){
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

reset
assign
toss
print
