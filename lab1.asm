.model small
.stack 100h
.data
a dw 6
b dw 5
c dw 5
d dw 11

.code
.386
start:
    mov ax, @data
    mov ds, ax

    mov ax, a
    mov bx, ax
    mul bx
    mul bx

    mov cx, ax  

    mov ax, b
    mov bx, ax
    mul bx
    mov bx, ax

    cmp cx, bx
    jg  FirstIfTrue
    jle FirstIfFalse

        FirstIfTrue:
        mov ax, c
        mov bx, d
        mul bx
        mov cx, ax

        mov ax, a
        mov bx, b
        div bx
        mov dx, ax

        cmp cx, dx
        je FirstResult
        jne SecondResult

        FirstResult:
        mov ax, a
        mov bx, b 
        and ax, bx
        jmp TheEnd

        SecondResult:
        mov ax, a
        cmp ax, b
        jg next1
        jle next2
        next1: mov ax, b
        next2: cmp ax, c
        jg next3
        jle next4
        next3: mov ax, c
        next4: cmp ax, d
        jg next5
        jle next6
        next5: mov ax, d
        next6: mov bx, ax

        cmp ax, b   
        jg next7
        jle next8
        next7: cmp bx, b
        je next8
        jne next9
        next9: mov ax, b

        next8:
        cmp ax, c   
        jg next10
        jle next11
        next10: cmp bx, c
        je next11
        jne next12
        next12: mov ax, c

        next11:
        cmp ax, d   
        jg next13
        jle next14
        next13: cmp bx, d
        je next14
        jne next15
        next15: mov ax, d

        next14:
        mov dx, bx
        mov cx, ax
        mul dx
        jmp TheEnd
    
    FirstIfFalse:
    mov ax, c
    mov bx, d
    mul bx
    add ax, b

TheEnd:  
int   21h
end start   
