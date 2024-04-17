dseg    segment
data    db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
; data    db -1, -2, -3, -4, -5, -6, -7, -8, -9, -10
; data    db 0, 1, -2, 3, -4, 5, -6, 7, -8, 9
count   db 10
meanp   db 0
meanm   db 0
dseg    ends

sseg    segment  stack
stack   db  100h  dup  (?)
sseg    ends

cseg    segment
    assume cs:cseg, ds:dseg, ss:sseg

start:
    mov ax, dseg           ; 初始化
    mov ds, ax
    mov ss, ax
    mov sp, 100h

    xor ax, ax             ; ax先清洗了再说
    xor bx, bx             ; bl, bh存正负数个数
    xor cx, cx             ; cl存循环次数
    lea si, data           ; 将数据的起始地址加载到SI寄存器
    mov cl, count          ; 设置循环次数
do:
    mov al, [si]           ; 从数据段中读取当前字节到AL
    inc si                 ; SI指向下一个字节
    cmp al, 1
    jge is_positive        ; 是正数
    cmp al, -1
    jle is_negative        ; 是负数
return_loop:
    loop do

; 计算平均值
    add bl, 0
    jz zero_jump
    mov al, meanp
    div bl
    mov meanp, al
zero_jump:

    add bh, 0
    jz zero_leap
    mov al, meanm
    div bh
    mov meanm, al
zero_leap:

    mov dl, meanp          ; 输出结果
    add dl, 30h
    mov ah, 02h
    int 21h

    mov dl, ' '
    mov ah, 02h
    int 21h

    mov dl, '-'
    mov ah, 02h
    int 21h

    mov dl, meanm
    add dl, 30h
    mov ah, 02h
    int 21h

    neg meanm              ; 最后记得将平均数取回成负数

    mov ah, 4ch            ; 结束程序
    int 21h

is_positive:
    add meanp, al
    inc bl
    jmp return_loop

is_negative:
    neg al                 ; 负数取反
    add meanm, al
    inc bh
    jmp return_loop

cseg    ends
    end start