@ Start of file HexToVal.s
@
@ Design and write an ARM assembly language program that
@ will convert an ASCII representation of a hexadecimal
@ value to a value. TestStr is a NULL-terminated string 
@ in memory and the converted value should be stored in 
@ register r0. TestStr will contain a maximum of 8
@ characters and may use both upper and lower case
@ charaters.


	.text

start:

@ Upload the code that goes between the dashed lines.
@ -------------- start cut ------------------------
@initialise registers 
    LDR r0, =TestStr
    LDR r3, =0x10000000
    LDR r5, =0
    LDR r8, =8
    LDR r9, =0

@loop to count the number of zeros 
loop:
    LDRB r10, [r0], #1
    CMP r10, #0 
    BNE branch 
    ADD r9, r9, #1

branch:
@count down 8 times. then load back to first bit 
    SUB r8, r8, #1
    CMP r8, #0
    BNE loop
    LDRB r1, [r0], #-8

loop1: 
@
    LDRB r1, [r0], #1
    MOV r5, r1
    @check if upper lower or number 
    MOV r2, r5, LSR #4
    @if number 
    CMP r2, #3
    BNE endif
    @subtract 30 to get value of ascii num char 
    SUB r1, r1, #0x30
    B skip

endif:
@letters
    CMP r2, #6
    BNE endif1
    SUB r1, r1, #0x60
    ADD r1, r1, #0x9
    B skip

endif1:
    CMP r2, #4
    BNE endif2
    SUB r1, r1, #0x40
    ADD r1, r1, #0x9
    B skip
endif2:
skip:
    MUL r7, r1, r3
    MOV r3, r3, LSR #4
    ADD r6, r6, r7
    CMP r1, #0
    BNE loop1
    CMP r9, #0
    BEQ branch1
    MOVS r9, r9
while:
    BEQ endwh
    MOV r6, r6, LSR #4
    SUB r9, r9, #1
    CMP r9, #0
    B while 
endwh:
branch1:
    MOV r0, r6

@ -------------- end cut --------------------------

stop:   B	stop
	.data
TestStr:	.asciz	"123aBc12"
	.end
@
@ End of file HexToVal.s