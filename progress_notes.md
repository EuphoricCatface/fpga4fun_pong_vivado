## 2021-08-29
Progresses:  
- Reorganization of code pieces  
Notably, I have realized that manipulating Y on posedge CounterXmaxed causes problem, something like having two driving pins of which one is constant.  
I think it means initialization to 0 on RST pin, inside posedge CLK.  
So, I guess it is recommended to drive a register in blocks of same triggering...  
- Generalize vid\_gen to hvsync\_gen  
- Proper boarder drawing  
Two things to note: one is included in commit message, that it is much less confusing to compute numbers in source rather than in your brain or on a paper.  
Another is that my display device seemed to show pixels mostly fine with wrong timings. Sync pulses were positioned without back porch, and only thing it seemed to be confused was the timing of the last pixel. It would show jagged pattern at the rightmost end of the screen.  
- Clean warnings
Slowly getting grasp of the difference between wire and reg...  

## 2021-08-22
First working output!

Differences from the original project:

- Changed the resolution from 640x480 to 1280x1024
 - Created 108MHz via Clocking Wizard IP

Unfortunately, the device I have doesn't seem to understand 640x480, 720x567, or 800x600.  
You can easily find sync timings via googling. You'll notice that 800x600 has a nicely rounded pixel frequency of 40.0MHz.  
Also that you'll need 108MHz for 1280x1024, which is beyond the main frequency of 100MHz provided by the Basys 3 board. What a shame.  

Since one of the demo Digilent provided, namely General I/O Demo, included 1280x1024 vga output, I could tell it was possible to make 108MHz.  
I believe Clocking Wizard IP is Vivado-only feature - That reminds me when I was confused at SB\_PLL40\_CORE module before. I guess it is my turn to confuse IceStorm users. Ha, how do you like that!  
(JK, sorry about that! <3)  
Anyways, what I didn't know was that either methods (PLL or MMCM) to synthesize the clock take time to stabilize, it seems.  
I got confused trying to simulate the code why the output was stuck at low, but it turns out MMCM takes 1.12us, and PLL takes 3us until it can give proper output.  
More on simulating in the later part.

- Created RST part

Since this is my first "proper" FPGA project, I needed to see what's going on inside the logic.  
After some poking around, I figured reset logic is required, because otherwise the simulator would think the wires / registers were uninitialized and wouldn't give me the result.  
I guess the proper way to simulate is to write a testbench, but I was able to see how things were working by forcing the clock, and forcing 1 on RST for some clocks.  
(and I was also able to see how my code was devastatingly failing to hold up lol)  

- Using pin 3 of each VGA colors

Note that resistors on each pin 3 (510 Ohm) of Basys 3 has roughly double the value than the original project suggests (270 Ohm).  
This should make the color half as bright, and the rest three will complement the rest.  

