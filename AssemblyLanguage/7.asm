dseg segment
    filename    db 32, 0, 32 dup(?)    ; 输入文件名缓冲区，最大长度32个字符
    errmsg      db 'File Error! $'     ; 错误信息字符串
    buff        db 255 dup(?)          ; 文件读取缓冲区，最大255个字节
    writename   db 32, 0, 32 dup(?)    ; 输出文件名缓冲区，最大长度32个字符
dseg ends

sseg segment stack 
    db 100h dup(0)
sseg ends

cseg segment
    assume cs:cseg, ds:dseg, ss:sseg
main proc far
start:
    push    ds                        ; 保存DS寄存器
    xor     ax, ax                    ; 清零AX寄存器
    push    ax                        ; 将0推入栈中，用作返回地址
    mov     ax, dseg                  ; 加载数据段地址到AX
    mov     ds, ax                    ; 设置DS寄存器
    ; 读取文件名到filename
    lea     dx, filename              ; 加载filename的地址到DX
    mov     ah, 0ah                   ; DOS中断读取字符串功能
    int     21h                       ; 调用DOS中断
    mov     dl, 0ah                   ; 输出换行符
    mov     ah, 2                     ; DOS中断显示字符功能
    int     21h                       ; 调用DOS中断
    ; 打开文件以读取
    mov     bl, filename+1
    xor     bh, bh
    mov     [bx+filename+2], bh       ; 设置字符串结束标志
    lea     dx, filename+2
    mov     ax, 3d00h                 ; DOS中断打开文件功能，模式为读取
    int     21h                       ; 调用DOS中断
    jc      return                    ; 如果出错，跳转到错误处理
    mov     bx, ax                    ; 保存文件句柄到BX
do_while:
    ; 从文件中读取数据
    mov     cx, 512                   ; 设置读取的字节数
    lea     dx, buff                  ; 设置缓冲区地址
    mov     ah, 3fh                   ; DOS中断读文件功能
    int     21h                       ; 调用DOS中断
    jc      return                    ; 如果出错，跳转到错误处理
    mov     cx, ax                    ; 保存读取的字节数到CX
    cmp     cx, 512                   ; 检查是否读满
    je      do_while                  ; 如果满，则继续读取
    mov     ah, 3eh                   ; 关闭文件
    int     21h
    ; 文件写入
    lea     dx, writename             ; 加载writename地址到DX
    mov     ah, 0ah                   ; DOS中断读取字符串功能
    int     21h                       ; 调用DOS中断
    mov     bl, writename+1
    xor     bx, bx
    mov     [bx+writename+2], bh      ; 设置字符串结束标志
    lea     dx, writename+2
    mov     ax, 3d01h                 ; DOS中断打开文件功能，模式为写入
    int     21h                       ; 调用DOS中断
    jc      return                    ; 如果出错，跳转到错误处理
    mov     bx, ax                    ; 保存文件句柄到BX
    lea     dx, buff                  ; 设置缓冲区地址
    mov     ah, 40h                   ; DOS中断写文件功能
    int     21h                       ; 调用DOS中断
    jc      return                    ; 如果出错，跳转到错误处理
    mov     ah, 3eh                   ; 关闭文件
    int     21h
    ret
return:
    ; 错误处理
    lea dx, errmsg
    mov ah, 9
    int 21h                           ; 显示错误信息
    ret
main endp

cseg ends
    end main