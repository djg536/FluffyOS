                [org 0x7c00]                ;Position in memory of start of code when loaded - not an instruction but an assembler flag

                jmp start                   ;This is important, to prevent the system just running the includes

                %include "console.asm" 

        start:  

                call console_colours

                mov al, 'D'
                call print_char
                mov al, 'A'
                call print_char
                mov al, 'V'
                call print_char
                mov al, 'E'
                call print_char
                call print_newline



                mov bx, message
                call print_string
                call print_newline
                mov bx, description
                call print_string
                call print_newline

        loop2:  call read_char
                call print_char
                jmp loop2

                jmp $                       ;Jump loop to halt the program

                                            ;Declare data
                message:        db 'Hello, World!',0
                description:    db 'I am written in 8086 assembly, which is from the 1970s!',0

                times 510-($-$$) db 0       ;Padding to ensure 512 bytes
                dw 0xaa55                   ;2 byte signature indicating that this is a valid boot sector

