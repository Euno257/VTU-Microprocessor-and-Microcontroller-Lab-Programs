.MODEL SMALL
.DATA
      A DW 1122H,2345H,3333H,4455H,6666H
      LEN DW ($-A)/2
      SRCH EQU 2345H
      SUCMSG DB 10,13,'ELEMENT FOUND AT POSITION: '
      RES DB ?,'$'
      FAILMSG DB 10,13,'ELEMENT NOT FOUND $'
.CODE
      MOV AX,@DATA
      MOV DS,AX

      MOV BX,1
      MOV CX,SRCH
      MOV DX,LEN

AGAIN: CMP BX,DX
       JA FAILURE

       MOV AX,BX
       ADD AX,DX
       SHR AX,1

       MOV SI,AX
       DEC SI
       ADD SI,SI

       CMP CX,A[SI]
       JAE BIGGER

       DEC AX
       MOV DX,AX
       JMP AGAIN

BIGGER: JE SUCCESS
        INC AX
        MOV BX,AX
        JMP AGAIN

SUCCESS: MOV AL, '0'
         MOV RES, AL
         LEA DX,SUCMSG
         JMP EXIT

FAILURE: LEA DX, FAILMSG

EXIT: MOV AH,09H
      INT 21H
      MOV AH,4CH
      INT 21H
END
