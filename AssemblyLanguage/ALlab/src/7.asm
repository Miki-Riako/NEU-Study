dseg segment
    filename    db 14, 0, 14 dup(?)
    errmsg      db 'File Error! $'
    buff        db 512 dup(?)
    writename   db 14, 0, 14 dup(?)
dseg ends

sseg segment stack 
    db 80h dup(0)
sseg ends

cseg segment
    assume cs:cseg, ds:dseg, ss:sseg
main proc far
start:
    push    ds
    xor     ax, ax
    push    ax

    mov     ax, dseg
    mov     ds, ax

    lea     dx, filename
    mov     ah, 0ah               ; 把键盘输入的字符存入缓冲区然后把实际输入的数量存入filename+1
    int     21h
    mov     dl, 0ah               ; 这是换行�?
    mov     ah, 2                 ; 输出dl的字符到屏幕
    int     21h
    mov     bl, filename+1
    mov     bh, 0                 ; 这里是为了把bl扩展到bx�?
    mov     [bx+filename+2], bh   ; 文件名的最后放上一�?, bx是文件名的长�?
    lea     dx, filename+2        ; 把文件名的首地址取给dx
    mov     ax, 3d00h             ; ah�?d是打开文件的功能，al的内容是3种打开文件的格式，0=读，1=写，2=读和�?
    int     21h
    int     3
    jc      return             ; 如果文件打开出错的话跳转
    mov     bx, ax
do_while:
    mov     cx, 512            ; 每次读入的字节数
    lea     dx, buff           ; 把缓冲区的偏移地址取给dx，这样就可以把文件内容读进dx
    mov     ah, 3fh            ; 读取文件内容，如果读到文件尾部，ax�?，否则是实际读入�?
    int     21h
    jc      return             ; 如果出错了跳�?
    mov     cx, ax             ; 把实际读到的字节数给cx
    cmp     cx, 512            ; 没读完继续读
    je      do_while
    int     3
    mov     ah, 3eh            ; 关文�?
    int     21h

    ; 文件写入
    lea     dx, writename 
    mov     ah, 0ah            ; 把键盘输入的字符存入缓冲区（即ds:dx），然后把实际输入的数量存入filename+1
    int     21h
    mov     bl, writename+1
    mov     bh, 0
    mov     [bx+writename+2], bh
    lea     dx, writename+2
    mov     ax, 3d01h
    int     21h
    jc      return 
    mov     bx, ax
    lea     dx, buff
    mov     ah, 40h
    int     21h
    jc      return 
    mov     ah, 3eh
    int     21h
    ret
return:
    lea dx, errmsg
    mov ah, 9
    int 21h
    ret
main endp

cseg ends
    end main