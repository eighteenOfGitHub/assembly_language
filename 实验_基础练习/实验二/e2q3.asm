stack	segment stack
stack	ends
data    segment
oldisr  dw ?,?
timer   db 100
counter dw 0
isdone  db 0
data    ends
    
code    segment
assume	cs:code,ds:data
start:  
        mov ax,data;��data������ax							
	    mov ds,ax;������ת�����ݶμĴ���
 
        mov ax,0
        mov es,ax

        cli;CLI
        mov ax,es:[1ch*4]
        mov oldisr[0],ax
        mov ax,es:[1ch*4+2]
        mov oldisr[2],ax
        sti	

        cli
        mov word ptr es:[1ch*4],offset isr
        mov word ptr es:[1ch*4+2],seg isr
        sti

 
waithere:
        cmp isdone,1
        jnz waithere
exit:
        cli
        mov ax,oldisr[0]
        mov es:[1ch*4],ax
        mov ax,oldisr[2]
        mov es:[1ch*4+2],ax;�ָ�ԭ�жϴ���
        sti
 
        mov ax,4c00h
        int 21h
 
isr proc far
        push dx
        push ax
 
        mov ax,data
        mov ds,ax
 
        sti;�����ж�Ƕ��             
        inc timer
again:
        cmp timer,1000/55;18
        jb done
        mov timer,0
 
        mov ah,2
        mov dl,13
        int 21h
 
        mov ax,counter
 
        mov dl,10
        div dl
        mov dh,ah
        mov dl,al
        mov ah,2
        add dl,30h
        int 21h
        mov dl,dh
        add dl,30h
        int 21h
        
        inc counter
        cmp counter,90 
        jnz done
        mov isdone,1;������ɱ�־   
        
done:
        pushf
        call dword ptr oldisr;����ԭ�жϴ���
        cli
        pop ax
        pop dx
        iret;�жϷ���
isr     endp
 
code    ends
        end start