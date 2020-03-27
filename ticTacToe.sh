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

reset
assign
toss
