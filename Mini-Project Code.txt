/*
 * Created: 11/13/2019 2:57:16 PM
 * Author : dariusghomashchian
 */ 

#include <stdio.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#define F_CPU 16000000UL
#include "util/delay.h"

unsigned char characterReceived;		//variable used to store received character from computer

int main (void) {
	
		//set up serial comm and output to LED's
		UCSR0B = (1<<RXEN0);	// Enable Receive
		UCSR0C = (1<<UCSZ01) | (1<<UCSZ00); //Setup serial: 8-bit data, 1 stop bit
		UBRR0L = 103;		//Sets baud rate
		DDRB = 0xFF; //Set port B as the output
		DDRD |= 0b10000000; //Set pin D7 as output too (we need 7 bits for 7-segment display)
		DDRB |= 0b00000000;
		
		
		//set up timers for PWM to servo
		DDRB |= 1 << PINB1; // Set pin 11 to output PWM
		// Setting WGM11, WGM12, WGM13 to 1 for fast PWM mode
		TCCR1A |= (1 << WGM11) | (1 << COM1A1); //setting COM1A1 non inverting (start PWM at beginning signal)
		TCCR1B |= (1 << WGM13) | (1 << WGM12) |(1 << CS11); //CS11 = pre-scale by 8
		ICR1 = 40000; //set top (end) of PWM period

	
	while(1)
	{
		while (!(UCSR0A&(1<<RXC0)));	//Wait for data to be received
		
		characterReceived = UDR0;			//Store received data in characterReceived
		
				
		if (characterReceived == '1')		//If character is '1' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 1
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					_delay_ms(200);			//Delay 0.5 seconds
				}
		
		if (characterReceived == '2')		//If character is '2' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 2
					PINB ^= (1<<5);			//Output 1 to PINB5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
				}
				
		if (characterReceived == '3')		//If character is '3' turn off LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 3
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<2);			//Output 1 to PINB2
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
				
					
				}
		
		if (characterReceived == '4')		//If character is '4' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 4
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<5);			//Output 1 to PINB5
					_delay_ms(200);			//Delay 0.5 seconds
					
				
					
				}
		
		if (characterReceived == '5')		//If character is '5' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 5
					PINB ^= (1<<5);			//Output 1 to PINB5
					PINB ^= (1<<4);			//Output 1 to PINB4
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
				}
		
		if (characterReceived == '6')		//If character is '6' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 6
					PINB ^= (1<<5);			//Output 1 to PINB5
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<3);			//Output 1 to PINB3
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<1);			//Output 1 to PINB2
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
				}
		
		if (characterReceived == '7')		//If character is '7' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 1
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<5);			//Output 1 to PIND5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
				}
		
		if (characterReceived == '8')		//If character is '8' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 8
					PINB ^= (1<<0);			//Output 1 to PINB0
					PINB ^= (1<<2);			//Output 1 to PINB2
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
					
				}
		
		if (characterReceived == '9')		//If character is '9' turn on LED
				{
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 9
					PINB ^= (1<<0);			//Output 1 to PINB0
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<5);			//Output 1 to PINB5
					PINB ^= (1<<4);			//Output 1 to PINB4
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					
					
				}
				
		if (characterReceived == 'a') 
		
		
				{
					//trigger prize servo
					
					OCR1A = 3999;	//-90 degrees
					_delay_ms(1000);
					OCR1A = 1800;	//0 degrees;	
					_delay_ms(1000);
					OCR1A = 3999;	//back to -90 degrees
					_delay_ms(1000);
					
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 8
					PINB ^= (1<<0);			//Output 1 to PINB0
					PINB ^= (1<<2);			//Output 1 to PINB2
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 8
					PINB ^= (1<<0);			//Output 1 to PINB0
					PINB ^= (1<<2);			//Output 1 to PINB2
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 8
					PINB ^= (1<<0);			//Output 1 to PINB0
					PINB ^= (1<<2);			//Output 1 to PINB2
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
					
					//display 8
					PINB ^= (1<<0);			//Output 1 to PINB0
					PINB ^= (1<<2);			//Output 1 to PINB2
					PIND ^= (1<<5);			//Output 1 to PIND5
					PINB ^= (1<<3);			//Output 1 to PINB3
					PINB ^= (1<<4);			//Output 1 to PINB4
					PINB ^= (1<<5);			//Output 1 to PINB5
					PIND ^= (1<<7);			//Output 1 to PIND7
					_delay_ms(200);			//Delay 0.5 seconds
					
					//reset
					//reset
					PINB ^= (0<<0);			//Output 1 to PINB0
					PIND ^= (0<<5);			//Output 1 to PIND5
					PINB ^= (0<<2);			//Output 1 to PINB2
					PINB ^= (0<<3);			//Output 1 to PINB5
					PINB ^= (0<<4);			//Output 1 to PINB4
					PINB ^= (0<<5);			//Output 1 to PINB5
					PIND ^= (0<<7);			//Output 1 to PIND7
					_delay_ms(500);			//Delay 0.5 seconds
				}
				
				
			

	}
	
	return 0;

}


