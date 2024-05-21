stack	segment stack
		dw 512 dup(?)
stack	ends
data	segment
		array 	db 1,2,3,4,5,6,7,8,9,10
				db 11,12,13,14,15,16,17,18,19,20
				db 21,22,23,24,25,26,27,28,29,30
				db 31,32,33,34,35,36,37,38,39,40
				db 41,42,43,44,45,46,47,48,49,50
		count 	dw 50
		min dw ?
		max dw ?
		avg dw 0
		num dw 0
		temparr db ?
		minni db 'The min of grade is:',13,10,'$'
		maxxa db 'The max of grade is:',13,10,'$'
		avggv db 'The avg of grade is:',13,10,'$'
		nextline db 13,10,'$'
data	ends
code	segment	'code'
		assume	cs:code, ds:data, ss:stack
start:	mov		ax,data
		mov 	ds,ax
		
		mov		ax,0			;偏移地址
		mov 	si,ax
		xor		ax,ax			;清零
		xor		bx,bx
		mov 	bh,array[si+25]	;最大数
		mov		bl,array[si+25]	;最小数
		mov		cx,count		;学生总数（循环次数）
		
getsum:	cmp		bh,array[si]	;取最大
		jnb		next1
		mov		bh,array[si]
next1:	cmp		bl,array[si]	;取最小
		jna		next2
		mov		bl,array[si]
next2:	add		al,array[si]	;求和
		adc 	ah,0
		add		si,1
		loop	getsum
		mov		num,ax
		div		count
		mov		avg,ax
		mov     ah,0
		mov 	al,bl
		cbw
		mov		min,ax
		mov 	al,bh
		cbw
		mov		max,ax

		
		lea 	dx,minni			;输出提示
		mov 	ah,9
		int 	21h					
		mov		bx,min				;输出
		call	value2ascii
		mov 	dx,offset  nextline	;换行
		mov 	ah,9
		int 	21h
		
		lea 	dx,maxxa
		mov 	ah,9
		int 	21h
		mov		bx,max
		call	value2ascii
		;lea 	dx,max
		;mov 	ah,9
		;int 	21h
		mov 	dx,offset  nextline
		mov 	ah,9
		int 	21h
		
		lea 	dx,avggv
		mov 	ah,9
		int 	21h
		mov		bx,avg
		call	value2ascii
		;lea 	dx,avg
		;mov 	ah,9
		;int 	21h
		mov 	dx,offset  nextline
		mov 	ah,9
		int 	21h
		
		mov 	ax,4c00h
		int		21h	
		
value2ascii proc
	push 	si
	mov 	temparr,0
	mov		si,0
	mov		ax,0
rotate:
	mov		ax,bx	;取个位
	mov  	bl,10
	div		bl
	mov		bl,al	;保存商
	add		ah,30h	;转ascii码
	mov		temparr[si],ah	;保存结果
	inc		si		
	cmp		bl,0	;如果商为零，就结束
	ja		rotate
output:
	dec		si		;输出
	mov 	dl,temparr[si]
	mov		ah,2
	int 	21h
	cmp		si,0
	ja		output
	pop 	si
	ret
value2ascii endp
		
code	ends
		end start