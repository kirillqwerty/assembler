model small
.data
    GeneralMessage db 10, 13, "Enter 2-digits numbers$"
    messageA db 10, 13, "Enter a: $"
    messageB db 10, 13, "Enter b: $"
    messageC db 10, 13, "Enter c: $"
    messageD db 10, 13, "Enter d: $"
    ErrorMessage db 10, 13, "Incorrect symbols, use only (0,1,2,3,4,5,6,7,8,9) $"
    ResultMessage db 10, 13, "Result: $"
    ErrorA db 10, 13, "Error ('a' can be <= 40) $"
    ErrorSymbols db 10, 13, "Error (Only 2-digits numbers allowed)$"
    ErrorLine db 10, 13, "Error (Empty line)$"
    DivisionByZero db 10, 13, "Error (Division by zero)$"
    MinusSignPlace db 10, 13, "Error (Minus can be only on the first position of the number)$"
    ResultNegativeTrue dw 0
    NegativeA dw 0
    NegativeB dw 0
    NegativeC dw 0
    NegativeD dw 0
    MinusSign dw 0
    DigitsCounter dw 0
    Checker dw 0
    tens dw 0
    ones dw 0
    counter dw 0
    a dw 0
    b dw 0
    c dw 0
    d dw 0
    res dw 0
    
.stack 
    db 256 dup('?')

.code
.386
    ErrorBelowZero:
        mov ah, 9 
        mov dx, offset ErrorMessage
        int 21h
        jmp start    

    ErrorAboveNine:
        mov ah, 9 
        mov dx, offset ErrorMessage
        int 21h
        jmp start
    
    ErrorTooBigA:
        mov ah, 9 
        mov dx, offset ErrorA
        int 21h
        jmp start

    ErrorTooManySymbols:
        mov ah, 9 
        mov dx, offset ErrorSymbols
        int 21h
        jmp start

    ErrorEmptyLine:
        mov ah, 9 
        mov dx, offset ErrorLine
        int 21h
        jmp start

    ErrorDivisionByZero:
        cmp Checker, 1
        je Ok2
        mov ah, 9 
        mov dx, offset DivisionByZero
        int 21h
        jmp start
    
    ErrorMinusSignPlace:
        mov ah, 9 
        mov dx, offset MinusSignPlace
        int 21h
        jmp start

    DivisionByZeroChecker:
        add Checker, 1
        jmp Ok1

    CheckEnter:
        mov dl, al
        cmp dl, 13
        jne ErrorTooManySymbols
        jmp EnterOn
    
    CheckMinusSign:
        cmp DigitsCounter, 0
        jne ErrorMinusSignPlace
        cmp MinusSign, 1
        je ErrorMinusSignPlace
        xor dx, dx
        add MinusSign, 1
        cmp counter, 1 
        je MakeNegativeA
        cmp counter, 2 
        je MakeNegativeB
        cmp counter, 3 
        je MakeNegativeC
        cmp counter, 4 
        je MakeNegativeD

    CheckNegative:
        cmp counter, 1 
        je CompletedA
        cmp counter, 2 
        je CompletedB
        cmp counter, 3 
        je CompletedC
        cmp counter, 4 
        je CompletedD

    MakeNegativeA:
        add NegativeA, 1
        jmp pointA

    MakeNegativeB:
        add NegativeB, 1
        jmp pointB

    MakeNegativeC:
        add NegativeC, 1
        jmp pointC

    MakeNegativeD:
        add NegativeD, 1
        jmp pointD
    
    ResultNegative:
        mov ResultNegativeTrue, 1
        neg res
        jmp Output
    
    PrintMinusSign:
        mov al, 2Dh
        int 29h
        jmp printed
           
    Input:
        EnteringA:
            mov MinusSign, 0
            add counter, 1
            mov ah, 9 
            mov dx, offset messageA
            int 21h
            mov cx, 3
            xor ax, ax
            mov DigitsCounter, 0
            pointA:
            mov ah, 1h
            int 21h 
            mov dl, al
            cmp dl, 2Dh
            je CheckMinusSign
            add DigitsCounter, 1
            cmp DigitsCounter, 3
            je CheckEnter
            cmp dl, 13
            je EnterOn
            sub dl, 30h 
            cmp dx, 0
            jl ErrorBelowZero
            cmp dx, 9
            jg ErrorAboveNine
            push dx
            loop pointA

        EnteringB:
            cmp ax, 40
            jg ErrorTooBigA
            cmp ax, 0
            je DivisionByZeroChecker
            Ok1:
            cmp MinusSign, 0
            jne CheckNegative
            CompletedA:
            mov a, ax
            mov MinusSign, 0
            add counter, 1
            mov ah, 9 
            mov dx, offset messageB
            int 21h
            mov cx, 3
            xor ax, ax
            mov DigitsCounter, 0
            pointB:
            mov ah, 1h
            int 21h 
            mov dl, al
            cmp dl, 2Dh
            je CheckMinusSign
            add DigitsCounter, 1
            cmp DigitsCounter, 3
            je CheckEnter
            cmp dl, 13
            je EnterOn
            sub dl, 30h 
            cmp dx, 0
            jl ErrorBelowZero
            cmp dx, 9
            jg ErrorAboveNine
            push dx
            loop pointB 

        EnteringC:
            cmp ax, 0
            je ErrorDivisionByZero
            Ok2:
            cmp MinusSign, 0
            jne CheckNegative
            CompletedB:
            mov b, ax
            mov MinusSign, 0
            add counter, 1
            mov ah, 9 
            mov dx, offset messageC
            int 21h
            mov cx, 3
            xor ax, ax
            mov DigitsCounter, 0
            pointC:
            mov ah, 1h
            int 21h 
            mov dl, al
            cmp dl, 2Dh
            je CheckMinusSign
            add DigitsCounter, 1
            cmp DigitsCounter, 3
            je CheckEnter
            cmp dl, 13
            je EnterOn
            sub dl, 30h 
            cmp dx, 0
            jl ErrorBelowZero
            cmp dx, 9
            jg ErrorAboveNine
            push dx
            loop pointC

        EnteringD:
            cmp MinusSign, 0
            jne CheckNegative
            CompletedC:
            mov c, ax
            mov MinusSign, 0
            add counter, 1
            mov ah, 9 
            mov dx, offset messageD
            int 21h
            mov cx, 3
            xor ax, ax
            mov DigitsCounter, 0
            pointD:
            mov ah, 1h
            int 21h 
            mov dl, al
            cmp dl, 2Dh
            je CheckMinusSign
            add DigitsCounter, 1
            cmp DigitsCounter, 3
            je CheckEnter
            cmp dl, 13
            je EnterOn
            sub dl, 30h 
            cmp dx, 0
            jl ErrorBelowZero
            cmp dx, 9
            jg ErrorAboveNine
            push dx
            loop pointD

        EnterOn:
        cmp DigitsCounter, 1
        je ErrorEmptyLine
        xor ax, ax
        pop ones
        cmp DigitsCounter, 2
        je OneDigit
        pop tens
        mov ax, tens
        mov bx, 10
        mul bx
        OneDigit: 
        add ax, ones
        cmp counter, 1
        je EnteringB
        cmp counter, 2
        je EnteringC
        cmp counter, 3
        je EnteringD
        
        cmp MinusSign, 0
        jne CheckNegative
        CompletedD:
        mov d, ax

    ret

