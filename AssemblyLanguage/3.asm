dseg    segment
data    db 1, 1, 1
; data    db -1, -1, -1
; data    db 0, 1, -1
dseg    ends

sseg    segment  stack
stack   db  100h  dup  (?)
sseg    ends

cseg    segment
    assume cs:cseg, ds:dseg, ss:sseg

start:
    ; 初始化
    mov ax, dseg
    mov ds, ax
    mov ax, sseg
    mov ss, ax
    mov sp, 100h
    xor ax, ax
    xor bx, bx
    xor cx, cx

    ; 加载第一个数据
    mov al, data
    cmp al, 1
    jge positive
    cmp al, -1
    jle negative
    jmp show_blank

positive:
    ; 第一个数据为正
    mov bl, data + 1
    cmp bl, 0
    jle show_blank
    ; 第二个数据为正
    mov cl, data + 2
    cmp cl, 0
    jle show_blank
    ; 第三个数据为正
    jmp show_positive

negative:
    ; 第一个数据为负
    mov bl, data + 1
    cmp bl, 0
    jge show_blank
    ; 第二个数据为负
    mov cl, data + 2
    cmp cl, 0
    jge show_blank
    ; 第三个数据为负
    jmp show_negative

show_blank:
    ; 显示空白
    mov dl, ' '
    mov ah, 02h
    int 21h
    jmp return

show_positive:
    ; 显示正号
    mov dl, '+'
    mov ah, 02h
    int 21h
    jmp return

show_negative:
    ; 显示负号
    mov dl, '-'
    mov ah, 02h
    int 21h

return:
    ; 结束程序
    mov ah, 4ch
    int 21h

cseg    ends
    end start
