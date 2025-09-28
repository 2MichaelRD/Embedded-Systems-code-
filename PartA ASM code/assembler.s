/* REFERENCES USED

https://community.st.com/t5/stm32cubeide-mcus/how-to-run-assembly-code-in-stm32-cube-ide-nucleo-f446re/m-p/139119
https://developer.arm.com/documentation/dui0489/e/arm-and-thumb-instructions/memory-access-instructions/push-and-pop
https://forums.raspberrypi.com/viewtopic.php?t=258550
I also used chatGPT, I used chatgpt to help me understand how to properly use the PUSH and POP in arm assembly and
create the proper delays

*/                                                                                                      
.syntax unified
.thumb
.text

.global ASM_Function
.type ASM_Function, %function


.equ RCC_BASE,      0x40023800
.equ RCC_AHB1ENR,   (RCC_BASE + 0x30)

.equ GPIOA_BASE,    0x40020000
.equ GPIOA_MODER,   (GPIOA_BASE + 0x00)
.equ GPIOA_BSRR,    (GPIOA_BASE + 0x18)

.equ LED_PIN,       5
.equ UNIT,          5000000

ASM_Function:

    LDR r0, =RCC_AHB1ENR
    LDR r1, [r0]
    ORR r1, r1, #(1 << 0)
    STR r1, [r0]

    /* Set PA5 as output */
    LDR r0, =GPIOA_MODER
    LDR r1, [r0]
    BIC r1, r1, #(0x3 << (LED_PIN*2))
    ORR r1, r1, #(0x1 << (LED_PIN*2))
    STR r1, [r0]

repeat_name:
    BL morse_M
    BL letter_space
    BL morse_I
    BL letter_space
    BL morse_C
    BL letter_space
    BL morse_H
    BL letter_space
    BL morse_A
    BL letter_space
    BL morse_E
    BL letter_space
    BL morse_L

    BL word_space

    BL morse_D
    BL letter_space
    BL morse_O
    BL letter_space
    BL morse_N
    BL letter_space
    BL morse_A
    BL letter_space
    BL morse_H
    BL letter_space
    BL morse_U
    BL letter_space
    BL morse_E

    BL word_space

    B repeat_name

dot:
    PUSH {lr}
    LDR r0, =GPIOA_BSRR
    MOV r1, #(1 << LED_PIN)
    STR r1, [r0]

    MOV r2, #1
    BL delay_units

    MOV r1, #(1 << (LED_PIN+16))
    STR r1, [r0]

    MOV r2, #1
    BL delay_units
    POP {pc}

dash:
    PUSH {lr}
    LDR r0, =GPIOA_BSRR
    MOV r1, #(1 << LED_PIN)
    STR r1, [r0]

    MOV r2, #3
    BL delay_units

    MOV r1, #(1 << (LED_PIN+16))
    STR r1, [r0]

    MOV r2, #1
    BL delay_units
    POP {pc}

letter_space:
    PUSH {lr}
    MOV r2, #2         /*add two to keep morse standards* 1:3:7*/
    BL delay_units
    POP {pc}

word_space:
    PUSH {lr}
    MOV r2, #6               /*add 6 to keep morse standards for spacing*/
    BL delay_units
    POP {pc}

delay_units:
    PUSH {r4,lr}
    LDR r3, =UNIT
    MUL r2, r2, r3

delay_loop:
    SUBS r2, r2, #1
    BNE delay_loop
    POP {r4,pc}

morse_M:
    PUSH {lr}
    BL dash
    BL dash
    POP {pc}

morse_I:
    PUSH {lr}
    BL dot
    BL dot
    POP {pc}

morse_C:
    PUSH {lr}
    BL dash
    BL dot
    BL dash
    BL dot
    POP {pc}

morse_H:
    PUSH {lr}
    BL dot
   BL dot
    BL dot
    BL dot
    POP {pc}

morse_A:
    PUSH {lr}
    BL dot
    BL dash
    POP {pc}

morse_E:
    PUSH {lr}
    BL dot
    POP {pc}

morse_L:
    PUSH {lr}
    BL dot
    BL dash
    BL dot
    BL dot
    POP {pc}

morse_D:
	PUSH {lr}
	BL dash
	BL dot
	BL dot
	POP {pc}

morse_O:
	PUSH {lr}
	BL dash
	BL dash
	BL dash
	POP {pc}

morse_N:
	PUSH {lr}
	BL dash
	BL dot
	POP {pc}

morse_U:
	PUSH {lr}
	BL dot
	BL dot
	BL dash
	POP {pc}

