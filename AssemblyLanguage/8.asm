;数据段data
dseg segment
    count   dw 1
    time db '00:00:00',0dh,0ah,'$'    ;时间显示信息：hour:minute:second
dseg ends

sseg    segment  stack
    stack   db  100h  dup  (?)
sseg    ends

cseg segment
    assume  cs:cseg, ds:dseg
main proc near
start:
    ; 初始化
    mov     ax, dseg
    mov     ds, ax
    mov     ax, sseg
    mov     ss, ax
    mov     sp, 100h

    ; 保存原中断向量
    ; 将中断号1Ch（时钟滴答中断）加载到AL寄存器。
    ; 在此上下文中，AL寄存器用于指定接下来的DOS中断调用将操作哪个中断号。
    mov     al, 1ch
    ; 将 DOS 功能号35h加载到 AH 寄存器。AH为35h时，表示调用的是“获取中断向量”的功能。
    ; 允许程序查询系统中任何中断的当前处理程序地址。
    mov     ah, 35h
    int     21h                   ;获取1ch中断向量到es：bx
    ; 寄存器的内容推入堆栈，推栈操作保存值。
    ; 不加就按不了字符了
    push    es
    push    bx
    push    ds
    
    ;设置新的中断向量
    ; 这条指令将新的中断处理程序 intprocess 的偏移地址存储到 DX 寄存器中。
    ; offset 关键字用于获取标签或函数的内存偏移地址。
    mov     dx, offset intprocess
    ; 这条指令将新的中断处理程序 intprocess 的段地址存储到 AX 寄存器中
    ; seg 关键字用于获取标签或函数的段地址。
    mov     ax, seg intprocess
    ; 这条指令设置数据段寄存器 DS 为新的中断处理程序的段地址
    ; 因为 DOS 中断 25h 使用 DS:DX 作为参数来设置中断向量。
    mov     ds, ax
    ; 加载 1Ch 中断号到 AL 寄存器，指定要设置的是哪一个中断向量。
    mov     al, 1ch
    ; 将 DOS 功能号 25h（设置中断向量）加载到 AH 寄存器。
    mov     ah, 25h
    int     21h                   ;设置中断向量ds：dx
    pop     ds
    in      al, 21h               ;读中断屏蔽寄存器
    ; 通过逻辑与操作清除屏蔽寄存器中的最低位，即允许中断 0 （通常是系统时钟中断）发生。
    ; 位掩码 11111110b 确保除了最低位外的所有位保持不变，从而只允许相关的中断。
    and     al, 11111110b         ;开定时器中断
    out     21h, al               ;写中断屏蔽寄存器
    sti                           ;开中断
;等待中断
do_while:
    mov     ah, 1
    int     21h
    cmp     al, 'q'                ;'q'退出
    jz      quit
    jmp     do_while
;恢复
quit:
    pop     dx
    pop     ds
    mov     al, 1ch ; 时钟滴答中断
    mov     ah, 25h ; 设置中断向量
    int     21h ; 中断向量恢复
    ;调色、位置（跳出时钟效果后的背景色以及字体颜色）
    mov     ah, 00h ; 设置视频模式
    mov     al, 03h ; 文本模式
    int     10h
    mov     ah, 6
    mov     al, 0                 ; 屏幕为空白
    mov     bh, 00000111b         ; 背景色恢复
    mov     ch, 0                 ; 左上角x坐标
    mov     cl, 0                 ; 左上角y坐标
    mov     dh, 99h               ; 右下角x坐标
    mov     dl, 99h               ; 右下角y坐标
    int     10h
    ; 结束程序
    mov     ah, 4ch
    int     21h
main endp

intprocess proc near
    ; 保护数据
    push    ds
    push    ax
    push    bx
    push    cx
    push    dx

    sti     ; 该指令设置处理器的中断标志，允许中断被处理
    dec     count ; 计数器减一
    jnz     exit
    call    displaytime ; 为0显示时间
    mov     count, 18 ; 计数器加
exit:    
    cli ; 关闭中断
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    pop     ds
    iret ; 中断服务例程的标准结束指令
intprocess endp

displaytime proc near
    push    ax
    push    bx
    push    cx
    push    dx
    push    si
    ;获取系统时间：
    ; 入口：ah存2ch
    ; ch存hour
    ; cl存minute
    ; dh存second
    mov     ah, 2ch ; 设置AH寄存器为 2ch，用于获取系统时间。
    ; 调用中断 21h 执行获取时间的功能
    ; 返回的时间将被存放在 ch、cl 和 dh 寄存器中，分别表示小时、分钟和秒。
    int     21h
    ; 小时
    mov     bl, 10                ; 用作后面的除法运算基数
    lea     si, time              ; 读文件
    mov     al, ch                ; 处理小时
    xor     ah, ah                ; 清除高位
    div     bl                    ; 执行除法
    add     al, 30h               ; 转ASCII
    add     ah, 30h               ; 转ASCII
    mov     [si], ax              ; 储存
    ; 分
    add     si, 3                 ; 指针移动，处理分钟
    mov     al, cl                ; 处理分钟
    xor     ah, ah                ; 清除高位
    div     bl                    ; 执行除法
    add     al, 30h               ; 转ASCII
    add     ah, 30h               ; 转ASCII
    mov     [si], ax              ; 储存
    ; 秒
    add     si, 3                 ; 指针移动，处理秒钟
    mov     al, dh                ; 处理秒钟
    xor     ah, ah                ; 清除高位
    div     bl                    ; 执行除法
    add     al, 30h               ; 转ASCII
    add     ah, 30h               ; 转ASCII
    mov     [si], ax              ; 储存
    ; 显示
    mov     ah, 02h               ; 设置AH寄存器为 02h，用于显示字符串。
    mov     bh, 0h                ; 页号
    mov     dh, 17h               ; 行号
    mov     dl, 42h               ; 列号
    int     10h

    ; 放置一个窗口遮罩
    mov     ah, 6
    mov     al, 0                 ; 屏幕为空白
    mov     bh, 01110000b         ; 背景色0000黑色
    mov     ch, 0                 ; 左上角x坐标
    mov     cl, 0                 ; 左上角y坐标
    mov     dh, 99h               ; 右下角x坐标
    mov     dl, 99h               ; 右下角y坐标
    int     10h

    ;显示时间字符串
    mov     dx, offset time       ; 提取最终要显示的时间
    mov     ah, 09h               ; 中断21h，用于显示字符串直到遇到$
    int     21h
    
    pop     si
    pop     dx
    pop     cx
    pop     bx
    pop     ax
    ret
displaytime endp

cseg ends
    end     start
