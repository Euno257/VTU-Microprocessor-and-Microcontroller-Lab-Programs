.MODEL SMALL
.DATA
    A DW 2220h,7770H,4440H,1110H,5550H
    LEN DW ($-A)/2
.CODE
    MOV AX,@DATA
    MOV DS,AX

    MOV CX,2

OUTLOOP: MOV DX,CX
        DEC DX
        MOV SI,DX
        ADD SI,SI
        MOV AX,A[SI]

INLOOP:  CMP A[SI-2],AX
         JBE INEXIT

         MOV DI,A[SI-2]   ;swaping
         MOV A[SI],DI

         DEC SI
         DEC SI
         DEC DX
         JNZ INLOOP

INEXIT: MOV A[SI],AX
        INC CX
        
        CMP CX,LEN
        JBE OUTLOOP

        MOV AH,4CH
        INT 21H
END