start: 
    
    mov ax, @data
    mov ds, ax 

    mov ah, 9 
    mov dx, offset GeneralMessage
    int 21h

    mov counter, 0
    mov NegativeA, 0
    mov NegativeB, 0
    mov NegativeC, 0
    mov NegativeD, 0

    call Input

    cmp NegativeA, 1
    je NegA
    jne PosA
    NegA:
    neg a
    PosA:

    cmp NegativeB, 1
    je NegB
    jne PosB
    NegB:
    neg b
    PosB:
    
    cmp NegativeC, 1
    je NegC
    jne PosC
    NegC:
    neg c
    PosC:

    cmp NegativeD, 1
    je NegD
    jne PosD
    NegD:
    neg d
    PosD:
    
    mov ax, a
    mov bx, ax
    imul bx
    imul bx  
    mov cx, ax
    ;mov ResACube, ax
    ;mov ResACubeNeg, 1  

    mov ax, b
    mov bx, ax
    mul bx
    mov bx, ax

    mov ax, NegativeA
    mov dx, NegativeB
    
    cmp ax, dx
    ja FirstIfFalse

    cmp cx, bx
    ja  FirstIfTrue
    jbe FirstIfFalse

        FirstIfTrue:
        mov ax, c
        mov bx, d
        imul bx
        mov cx, ax

        mov ax, a
        mov bx, b
        idiv bx
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
            imul ax
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
        imul dx
        jmp TheEnd
    
    FirstIfFalse:
        mov ax, c
        mov bx, d
        imul bx
        add ax, b

    TheEnd:
 
        mov res, ax
        cmp res, 0 
        jl ResultNegative
        
        Output:
        mov ah, 9 
        mov dx, offset ResultMessage
        int 21h

       
        cmp ResultNegativeTrue, 1
        je PrintMinusSign
 
        printed:
        mov ax, res
        xor cx, cx
        xor dx, dx
        mov	bx, 10

        isDiv:		
            xor	dx,dx
            div	bx
            push	dx
            inc	cx
            or	ax,ax
            jnz	isDiv

        isOut:		
            pop	ax
            or	al, 30h
            int	29h
            loop	isOut
            int 21h

end start
