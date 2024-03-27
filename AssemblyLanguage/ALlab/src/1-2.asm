DSEG    SEGMENT
DATA1   DB    55H, -33
DATA2   DW    1234H, 'AB'
DATA3   DD    789ABCDEH

DSEG    ENDS

SSEG    SEGMENT    STACK
STACK   DB         100 DUP(0)
SSEG    ENDS

CSEG    SEGMENT
        ASSUME     CS:CSEG, DS:DSEG, SS:SSEG

START:  MOV        AX, DSEG
        MOV        DS, AX
        MOV        AX, SSEG
        MOV        SS, AX
        MOV        SP, 100

        MOV        AH, 4CH
        INT        21H 
CSEG    ENDS
        END        START

