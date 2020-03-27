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

reset
assign
echo $PLAYER
echo $CPU
