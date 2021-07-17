# CRA and CLA implementation

This code is written by Surya Prasad S. (EE19B121).

There are two C code files namely 'CRA_generator.c' and 'CLA_generator.c'. When run they generate two verilog files, CRA.v and CLA.v, based on the size of inputs and the delay of each transistor of a gate given by the user. The user will be prompted to input the size of the Adder, the time. Two Test Bench files are also generated, tb_CRA.v and tb_CLA.v, for which the input values to the adder will be got from the user. 

To run the C codes in Ubuntu terminal, type the following:

    $ gcc CRA_generator.c

    $ gcc CLA_generator.c -lm

To run the Test Bench files, I have used Iverilog and these are the commands for it:

    $ iverilog tb_CRA.v CRA.v
    $ ./a.out

    $ iverilog tb_CLA.v CLA.v
    $ ./a.out

CRA is the short form for Carry Ripple Adder and adds two numbers using Ripple Addition. CLA is the short form for Carry Look-ahead Adder and adds two numbers using Carry Look-ahead method. CLA model used is also referred to as generate-propagate-kill adder.

As we can see, the delay in CRA is larger than in CLA. This is because the delay of the Full Adder in CRA is increasing faster with the number of Full Adders. Number of Full Adders required is equal to the size of input (N). The addition happens in a sequence with each step taking 12 units of delay. On the other hand, CLA performs the same N-bit addition in approximately log(N) steps. In each step, the delay is 3 units which is much lesser than that of the adder. Please note that the time provided by the monitor function in the Test Bench is affected by the values of the inputs so it is lesser than the actual time needed to get a stable output.

As we can see from the code there are a lot of modules used. So this is one disadvantage of CLA because it can consume a lot of space. Also the total delay is little more than 6*log(N). So effectively CLA is best used to perform addition of large numbers. It can also be noted that the circuitry for Ripple adder is very simple and it can be easily modified to perform addition of larger numbers.

