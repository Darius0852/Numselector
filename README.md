# Numselector
Bluetooth Communication between iOS and Embedded System using AVR programming of the Arduino Uno chipset and using swift to develop a game interface on iOS devices

[[https://github.com/Darius0852/Numselector/blob/master/images/s.png]]

## Overview

The aim of the project is to demonstrate awareness in working with specialised hardware used in microcontrollers and to show competence in use of low-level programming in pure C code with embedded systems. This project is a game developed between an Arduino with an AVR ATMega328P chip and a smartphone, using PWM and serial port communication through a bluetooth module to interact.

[[https://github.com/Darius0852/Numselector/blob/master/images/screengit.png]]

## Components

AT-09 Bluetooth Module
Arduino Uno
14 LEDs (2 for each segment)
Servo - Tower Pro SG90

## Setup

Pin D5, D7, B0, B2, B3, B4, B5 - 7-segment LED’s
Pin D0, D1 - Serial Receive, Serial Transmit for Bluetooth Module
Pin D9 - PWM to Servo
Pin 5V - Servo Power
Pin 3.3V - Bluetooth Module power
GND - Bluetooth Module Ground
GND - Servo Ground


## Functions

C Code on Arduino:
PWM - change servo position.
Serial Communication - Transmit result via bluetooth back to iPhone.

Swift (iPhone) Code:
Bluetooth Transmit Function - transmit data from iPhone App to Arduino.
Score Function - increment score and display alert if matched.

## Game Description

The Game ‘NumSelector’ is a number guessing game which awards you for guessing the correct number. It works in the following way:

User will choose a number 1-9 on the iPhone app.
Hit ‘Run’ on the app.
The App sends this to the Arduino number via bluetooth.
The Arduino will output the user’s number on 7-segment LED’s.
The App then generates a random number and compares it to the user’s number.
If the random number matches the users selected number the app alert’s the user and the LED’s will flash from the Arduino.
A prize will be awarded to the user through a servo on the Arduino.
If the user’s number doesn’t match the random number. The LED’s will clear and the user will be notified on the iPhone App.

## Method

Brief Description

The iPhone app connects to the AT-09 bluetooth module using its Universally Unique identifier  (UUID). The user’s selected number is transmitted to the bluetooth module and the Arduino receives the number through serial port communication with the bluetooth module. The number is then output on a 7-segment LED display. The iPhone app then generates a random number and compares it to the users number, it will send an ‘a’ to the Arduino on successful number match. If the Arduino receives the ‘a’ it will flash the LED’s 3 times to signify a match and output a PWM signal from PIN 9 to trigger the servo to move from -90° to 0  and back to -90° which releases a prize to the user.



# ReadMe for C Code

Mini Project - NumSelector

The code sets up PWM and Serial Port Communication to begin with.

Inside the while loop the following line of code is used:

while (!(UCSR0A&(1<<RXC0)));

To wait for new Serial Port Data to be received.

Once it is received it is compared to a set of numbers using if statements like the one shown below:

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

In the if statement the LED's are reset and the appropriate output ports will be set to output the number.
Character received can be changed to any character/s that are expected to be sent over the serial port.

In the last if statement the following code is used:

					OCR1A = 3999;	//-90 degrees
					_delay_ms(1000);
					OCR1A = 1800;	//0 degrees;	
					_delay_ms(1000);
					OCR1A = 3999;	//back to -90 degrees
					_delay_ms(1000);

Which sets the PWM timer to start and output power. 
The OCR1A value can be changeed between 1000 - 4000 to change the position of the Tower Pro SG90 Servo.

