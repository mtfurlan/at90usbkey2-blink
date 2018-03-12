# AT90USBKEY2 hello world blinking LEDs

This blinks the lights on a at90usbkey2

All of port D actually. It's mostly lights.

Requires avr-gcc, dfu-programmer, and probably some other stuff.

* press `RST` and `HWB` simultaneously on the board
* release `RST` then release `HWB`

Should show up in dmesg as `Product: AT90USB128 DFU` and `Manufacturer: ATMEL`
`idVendor=03eb, idProduct=2ffb`

```
sudo make flash
```
