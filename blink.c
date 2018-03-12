#ifndef F_CPU
//AT90USBKey2 uses an external 8MHz crystal
#define F_CPU 8000000
#endif

#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  DDRD = 0xC0;
  DDRA = 0x40;
  while(1)
  {
    PORTD |= 0xF0;
    PORTA |= 0x40;
    _delay_ms(1000);
    PORTD &= 0x0F;
    PORTA &= 0xBF;
    _delay_ms(1000);
  }
}
