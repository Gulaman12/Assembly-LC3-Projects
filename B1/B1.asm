; login name - ater906
; This program is my own unaided work, and was not copied,
; nor written in collaboration with any other person.
; Angelo Terminez	
	.orig 	x3000
askuser
	lea		r0, prompt
	puts


	lea 		r1, digit 	; r1 has the address digit, contains (x3034) 
	and 		r2, r2, #0	; clear r2 (counter)
loop	
	getc				;ask user to type character its ascii code stored in r0
	add		r2, r2, #1	;add to counter by 1 each time a character is inputted
	str 		r0, r1, #0	;address of r1+0 is stored in memory allocated space

	add		r1, r1, #1	;address incremented by 1 (so uses next inputbuffer)
	putc				;outputs character to console
	add		r0, r0, #-10	;r0 = r0 + -10 to check enter
	brz		check		;will branch if enter key used
	br		loop		;continues to loop if no enter key yet
stop	
	halt

check	
	add		r2,r2, #-2	;will substact -2 from r2
	brz		checksv		;if r2=0 checkvalue it means user input was only 1 char long before enterkey
	brnzp 		stop		;if not zero halts 
checksv
	ld		r3, digit	;unloads value(ascii) stored in address of digit to r3	
	ld		r4, digit9	;unloads value stored in address of digit9 to r4
	add		r3, r3, r4	;adds user(asciivalue) + 9(-ve asciivalue) 
	brp		stop		;halt if number not negative or 0

binary	
	ld		r3, digit	;loads ascii value of digit into r3
	ld		r4, digit0	;loads ascii value of digit0 into r4
	add		r0, r3, r4	;adds r3 and r4 stores to r0
	add		r5, r3, r4	;adds r3 and r4 stores to r5
	add		r0, r0, r0	;
	add		r0, r0, r0	;
	add		r0, r5, r0	;gives the total number of addresses away user num in binary will be stored from number0 (0000)
	lea		r1, num0	;loads the address of number0 (x3041) into r1
	add		r0, r0, r1	;will add r0(distance to get to user binary value address) & r1 address, answer is stored in r0
	puts				;will print binary to screen
	ld		r0, enter	;will load newline address to r1	
	putc				;will enter address (enterkey)
	brnzp		askuser		;starts whole program again
	
prompt	.stringz	"Enter a digit: "
digit	.blkw		10
digit0	.blkw		1 #-48
digit9  .blkw		1 #-57
enter	.blkw 		1 #10


num0	.stringz	"0000"
num1	.stringz	"0001"
num2	.stringz	"0010"
num3	.stringz	"0011"
num4	.stringz	"0100"
num5	.stringz	"0101"
num6	.stringz	"0110"
num7	.stringz	"0111"
num8	.stringz	"1000"
num9	.stringz	"1001"
	.end