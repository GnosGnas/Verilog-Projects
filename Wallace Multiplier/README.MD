# Wallace Multiplier

This code is written by Surya Prasad S. (EE19B121).

There is one C code file namely 'Wallace_multiplier.c'. Please note that lesser number of registers are needed for synthesizing modules with lesser pipelines which is not explicitly seen in the register declaration. The number of synthesizable registers which are used are still optimised (considering that the Verilog register variables enabled with clock (clk) are physically synthesised as registers). The size of the adders are exactly as required and maximum number is used in the first stage. When run they generate two Verilog files, Wallace.v and tb_Wallace.v. 

**The user will be prompted to input the size of the Multiplier. In Wallace_multiplier.c, the user can also input the number of stages the pipeline should be done in. Input values to be given in the test bench is got from the user while running the c code.**

To run the C codes in Ubuntu terminal, type the following:

    $ gcc Wallace_multiplier.c -lm
    $ ./a.out

    $ gcc base_Wallace_multiplier.c -lm
    $ ./a.out

To run the Verilog files, I have used Iverilog and these are the commands for it:

    $ iverilog tb_Wallace.v Wallace.v
    $ ./a.out

    $ iverilog tb_base_Wallace.v base_Wallace.v
    $ ./a.out


Performance report:

Size of Multiplier = 16 bits |
Maximum number of stages = 7

| Number of stages | 7 | 4 | 3 | 2 |
| :---: | :-: | :-: | :---: | :-: |
| Smallest time period | 30 | 51 | 75 | 144 |
| Number of registers used | 2208	| 1060 | 678 | 298 |


The time taken for the complete execution of a CSA is independent of the number of bits given to it as input as the output bits can be computed parallely. The time taken by CLA depends on the size of the inputs to the multiplier. 
For 16-bit Wallace multiplier, the speed of execution will reduce with decreasing the number of stages. Optimised value would be when the number of stages is 3 or 4.

For large multiplication, the number of registers will increase at the order of 3 while the time delay will increase at logarithmic rate (taking CLA to take maximum delay). So optimising registers can be given more priority.
