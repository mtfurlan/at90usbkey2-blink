#include <avr/io.h>
#include <util/delay.h>

int main(void) {
  DDRD = 0xF0;
  while(1) {
    PORTD |= 0xF0;
    _delay_ms(100);
    PORTD &= 0x0F;
    _delay_ms(100);
  }
}
