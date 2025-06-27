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
    sub al, 30h                 ; 将读取的字符转换为数字
    mov data1, al               ; 将读取的字符存储到data1

    mov ah, 01h                 ; 设置功能号为01h（读取字符）
    int 21h                     ; 调用中断读取一个字符到al
    mov operation, al           ; 将读取的字符存储到operation

    mov ah, 01h                 ; 设置功能号为01h（读取字符）
    int 21h                     ; 调用中断读取一个字符到al
    sub al, 30h                 ; 将读取的字符转换为数字
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
    jmp end_program

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
    mov  al, data2                ; 确保除数不为0
    add  al, 0
    jz   end_program

    xor  ax, ax
    mov  al, data1
    div  data2
    jmp  return

return:
    mov bl, al                   ; 将结果存储到bl
    mov dl, ' '                  ; 显示空格
    mov ah, 02h
    int 21h

    mov  dl, bl                   ; 显示结果
    add  dl, 0
    jns  is_positive
    mov  dl, '-'                  ; 显示负号
    mov  ah, 02h
    int  21h
    neg  bl

is_positive:
    xor  ax, ax
    mov  al, bl
    mov  bl, 10                   ; 结果可能比10更大，因此要转换为十进制输出。
    div  bl                       ; ah是余数，al是商
    mov  dl, al                   ; 商为十位数。
    mov  dh, ah                   ; 余数为个位

    add  al, 0
    jz   is_zero
    add  dl, 30h
    mov  ah, 02h                  ; 输出商
    int  21h

is_zero:
    mov  dl, dh
    add  dl, 30h                  ; 输出余数
    mov  ah, 02h
    int  21h

end_program:
    mov  ah, 4ch                 ; 结束程序
    int  21h

cseg    ends
    end  start
