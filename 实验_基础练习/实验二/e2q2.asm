stack	segment stack
		dw 512	dup(?)
stack	ends
data	segment
		x dw 0 
		y dw 0
		z dw 0
		mes1 db 'Please input x: $';,0dh,0ah,'$'
		mes2 db 'Please input y: $';,0dh,0ah,'$'
		mes3 db 'The result is: $';,0dh,0ah,'$'
data	ends
code	segment ;z=f(x,y)=x*y+x-y
assume	cs:code,ds:data,ss:stack
start:	mov ax,data						
		mov ds,ax
 
        mov ah,09h	;����x
       	mov dx,offset mes1
        int 21h		
		call input
		mov x,ax
 
		mov ah,09h	;����y
       	mov dx,offset mes2
        int 21h
		call input
		mov y,ax;
 
		;����
		push x
		push y
		call func
 
		mov z,ax
		mov ah,09h
        mov dx,offset mes3
        int 21h
		mov ax,z
		call output
		jmp done
 
func	proc 
		push bp
		mov bp,sp
		push bx
		push cx
		
		mov cx,[bp+6];��ȡx
		mov bx,[bp+4];��ȡy
 
		mov ax,cx
		imul bx
		add ax,cx
		sub ax,bx
 
		pop cx
		pop bx
		pop bp
		
		ret 4
func	endp
 
input proc 
		push bx
        push cx
        push dx
		xor bx,bx;bx������
		xor cx,cx;cxΪ������־��0Ϊ����1Ϊ��
		mov ah,1;����һ���ַ�
		int 21h
		cmp al,'+';�ǡ�+�������������ַ�
		jz input1
		cmp al,'-';�ǡ�-��
		jnz input2
		mov cx,-1;����-1��־
input1:
		mov ah,1
		int 21h
input2:
		cmp al,'0';����0~9֮����ַ������������ݽ���
		jb input3
		cmp al,'9'
		ja input3
		sub al,30h;��0~9֮����ַ�����ת��Ϊ��������
		
		shl bx,1;������λָ�ʵ����ֵ��10��BX<-BX*10
		mov dx,bx
		shl bx,1
		shl bx,1
		add bx,dx
		mov ah,0
		add bx,ax;��������ֵ��10������������ֵ���
		jmp input1;���������ַ�
input3:
		cmp cx,0;�Ǹ�����������
		jz input4
		neg bx
input4:
		mov ax,bx;���ó��ڲ���
		pop dx
		pop cx
		pop bx
		ret;�ӳ��򷵻�
 
output proc near
        push ax
        push bx
        push dx
        test ax,ax
        jnz output1
        mov dl,'0'
        mov ah,2
        int 21h
        jmp output5
output1:
		jns output2
        mov bx,ax
        mov dl,'-'
        mov ah,2
        int 21h
        mov ax,bx
        neg  ax
output2:
		mov bx,10
        push bx
output3:
		cmp ax,0
        jz output4
        sub dx,dx
        div bx
        add dl,30h
        push dx
        jmp output3
output4:
		pop dx
        cmp dl,10
        je output5
        mov ah,2
        int 21h
        jmp output4
output5: 
		pop dx
        pop bx
        pop ax
        ret
 
done:	
		mov ah,4ch
		int 21h
code	ends
		end start
��������������������������������
��Ȩ����������ΪCSDN������һͷ���˾�����ԭ�����£���ѭCC 4.0 BY-SA��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
ԭ�����ӣ�https://blog.csdn.net/qq_52791068/article/details/122703493