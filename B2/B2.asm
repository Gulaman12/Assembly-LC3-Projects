; login name - ater906
; This program is my own unaided work, and was not copied,
; nor written in collaboration with any other person.
; Angelo Terminez	
	.orig 	x3000
askuser
	lea	r0, prompt
	puts
	lea	r1, input	; r1 has the address of input
	and	r2, r2, #0	; clear r2 (counter)
loop				
	getc			;ask user to type character its ascii code stored in r0
	add	r2, r2, #1	;add to counter by 1 each time loop a character is inputted
	str 	r0, r1, #0	;address of r1+0 is stored in memory allocated space

	add	r1, r1, #1	;address incremented by 1 (so uses next inputbuffer)
	putc			;outputs character to console
	add	r0, r0, #-10	;r0 = r0 + -10 to check ascii was an enter
	brz	check		;will branch if enter key used
	br	loop		;was not an enter

fibonacci
	halt

reask	
	br	askuser		; restarts program (invalid input)
check	
	add	r2, r2, #-2	; if counter is zero means that size of input was 1 character long
	brz	singlechar	; branches to test if single character is valid
	brp	morechar	; branches to test 2 or more character length is valid
	
singlechar
	ld	r3, input	;loads user input
	ld	r4, digit3	;loads number 3
	add	r3, r3, r4	;
	brn	reask		;if less than 3 will restart program
	ld	r3, input	;loads user input 
	ld	r4, digit9	;loads number 9
	add	r3, r3, r4	;
	brp	reask		;if greater than ascii value 9 its invalid
	br	fibonacci	;valid input, branches to print fibbonacci pattern
morechar
	add 	r2, r2, #-1	;if counter still positive it means user input more than 3 char length(not in the bounds of 3-23)			
	brp	reask
	ld	r3, input	;loads first digit of number
	ld 	r5, digit0	;loads number 0
	add	r5, r3, r5	;if result less than ascii value 0 (its invalid) so restart program
	brn	reask		
	ld	r4, digit2	;loads number 2
	add	r3, r3, r4	;if result is greater than 3 means digit is value in range (invalid input)
	brp	reask		;so restart program
	brz	twentydigit	;if result = 0 means it is an number in the 20's
	lea	r3, input	
	ldr	r3, r3, #1	;loads 2nd digit
	ld 	r4, digit9	;
	add	r3, r3, r4	;test if number is not greater than ascii value 9
	brnz	fibonacci	;valid input, branches to print fibonacci pattern

twentydigit	
	lea	r3, input	;
	ldr	r3, r3, #1	;loads 2nd digit
	ld	r4, digit3	;loads number 3
	add 	r3, r3, r4	;if result > 3 it means input was higher than 23 (invalid
	brnz 	fibonacci	;if result passes (20-23) its a valid input, branches to print fibonacci pattern
	br	reask		;restarts program because input was invalid

	
prompt	.stringz "Enter a number from 3 to 23: "
input	.blkw 10
digit0	.blkw 1 #-48
digit3	.blkw 1 #-51
digit2	.blkw 1 #-50
digit9	.blkw 1 #-57
space	.blkw 1 #32
enter	.blkw 1 #10
	.end