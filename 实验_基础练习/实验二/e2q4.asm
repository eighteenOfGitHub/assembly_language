stack segment stack
	dw 512 dup(?)
stack ends
data segment
	buffer db 50,?,50 dup('$')
	y db 'Yes$'
	n db 'No$'
data ends
code segment
	assume cs:code,ds:data,ss:stack
start:
	mov ax,data
	mov ds,ax
	
	mov ah,0ah
	lea dx,buffer
	int 21h
	mov ah,2
	mov dl,0ah
	int 21h
	mov ah,2
	mov dl,0dh
	int 21h
	mov ah,9
	lea dx,buffer[2]
	int 21h
	mov dl,buffer[1]
	mov bx,2
again:
	cmp dl,3
	jb no
	cmp buffer[bx],'a'
	jz next
	inc bx
	dec dl
	jmp again
next:
	inc bx
	dec dl
	cmp buffer[bx],'s'
	jz next1
	jmp again
next1:
	dec dl
	inc bx
	cmp buffer[bx],'m'
	jz yes
	jmp again
yes:
	mov ah,2
	mov dl,0ah
	int 21h
	mov ah,2
	mov dl,0dh
	int 21h
	mov ah,9
	lea dx,y
	int 21h
	jmp done
no:
	mov ah,2
	mov dl,0ah
	int 21h
	mov ah,2
	mov dl,0dh
	int 21h
	mov ah,9
	lea dx,n
	int 21h
done:
	mov ah,4ch
	int 21h
 
code ends
 end start
