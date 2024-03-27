DSEG    SEGMENT                        ;数据段开始
DATA1   DB    13H, 26H                 ;原始数据
DATA2   DW    0                        ;保存结果单元
DSEG    ENDS                           ;数据段结束
SSEG    SEGMENT    STACK               ;堆栈段开始
SKTOP   DB         20 DUP(0)
SSEG    ENDS                           ;堆栈段结束
CSEG    SEGMENT                        ;代码段开始
        ASSUME     CS:CSEG, DS:DSEG
        ASSUME     SS:SSEG
START:  MOV        AX, DSEG            ;初始化数据段基址
        MOV        DS, AX
        MOV        AX, SSEG            ;初始化堆栈段基址
        MOV        SS, AX
        MOV        SP, LENGTH SKTOP    ;设置堆栈指针
        MOV        AL, DATA1           ;取第一个数据
        ADD        AL, DATA1+1         ;取第二个数据
        MOV        BYTE PTR DATA2, AL  ;保存结果
        MOV        AH, 4CH
        INT        21H                 ;返回DOS
CSEG    ENDS                           ;代码段结束
        END        START               ;源程序结束
