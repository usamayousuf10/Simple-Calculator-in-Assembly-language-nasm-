org 100h

jmp start

msg: db '1-Addition' ,10, '2-Multiply',10, '3-Subtract',10, '4-Divide',10,  '5-Exit  $'
msg2: db 10, 'Enter First No : $'
msg3: db 10, 'Enter Second No : $'
;msg4: db 10, 'Wants to Enter More No Press Y/N : $'
;msg5: db 10,'Enter Third No : $' 
msg6: db 10, 'Error...PLease select above options only $'
msg7: db  10,'Result $'
msg8: db  10, 'Thank you for using calculator! press any key to exit... $'
msg9: db 10, 'Addition $'
msg10:  db 10, 'Multiplication $'
msg11:  db 10, 'Subtraction $'
msg12:  db 10, 'Division $'

clearscr:

	mov ah, 06h
	xor al, al
	mov ch, 0
	mov cl, 0
	mov dh, 24
	mov dl, 79
	mov bh, 07h
	int 10h
ret	
Addition:
	mov ah, 09h
	mov dx, msg9
	int 21h
	mov ah, 09h
	mov dx, msg2
	int 21h
	mov cx, 0
	call Inputno
	push dx	;second no
	mov ah, 9
	mov dx, msg3
	int 21h
	mov cx, 0
	call Inputno
	pop bx
	add dx, bx
	push dx 
	mov ah, 9
	mov dx, msg7
	int 21h
	pop dx
	mov cx, 10000
	call view
	jmp start
	
	
exit:	
	
	mov ah, 09h
	mov dx, msg8
	int 21h
	mov ah, 0
	int 16h
	ret	

view:
	mov ax, dx
	mov dx, 0
	div cx
	call viewno
	mov bx, dx
	mov dx, 0
	mov ax, cx
	mov cx, 10
	div cx
	mov dx, bx
	mov cx, ax
	cmp ax, 0
	jne view
	ret
		
Inputno:
	mov ah, 0 
	int 16h
	mov dx, 0
	mov bx, 1
	cmp al, 0dh
	je Formno
	sub ax, 30h
	call viewno
	mov ah, 0
	push ax
	inc cx
	jmp Inputno

Formno:
	pop ax
	push dx
	mul bx
	pop dx
	add dx, ax
	mov ax, bx
	mov bx, 10
	push dx
	mul bx
	pop dx
	mov bx, ax
	dec cx
	cmp cx, 0
	jne Formno
	ret
	
	
		
	
	
viewno:
	push ax
	push dx
	mov dx, ax
	add dl, 30h
	mov ah, 2
	int 21h
	pop dx
	pop ax
	ret	
	
Multiplication:
		mov ah, 09h
		mov dx, msg10
		int 21h
		mov ah, 09h
		mov dx, msg2
		int 21h
		mov cx, 0
		call Inputno
		push dx	;second no
		mov ah, 9
		mov dx, msg3
		int 21h
		mov cx, 0
		call Inputno
		pop bx
		mov ax, dx
		mul bx
		mov dx, ax
		push dx 
		mov ah, 9
		mov dx, msg7
		int 21h
		pop dx
		mov cx, 1000
		call view
		jmp exit

Subtraction:
		mov ah, 09h
		mov dx, msg11
		int 21h
		mov ah, 09h
		mov dx, msg2
		int 21h
		mov cx, 0
		call Inputno
		push dx	;second no
		mov ah, 9
		mov dx, msg3
		int 21h
		mov cx, 0
		call Inputno
		pop bx
		sub bx, dx  ;1st to second
		mov dx, bx  
		push dx 
		mov ah, 9
		mov dx, msg7
		int 21h
		pop dx
		mov cx, 10000
		call view
		jmp start

Division:
		mov ah, 09h
		mov dx, msg12
		int 21h
		mov ah, 09h
		mov dx, msg2
		int 21h
		mov cx, 0
		call Inputno
		push dx	;second no
		mov ah, 9
		mov dx, msg3
		int 21h
		mov cx, 0
		call Inputno
		pop bx
		mov ax, bx
		mov cx, dx
		mov dx, 0
		div cx
		mov dx, ax
		push dx 
		mov ah, 9
		mov dx, msg7
		int 21h
		pop dx
		mov cx, 100
		call view
		jmp exit
		
start:
	call clearscr
	mov ah, 9
	mov dx, msg
	int 21h
	mov ah, 0
	int 16h
	cmp al, 31h
	je Addition
	cmp al, 32h
	je Multiplication
	cmp al, 33h
	je Subtraction
	cmp al, 34h
	je Division
	cmp al, 35h
	je Exit  
	mov ah, 9
	mov dx, msg6
	int 21h
	mov ah, 0
	int 16h
	cmp al, 30h
	jmp start
		

	

Exit:
	
 	mov ax, 0x4c00
	int 21h
	
	



    
