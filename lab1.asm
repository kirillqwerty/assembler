.model small
.stack 100h
.data
a dw 8
b dw 7
c dw 5
d dw 5 

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
        and bx, ax
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

        xor ax, ax
        cmp bx, a
        je check1
        jne continue1
        check1:
            add ax, 1
        continue1:
        cmp bx, b
        je check2
        jne continue2
        check2:
            add ax, 1
        continue2: 
        cmp bx, c
        je check3
        jne continue3
        check3:
            add ax, 1
        continue3:
        cmp bx, d
        je check4
        jne continue4
        check4:
            add ax, 1
        continue4:

        cmp ax, 2
        jge Result
        jl continue5

        Result:
            mov ax, bx
            mul ax
            jmp TheEnd

        continue5:
        mov ax, a   
        jg next7
        jle next8
        next7: cmp bx, a
        je next8
        jne next9
        next9: mov ax, a

        next8:
        cmp ax, b   
        jg next10
        jle next11
        next10: cmp bx, b
        je next11
        jne next12
        next12: mov ax, b

        next11:
        cmp ax, c   
        jg next13
        jle next14
        next13: cmp bx, c
        je next14
        jne next15
        next15: mov ax, c

        next14:
        cmp ax, d   
        jg next16
        jle next17
        next16: cmp bx, d
        je next17
        jne next18
        next18: mov ax, d

        next17:
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
