
stack	segment stack
dw 512	dup(?)
stack	ends
data	segment
		table dw add1,add2,add3,add4,add5,add6,add7,add8;地址表
		string1 db 'The 1 Bit is 1 $'
		string2 db 'The 2 Bit is 1 $'
		string3 db 'The 3 Bit is 1 $'
		string4 db 'The 4 Bit is 1 $'
		string5 db 'The 5 Bit is 1 $'
		string6 db 'The 6 Bit is 1 $'
		string7 db 'The 7 Bit is 1 $'
		string8 db 'The 8 Bit is 1 $'
		string9 db 'No bit is 1 $'
data	ends
code	segment
assume	cs:code,ds:data,ss:stack
start:	mov ax, data						
		mov ds, ax
		mov al,00000001B
		mov si,0
		mov bl,00010000B
		cmp bl,0
		jz error
		mov cx,8
again:
		test bl,al
		jz next
		jmp table[si]
next:
		shl al,1
		add si,2;指向下一地址
		loop again
add1:
		mov dx,offset string1
		jmp print
add2:
		mov dx,offset string2
		jmp print
add3:
		mov dx,offset string3
		jmp print
add4:
		mov dx,offset string4
		jmp print
add5:
		mov dx,offset string5
		jmp print
add6:
		mov dx,offset string6
		jmp print
add7:
		mov dx,offset string7
		jmp print
add8:
		mov dx,offset string8
		jmp print
error:
		mov dx,offset string9
		mov ah,09h
		int 21h
print:
		mov ah,09h
		int 21h
 
		mov ah,4ch
		int 21h
code	ends
		end start
