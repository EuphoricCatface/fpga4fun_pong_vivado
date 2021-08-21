# fpga4fun\_pong\_vivado

## Introduction
Not much novelty here. Logging the journey of my first FPGA project to adapt [PongGame of fpga4fun.com](https://www.fpga4fun.com/PongGame.html) to my board. Having had quite a bit of trouble myself, I thought some would benefit from seeing what I (will) have gone through.

## Target Audience
[x] I wanted to learn FPGA
[x] I got hyped up enough to buy one
[x] I have tried a few tutorials / demos
[x] I wanted to try something cooler though
[x] I started to get a vague illusion that I understand everything when I go through the code
[x] I tried to follow some cooler projects but they somehow didn't work for me
[x] I want to find some project that I can actually work on, not those where they hand out crap ton of code and let me just fiddle with last bits of configuration to make me proud of it
These are what I was feeling about my FPGA board before working on this one. Hopefully there are many that feel the same way.

## Board
[Digilent Basys3](https://digilent.com/reference/programmable-logic/basys-3/start) (Not affiliated)
**What I considered before the decision**

Feel free to contact me if you think some of these are not accurate. I'll be glad to add other opinions to the list.

[x] Is it popular enough?
- The more popular, the easier to find materials online - It's Xilinx, and it's Digilent. What more you need?

[x] Is it not overly expensive?
- With abundant peripherals it has, it didn't seem to be too expensive.
  Smaller manufacturers seemed to have comparable ones with half the price, though. You can go for them if you have different priorities.
  The board I picked costs 150$ as of 2021.

[x] Does the chip have enough power?
- Apparently, performance of a FPGA chip can be roughly judged by LUT count (setting aside hard blocks and clocking, which don't seem to matter for a beginner).
- Surveying a few "cooler" projects, I decided that 35k LUT count is not too limiting.
- However, there will be other projects that target 100k LUT count ones.

[x] Is it recent enough?
- The FPGA chip is in the most recent series, and the predecessor seems to be still not out of fashion.

[x] Does it have good peripherals on-board?
- Well, Dave L. Johnes from EEVBlog said VGA output is a nice example for FPGA projects. This was totally not the only reason to choose this one...
   Though, it is legitimately okay to add it yourself. To be explained later in this document
- Other than that, I read on the internet(TM) that pin header / soldering IO is not really ideal for an FPGA, so I guess onboard peripherals do matter.
- On the other hand, this board has Pmod peripheral connectors of Digilent. To be honest, this doesn't look too different from Arduino convenience shields to me. You might as well find one with Arduino layout instead, if you have that in mind.

All in all, these are not the definite standards. Remember to consider your situation and priorities.

## Prerequisites to the Project

### Learning Material
If you *are* using Vivado, and are indeed a beginner, try [FPGA Design Flow using Vivado(Xilinx)](https://www.xilinx.com/support/university/vivado/vivado-workshops/Vivado-fpga-design-flow.html) Workshop first. It gives you good overview of what Vivado has to offer, and how to use them. I picked 2016x version because it was the latest version for non-zynq based board as of 2021, and it worked out except for a few minor differences.

### Peripherals
The original project requires following two peripherals connected to the chip
- A VGA port
   Totally not the reason I picked this project :D
   If you don't have a VGA port on your board, you can buy one and connect it to the board as described in the fpga4fun project page.
   It shouldn't be too difficult to build a resistor ladder like the one on Basys 3 board, if you have experience in Arduino.
- A quadrature decoder
   In other words, a rotary encoder with two leads
   or, yet another way of describing (as the recommended way of the original project) is, that you take apart a ball mouse and connect a couple of wires.
   I'll probably end up modifying the code to use button input instead, so no worries if you are still puzzled. (Ask your dad)
