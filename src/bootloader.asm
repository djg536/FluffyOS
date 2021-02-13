                        org 7C00h               ;Position in memory of start of code when loaded - not an instruction but an assembler flag
                        bits 16                 ;Tell the assembler to work in 16 bit mode here
                        
                        ;STACK SEGMENT:
                        mov ax, 0100h  
                        cli                     ;Disable interrupts to avoid bug on some CPUs
                        mov ss, ax               ;stack segment
                        mov sp, 2000h  
                        sti                     ;Enable interrupts

                        cld                     ;Set direction


                        call set_console_colours

                        mov al, 'D'
                        call print_char
                        mov al, 'A'
                        call print_char
                        mov al, 'V'
                        call print_char
                        mov al, 'E'
                        call print_char
                        call print_newline

                        mov bx, msg_hello
                        call print_string_newline
                        mov bx, msg_description
                        call print_string_newline
                        
                        call load_sector

                        mov bx, msg_boot
                        call print_string_newline

                        ;mov ax,07E0h
                        ;mov ds,ax              ;data segment 
                        ;Moving the data segment has a similar effect to adjusting the org, in that they both affect the final data label addresses

                        jmp 0x07E0:0x0000 ;jmp 0x7E00  ;=512d bytes + 7c00h


load_sector:            ;()
                        pusha
                        
                        mov ax, 07E0h                  ;Set up segments to load to
                        mov es, ax
                        mov bx, 0
                        jmp ls_read

        ls_error:       mov bx, msg_ls_error
                        call print_string_newline
                        mov ah, 00h
                        int 13h  
                        jmp ls_read

        ls_read:        mov ah, 02h
                        mov al, 10                     ;Number of sectors to read
                        mov ch, 0                      ;Track/cylinder number
                        mov cl, 2                      ;Sector number
                        mov dh, 0                      ;Head number
                        ;mov dl, 0                     ;Drive number is already set automatically when bootloader loaded, as the drive booted from
                        int 13h

                        jc ls_error       

                        mov bx, msg_ls_success
                        call print_string_newline

                        popa
                        ret



                        %include "console.asm"

                        ;Declare data
                        msg_hello:              db 'Hello, World!',0
                        msg_description:        db 'I am written in 8086 assembly, which is from the 1970s!',0
                        msg_ls_error:           db 'Failed to read the sector, retrying...',0
                        msg_ls_success:         db 'Sector read successful',0
                        msg_boot:               db 'Jumping to Kernel...',0

                

                        times 510-($-$$) db 0       ;Padding to ensure 512 bytes
                        dw 0xaa55                   ;2 byte signature indicating that this is a valid boot sector

