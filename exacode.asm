#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

    BCF PORTC, 0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC, 1		;exec
    CALL time
    BCF PORTC, 1
    CALL time
  
    GOTO    START

MAIN_PROG CODE                      ; let linker place main program

START
 
BIN1 equ 0x20
Resultado equ 0x21
Cont equ 0x22
BIN2 equ 0x23
 
i equ 0x30
j equ 0x31
k equ 0x32
ind equ 0x33
mae equ 0x34

START
    BANKSEL PORTA
    CLRF PORTA
    BANKSEL ANSEL
    CLRF ANSEL
    CLRF ANSELH
    BANKSEL TRISA
    MOVLW d'0'
    MOVWF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    MOVLW b'11111100'
    CLRF TRISE
    BCF STATUS, RP1
    BCF STATUS, RP0
    BCF PORTC, 1
    BCF PORTC, 0
    
INITLCD
    MOVLW 0x3F
    MOVWF ind
    
    MOVLW 0xD0
    MOVWF mae
    
    BCF PORTC, 0	;reset
    MOVLW 0x01
    MOVWF PORTD
    
    CALL exec
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    CALL exec
    
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    CALL exec

INICIO
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    CALL commandmode
    MOVLW 0x88		;LCD position 1
    MOVWF PORTD
    CALL exec
    CALL datamode
    
    ;leer primer numero binario
    BTFSC PORTA,7    ;MAS SIGNIFICATIVO
    CALL mandauno
    BTFSS PORTA,7   
    CALL mandacero
    
    BTFSC PORTA,6    
    CALL mandauno
    BTFSS PORTA,6    
    CALL mandacero
    
    BTFSC PORTA,5    
    CALL mandauno
    BTFSS PORTA,5    
    CALL mandacero
    
    BTFSC PORTA,4    
    CALL mandauno
    BTFSS PORTA,4    
    CALL mandacero
    
    BTFSC PORTA,3    
    CALL mandauno
    BTFSS PORTA,3    
    CALL mandacero
    
    BTFSC PORTA,2 
    CALL mandauno
    BTFSS PORTA,2 
    CALL mandacero
    
    BTFSS PORTA,1 
    CALL mandacero
    BTFSC PORTA,1 
    CALL mandauno
    
    BTFSC PORTA,0 
    CALL mandauno
    BTFSS PORTA,0 
    CALL mandacero
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Leer mas o menos
    CALL commandmode
    MOVLW 0xC6		;LCD position 2
    MOVWF PORTD
    CALL exec
    CALL datamode
    
    BTFSS PORTE,2 
    CALL mandamenos
    BTFSC PORTE,2 
    CALL mandamas
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    CALL commandmode
    MOVLW 0xC8		;LCD position 2 
    MOVWF PORTD
    CALL exec
    CALL datamode
    
    ;leer segundo num binario
    
    BTFSC PORTB,7    ;mas significativo
    CALL mandauno
    BTFSS PORTB,7   
    CALL mandacero 
    
    BTFSC PORTB,6
    CALL mandauno
    BTFSS PORTB,6   
    CALL mandacero
    
    BTFSC PORTB,5    
    CALL mandauno
    BTFSS PORTB,5    
    CALL mandacero
    
    BTFSC PORTB,4    
    CALL mandauno
    BTFSS PORTB,4    
    CALL mandacero 
    
    BTFSC PORTB,3    
    CALL mandauno
    BTFSS PORTB,3    
    CALL mandacero
    
    BTFSC PORTB,2 
    CALL mandauno
    BTFSS PORTB,2 
    CALL mandacero
    
    BTFSS PORTB,1 
    CALL mandacero
    BTFSC PORTB,1 
    CALL mandauno 
    
    BTFSC PORTB,0	
    CALL mandauno
    BTFSS PORTB,0 
    CALL mandacero
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    CALL commandmode
    MOVLW 0x96		;LCD position 3
    MOVWF PORTD
    CALL exec
    CALL datamode
    
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    CALL commandmode
    MOVLW 0xD7		;LCD position 4
    MOVWF PORTD
    CALL exec
    CALL datamode
    
    MOVFW PORTA
    MOVWF BIN1
    MOVFW PORTB 
    MOVWF BIN2
    
    BTFSC PORTE,2    
    CALL suma   
    BTFSS PORTE,2   
    CALL resta
    
    ;imprime resultado
    BTFSC Resultado,7    ;mas significativo
    CALL mandauno
    BTFSS Resultado,7   
    CALL mandacero 
    
    BTFSC Resultado,6
    CALL mandauno
    BTFSS Resultado,6   
    CALL mandacero
    
    BTFSC Resultado,5    
    CALL mandauno
    BTFSS Resultado,5    
    CALL mandacero
    
    BTFSC Resultado,4    
    CALL mandauno
    BTFSS Resultado,4    
    CALL mandacero 
    
    BTFSC Resultado,3    
    CALL mandauno
    BTFSS Resultado,3    
    CALL mandacero
    
    BTFSC Resultado,2 
    CALL mandauno
    BTFSS Resultado,2 
    CALL mandacero
    
    BTFSS Resultado,1 
    CALL mandacero
    BTFSC Resultado,1 
    CALL mandauno 
    
    BTFSC Resultado,0	
    CALL mandauno
    BTFSS Resultado,0 
    CALL mandacero
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       
    GOTO INICIO

commandmode
    BCF PORTC,0
    CALL time
    RETURN

datamode
    BSF PORTC,0
    CALL time
    RETURN
    
mandauno 
    MOVLW '1'
    MOVWF PORTD
    CALL exec
    RETURN
    
mandacero
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    RETURN
    
mandamas 
    MOVLW '+'
    MOVWF PORTD
    CALL exec
    RETURN

mandamenos 
    MOVLW '-'
    MOVWF PORTD
    CALL exec
    RETURN
    
suma
    MOVFW PORTB
    ADDWF BIN1,W
    MOVWF Resultado
    BTFSS STATUS,C
    CALL mandacero
    BTFSC STATUS,C
    CALL mandauno
    RETURN
 
resta 
    MOVFW PORTB
    SUBWF BIN1,W
    MOVWF Resultado
    BTFSC STATUS,C
    CALL mandacero
    BTFSS STATUS,C
    CALL negativo
    RETURN
    
negativo
    MOVLW '-'
    MOVWF PORTD		;ESPACIO 0
    CALL exec 
    COMF Resultado,1
    MOVLW b'00000001'
    ADDWF Resultado,1
    RETURN    
    
    RETURN
    
exec

    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i,f
    GOTO $-1
    DECFSZ j,f
    GOTO ciclo
    RETURN    
    


END