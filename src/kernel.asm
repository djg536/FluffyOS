                        org 7E00h   ;https://www.nasm.us/doc/nasmdoc8.html#section-8.1.1
                        bits 16

                        mov bx, msg_boot
                        call print_string_newline

                        mov bx, msg_prompt
                        call print_string
                        call read_char          ;halt until user input
                        call clear_line
                        call print_char         ;print the first keyboard press

        loop_type:      call read_char
                        call print_char
                        jmp loop_type                

                        %include "console.asm" 

                                                ;Declare data
                        msg_boot:     db "You're in the kernel!",0
                        msg_prompt:   db "Try typing :)",0

