SSEG    SEGMENT STACK                   ; 堆栈段开始
STACK   DB  100h DUP (?)                ; 定义堆栈空间
SSEG    ENDS                            ; 堆栈段结束

DSEG    SEGMENT                                    ; 数据段开始
TABLE   DB  0, 1, 4, 9, 16, 25, 36, 49, 64, 81     ; 平方值表
DATA    DB  0
DSEG    ENDS                                       ; 数据段结束

CSEG    SEGMENT                         ; 代码段开始
    ASSUME CS:CSEG, DS:DSEG, SS:SSEG    ; 设置段寄存器

START:
    ; 输入数字
    MOV AX, DSEG                        ; 初始化数据段
    MOV DS, AX

    MOV AH, 01H                         ; 设置功能号为01h（读取字符）
    INT 21H                             ; 调用中断读取一个字符到al

    CMP AL, '0'                         ; 比较al（输入字符）是否小于'0'
    JB  Exit                            ; 如果小于'0'，退出
    CMP AL, '9'                         ; 比较al是否大于'9'
    JA  Exit                            ; 如果大于'9'，退出

    ; 计算其平方值
    SUB AL, '0'
    MOV BX,  OFFSET TABLE               ; 获取偏移地址
    XLAT                                ; 查表匹配平方值
    MOV DATA, AL                        ; 保存平方值

    ; 显示平方值
    XOR AH, AH                          ; 清除AH，以便使用AX的低字节AL
    MOV BL, DATA                        ; 将平方值复制到BL用于显示
    MOV CX, 10                          ; 设置除数为10
    DIV CL                              ; AX / CL -> AL=商(十位), AH=余数(个位)
    MOV BX, AX                          ; 保存除法结果

    ; 显示十进制
    MOV DL, ' '                         ; 显示空格
    MOV AH, 02H
    INT 21H

    MOV AL, BL                          ; 将BX的高字节（十位）移至AL
    ADD AL, '0'                         ; 转换为ASCII码
    CMP AL, '0'                         ; 检查是否有十位
    JE  DisplayOnes
    MOV DL, AL                          ; 显示十位
    MOV AH, 02H
    INT 21H

DisplayOnes:
    MOV DL, BH                          ; 显示个位
    ADD DL, '0'                         ; 转换为ASCII码
    MOV AH, 02H
    INT 21H

    ; 显示十六进制
    MOV DL, ' '                         ; 显示空格
    MOV AH, 02H
    INT 21H

    MOV AL, DATA                        ; 将平方值加载到AL
    MOV BL, AL                          ; 将平方值复制到BL
    MOV AH, 0                           ; 清零AH，用于存储高四位的十六进制表示

    MOV CL, 4
    SHR AL, CL                          ; AL中的值右移4位，高四位移动到低四位
    CALL DisplayHex                     ; 显示高四位的十六进制表示

    MOV AL, BL                          ; 重新加载原始值
    AND AL, 0Fh                         ; AL与0Fh进行与操作，提取低四位
    CALL DisplayHexOnes                 ; 显示低四位的十六进制表示

    JMP Exit                            ; 跳转到退出

; 子程序：显示一个字节的十六进制表示
DisplayHex:
    CMP AL, 9                           ; 比较AL是否小于等于9
    JBE AddAsciiZero                    ; 如果是，加上'0'的ASCII值
    ADD AL, 7                           ; 否则，加上7（将'A'-'F'调整到正确的ASCII范围）

AddAsciiZero:
    ADD AL, '0'                         ; 加上'0'的ASCII值来得到正确的字符
    CMP AL, '0'                         ; 检查是否有十位
    JE  SkipHex
    MOV DL, AL                          ; 将字符加载到DL
    MOV AH, 02H                         ; 准备显示字符
    INT 21H
SkipHex:
    RET                                 ; 返回到调用点

DisplayHexOnes:
    CMP AL, 9                           ; 比较AL是否小于等于9
    JBE AddAsciiZeroOnes                ; 如果是，加上'0'的ASCII值
    ADD AL, 7                           ; 否则，加上7（将'A'-'F'调整到正确的ASCII范围）

AddAsciiZeroOnes:
    ADD AL, '0'                         ; 加上'0'的ASCII值来得到正确的字符
    MOV DL, AL                          ; 将字符加载到DL
    MOV AH, 02H                         ; 准备显示字符
    INT 21H
    RET                                 ; 返回到调用点

Exit:
    MOV AH, 4CH                         ; 设置退出功能号
    INT 21H                             ; 调用中断退出程序

CSEG    ENDS
    END START
