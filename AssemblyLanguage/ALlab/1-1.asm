DSEG    SEGMENT               ;数据段定义开始
DATA1   DB    13H, 26H        ;定义数据数组
DATA2   DW    0               ;定义一个数据字
DSEG    ENDS                  ;数据段定义结束

SSEG    SEGMENT    STACK      ;堆栈段定义开始
SKTOP   DB         20 DUP(0)  ;定义堆栈段数组
SSEG    ENDS                  ;堆栈段定义结束

CSEG    SEGMENT               ;代码段定义开始
ASSUME  CS:CSEG, DS:DSEG
ASSUME  SS:SSEG

START:  MOV    AX, DSEG
        MOV    DS, AX
        MOV    AX, SSEG
        MOV    SS, AX
        MOV    SP, LENGTH SKTOP
        MOV    AL, DATA1
        ADD    AL, DATA1 +1
        MOV    BYTE PTR DATA2, AL
        MOV    AH, 4CH
        INT    21H

CSEG    ENDS
        END    START
