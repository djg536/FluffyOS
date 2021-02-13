print_char:             ;(al: letter to print, e.g. mov al, 'A')
                        pusha                       ;push all register values to stack
                        mov ah , 0Eh                ;Set the screen mode to teletype
                        int 10h
                        popa                        ;restore all register values from stack
                        ret


print_string_newline:   ;()
                        call print_string
                        call print_newline
                        ret

print_string:           ;(bx: the address of the string)
                        pusha
        ws_loop:        mov al, [bx]                ;mov al, 'A' ;Warning: only BX can be used as an index!
                        cmp al, 0
                        je ws_done

                        add bx, 1
                        call print_char

                        jmp ws_loop
        ws_done:        popa
                        ret

clear_line:             ;()                        ;clears the text on the current line
                        pusha
                        mov al, [data_newline_r]
                        call print_char

                        mov ch, 0

                        mov al, ' '
        cl_loop:        call print_char
                        add ch, 1
                        cmp ch, 78
                        jle cl_loop

                        mov al, [data_newline_r]
                        call print_char

                        popa
                        ret


print_newline:          ;()                         
                        pusha
                        mov al, [data_newline_r]                 ;\r
                        call print_char
                        mov al, [data_newline_n]                 ;\n
                        call print_char
                        popa
                        ret

read_char:              ;()                         ;don't use pusha/popa here or the function will not return anything
                        mov ah, 00h
                        int 16h
                        ret                         ;(ah=scan code,al=ascii char)

set_console_colours:    ;()                                     ;set the colours of the console
                        pusha
                        mov ah, 09h                             
                        mov cx, 1000h                           ;number of times to print    
                        mov al, ' '                             ;space character
                        mov bl, [data_console_colours]          ;foreground/background colour
                        int 10h
                        popa
                        ret


                        data_console_colours:   db 70h
                        data_newline_n:         db 0Ah          ;\n
                        data_newline_r:         db 0Dh          ;\r