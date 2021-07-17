// Header files
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

void main()
{
    // Two file pointers have been declared. v is for generating the verilog file for Carry Look-ahead Adder module and other related modules and tb is for generating the corresponding Test Bench
    FILE *v, *tb;

    int N, K; //N stores the number of bits and K stores the log to the base 2 of N
    int a, b; //Stores the sample values to be added in the Test Bench
    int T;  //Stores the delay for each transistor

    int i, j, r = 1; //Temporary variables used in the for loops

    v = fopen("CLA.v", "w");
    tb = fopen("tb_CLA.v", "w");

    printf("Enter the size of the input numbers to be added (in bits): ");
    scanf("%d", &N);
    
    //Checking for positive value of N
    if (N < 0) {
        printf("Invalid entry");
        exit(0);
    }
    
    printf("Enter delay of a transistor: ");
    scanf("%d", &T);
    
    //Checking for positive value of T
    if (T < 0) {
        printf("Invalid entry");
        exit(0);
    }

    K = ceil(log(N) / log(2));

    // In CLA.v, verilog code for opr module is being dumped. Opr module is used to compute the resultant of two carry statuses (like generate or kill)
    fprintf(v, "module opr(p,q,o);\n\tinput [1:0] p,q;\n\toutput [1:0] o;\n\n\tassign #%d o[0] = p[1] | q[0]&p[0];\n\tassign #%d o[1] = p[1] | q[1]&p[0];\nendmodule\n\n", 3*T, 3*T);

    // In CLA.v, verilog code for Carry Look-ahead adder is being dumped. Here based on N the size of the variables are given.
    fprintf(v, "module CLA(a,b,sum,cout);\n\tinput [%d:0] a,b;\n\toutput [%d:0] sum;\n\toutput cout;\n\n\twire [%d:0][1:0] c0;\n\twire [%d:0] t0,t1;\n\n\tassign #%d t0 = a|b;\n\tassign #%d t1 = a&b;\n\n\tassign c0[0] = 2'b0;\n", N - 1, N - 1, N, N - 1, 3*T, 3*T);

    for (i = 1; i <= N; i++)
        fprintf(v, "\tassign c0[%d] = {t1[%d],t0[%d]};\n", i, i - 1, i - 1);

    fprintf(v, "\n\twire [%d:0][1:0] c1", N);

    //Loop to declare wires
    for (i = 2; i <= K + 1; i++)
        fprintf(v, ", c%d", i);

    fprintf(v, ";\n");

    //Loop to assign each wire
    for (i = 0; i <= K; i++) {

        //This loop is for the wires holding the resultant of computing between two statuses
        for (j = N; j > r - 1; j--)
            fprintf(v, "\n\topr op%d_%d(c%d[%d],c%d[%d],c%d[%d]);", i + 1, j, i, j, i, j - r, i + 1, j);

        //This loop is for the wires holding same values of previous wires
        for (; j >= 0; j--)
            fprintf(v, "\n\tassign c%d[%d] = c%d[%d];", i + 1, j, i, j);

        fprintf(v, "\n");
        r *= 2;
    }

    //Temporary wire to facilitate the final calculations
    fprintf(v, "\n\twire [%d:0] temp;\n\n", N - 1);

    for (j = 0; j < N; j++)
        fprintf(v, "\tassign temp[%d] = c%d[%d][0];\n", j, i, j);  //the final value of i is used here

    //Sum and Carry over is being calculated and assigned.
    fprintf(v, "\n\tassign #%d sum = temp^a^b;\n\tassign cout = c%d[%d][0];\n", 6*T, i, N);

    fprintf(v, "endmodule");

    //CLA.v has been created
    printf("Verilog code for Carry Look-ahead Adder has been generated for %d bits and dumped in CLA.v\n", N);

    //Sample input values for the Test Bench
    printf("Enter two values, a and b, to be added in the Test Bench: ");
    scanf("%d %d", &a, &b);

    //The verilog code for Test Bench is being stored in tb_CLA.v
    fprintf(tb, "module tb;\n\tparameter N = %d;\n\n\treg [N-1:0] a,b;\n\twire [N-1:0] s;\n\twire cout;\n\n\tCLA CarryLookahead(a,b,s,cout);\n\n\tinitial\n\t\tbegin\n\t\t$monitor($time,\"%%d + %%d = %%d (+8*%%d)\",a,b,s,cout);\n\t\ta = %d;\n\t\tb = %d;\n\n\t\t#%d $finish;\n\t\tend\nendmodule", N, a, b, 100*T);

    printf("Test Bench has been created and can be found as tb_CLA.v\n");
}

