stack	segment stack
		dw 512 dup(?)		;��ջ�εĴ�СΪ512�ֽڣ�1KB���ռ�
stack	ends

data	segment
	v dw 30
	x dw 3
	y dw 123
	z dw 21
	sum1 dw ?
	sum2 dw ?
data 	ends

code	segment	'code'
		assume	cs:code, ds:data, ss:stack
start:	mov		ax,data
		mov 	ds,ax
		
		mov 	ax,x
		imul	y
		mov		cx,ax
		mov 	bx,dx		;����x*y��BX:CX��
		
		mov 	ax,z
		cwd					;��չ�Ĵ���DX
		add		cx,ax
		adc 	bx,dx		;���Ͻ�λ
		
		sub		cx,720		;X*Y+Z-720
		sbb		bx,0
		
		mov		ax,v
		cwd
		sub		ax,cx		;V-(X*Y+Z-720)
		sbb		dx,bx
		
		idiv	x			;V-(X*Y+Z-720)
		mov		sum1,ax		;��
		mov		sum2,dx		;����
		
		mov 	ax,4c00h
		int		21h	
code	ends

		end 	start