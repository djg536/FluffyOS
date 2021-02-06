print_char:   ;(al: letter to print, e.g. mov al, 'A')
                pusha                       ;push all register values to stack
                mov ah , 0x0e               ;Set the screen mode to teletype
                int 10h
                popa                        ;restore all register values from stack
                ret

print_string:   ;(bx: the address of the string)
                pusha
        loop:   mov al, [bx] ;[ch] ;mov al, 'A' ;Warning: only BX can be used as an index!
                cmp al, 0
                je done

                add bx, 1
                call print_char

                jmp loop
        done:   popa
                ret

print_newline:  ;()
                pusha
                mov al, 0Dh;                ;\r
                call print_char
                mov al, 0Ah;                ;\n
                call print_char
                popa
                ret

read_char:      ;()                         ;don't use pusha/popa here or the function will not return anything
                mov ah, 00h
                int 16h
                ret                         ;(ah=scan code,al=ascii char)

console_colours:;()
                pusha
                mov ah, 09h                 ;Set the screen colours
                mov cx, 1000h               ;number of times to print    
                mov al, ' '                 ;space character
                mov bl, 70h                 ;(bl: foreground/background colour)
                int 10h
                popa
                ret