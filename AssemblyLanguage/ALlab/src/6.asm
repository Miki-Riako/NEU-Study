dseg   segment
    data1       db 0
    data2       db 0
    operation   db 0
dseg   ends

sseg    segment  stack
    stack   db  100h  dup  (?)
sseg    ends

cseg    segment
    assume cs:cseg, ds:dseg, ss:sseg
start:
    mov  ax, dseg               ; 初始化
    mov  ds, ax
    mov  ax, sseg
    mov  ss, ax
    mov  sp, 100h

    mov ah, 01h                 ; 设置功能号为01h（读取字符）
    int 21h                     ; 调用中断读取一个字符到al
    mov data1, al               ; 将读取的字符存储到data1

    mov ah, 01h                 ; 设置功能号为01h（读取字符）
    int 21h                     ; 调用中断读取一个字符到al
    mov operation, al           ; 将读取的字符存储到operation

    mov ah, 01h                 ; 设置功能号为01h（读取字符）
    int 21h                     ; 调用中断读取一个字符到al
    mov data2, al               ; 存储到data2

    mov al, operation
    cmp al, '+'
    je  my_add
    cmp al, '-'
    je  my_sub
    cmp al, '*'
    je  my_mul
    cmp al, '/'
    je  my_div

my_add:
    mov  al, data1
    add  al, data2
    jmp  return

my_sub:
    mov  al, data1
    sub  al, data2
    jmp  return

my_mul:
    mov  al, data1
    mul  data2
    jmp  return

my_div:
    xor  ax, ax
    mov  al, data1
    div  data2
    jmp  return

return:
    mov  ah, 02h                 ; 设置功能号为02h（输出字符）
    int  21h                     ; 调用中断输出字符

    mov  ah, 4ch                 ; 结束程序
    int  21h

cseg    ends
    end  start
