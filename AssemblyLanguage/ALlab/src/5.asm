dseg    segment
    ; data1   db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    ; data2   db 1, 3, 5, 7, 9, 11, 13, 15, 17, 19
    ; data1   db -1, -2, -3, -4, -5, -6, -7, -8, -9, -10
    ; data2   db -1, -3, -5, -7, -9, -11, -13, -15, -17, -19
    data1   db 1, -2, 3, -4, 5, -6, 7, -8, 9, -10
    data2   db 1, -3, 5, -7, 9, -11, 13, -15, 17, -19
    len     db 10
    sum     db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
dseg    ends

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

    lea  di, data1              ; di存data1
    call my_abs                ; 调用绝对值处理程序处理data1
    lea  di, data2              ; di存data2
    call my_abs                ; 调用绝对值处理程序处理data2

    lea  di, data1              ; di存data1
    lea  si, data2              ; si存data2
    lea  bx, sum                ; bx存sum
    call add_seg

    mov  ah, 4ch                ; 结束程序
    int  21h

; 绝对值计算子程序
; 输入: di作为字段的起始地址，中途会使用到cx
; 输出: di位置改变
; 修改: 字段元素将被替换为绝对值
my_abs proc near
    xor  ch, ch                 ; ch清零
    mov  cl, [len]              ; 数组长度
do_abs:  
    cmp  byte ptr [di], 0       ; 与0比较
    jge  is_positive            ; 正数或0
    neg  byte ptr [di]          ; 负数取补
is_positive:
    inc  di                     ; 下一个地址
    loop do_abs                ; 循环执行，用len控制循环次数
    ret
my_abs endp

; 加法计算子程序
; 输入: di数组1起始地址, si数组2起始地址，bx为输出数组的起始地址，中途会使用到al、cx
; 输出：bx为数组1加数组2的起始地址
; 修改：bx为输出数组、di、si数组内容被修改
add_seg proc near
    xor  ch, ch                 ; ch清零
    mov  cl, [len]              ; 数组长度
do_add:
    mov  al, byte ptr [di]      ; 从di指向的地址加载
    add  al, byte ptr [si]      ; 相加
    mov  [bx], al               ; 结果存储到sum数组
    inc  di
    inc  si
    inc  bx
    loop do_add
    ret
add_seg endp

cseg ends
    end start
