/***********************************************************************************************************************************************
Purpose  : To dynamically generate N bit Wallace multiplier with K stages
Author   : Surya Prasad.S(EE19B121) 
Date     : 17th Nov 2020
Inputs   : Size of inputs to the multiplier, maximum number of stages and test values to be multiplied in the Testbench
Outputs  : Two Verilog files - Wallace.v and tb_Wallace.v - and total number of stages

Logic of this code:
1. The entire Wallace Tree Multiplier can be split into various levels with CLA being the last level. AND operation on the inputs is the Level 0 and I have combined it with Level 1 because the delay will be small.
2. For N>2, Stage 1 is dumped and then using for loops the rest of the stages are done.
3. At every level the resultant of CSA modules are kept such that the number in the ith row has its significant bits starting from i.
4. I used variable 'temp' to keep track of the length of these numbers and updated them after passing each level.
5. The variables 'n_l' and  'l_t' are used to track the number of levels in each stage
6. The time period of the clock is calculated taking the delay of a transistor to be 1 unit of time.
*************************************************************************************************************************************************/

// Header files
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

double KMAX_calc(int N);  //Function to find the maximum number of stages
void main()
{
    // Two file pointers have been declared. v is for generating the Verilog file for Carry Look-ahead Adder module and other related modules and tb is for generating the corresponding Testbench
    FILE *v, *tb;

    int N, K;        //N stores the size of multiplier and K is the number of stages
    int lvl;         //Stores the level at which we are in the Wallace Tree. It is same as the stage number when there are maximum number of stages.
    int a, b;        //Stores the sample values to be multiplied in the Testbench
    int temp[100];   //For keeping track of the significant length (length when written as binary times an exponent)
    int csa_t[100];  //Tracks the csa sizes required
    int cla_t = 0;   //Stores the cla size required

    int pos;         //Temporary variable
    int d;           //Length variable
    int i, j, k, l;  //Temporary loop variables
    int Ki;          //Ki is the input number of stages
    int n_l, l_t = 0;//n_l is the calculated number of levels per stage and l_t tracks the number of levels
    int clk;         //Clock's time period is based on the stage with the maximum delay

    v = fopen("Wallace.v", "w");
    tb = fopen("tb_Wallace.v", "w");

    printf("Enter the size of the input numbers to be multiplied (in bits): ");
    scanf("%d", &N);

    //Checking for valid value of N
    if (N < 1) {
        printf("Invalid entry\n");
        exit(0);
    }

    printf("Maximum number of stages is %0.f\nEnter the desired number of stages: ", KMAX_calc(N));
    scanf("%d", &Ki);

    for (i = 0; i < 2 * N; i++)
    {
        temp[i] = N;
        csa_t[i] = 0;
    }

    if ((Ki <= 1) && (Ki > KMAX_calc(N))) {
        printf("Invalid entry\n");
        exit(0);
    }

    //Number of levels per stage is being calculated
    n_l = ceil( (KMAX_calc(N) - 1) / (Ki - 1) );

    printf("Number of levels of Wallace Tree in each stage is %d\n",n_l);

    //In Wallace.v, Verilog code for MULT module is being dumped.
    fprintf(v, "module MULT(a,b,out,clk);\n\n\t//Stage 0:\n\n\tinput [%d:0] a,b;\n\tinput clk;\n\toutput [%d:0] out;\n\n\twire [%d:0][%d:0] t0;\n", N - 1, 2 * N - 1, N - 1, 2 * N - 2);


    //Stage 0
    K = 0;
    lvl = 0;

    //AND operation is done on the inputs
    fprintf(v, "\n\tassign t0[0] = {%d'b0", N - 1);

    for (j = N - 1; j >= 0; j--)
        fprintf(v, ", a[%d]&b[0]", j);

    fprintf(v, " };");

    for (i = 1; i < N - 1; i++)
    {
        fprintf(v, "\n\tassign t0[%d] = {%d'b0", i, N - 1 - i);

        for (j = N - 1; j >= 0; j--)
            fprintf(v, ", a[%d]&b[%d]", j, i);

        fprintf(v, ",%d'b0};", i);
    }

    fprintf(v, "\n\tassign t0[%d] = {", N - 1);

    for (j = N - 1; j >= 0; j--)
        fprintf(v, "a[%d]&b[%d], ", j, N - 1);

    fprintf(v, "%d'b0 };", N - 1);


    //Stage 1 will be different when N>2 and N<=2. So I am taking two cases.
    if (N > 2) {
        K = 1;
        lvl = 1;

        fprintf(v, "\n\n\n\t//Stage 1:\n\treg res1;\n\twire [%d:0] w11,w12;\n\treg [%d:%d][%d:%d] t1 = 0;", N, N - 1, lvl, 2 * N - 1, lvl);
        fprintf(v, "\n\n\tcsa%d c1_1(t0[0][%d:1],t0[1][%d:1],t0[2][%d:1],w11,w12);", N + 1, N + 1, N + 1, N + 1);

        //Updating the trackers
        csa_t[N + 1] = 1;
        temp[0] = 1;
        temp[1] = N + 1;
        temp[2] = N + 1;
        l_t = 1;

        for (i = 3; i < N - 2; i = i + 3)
        {
            fprintf(v, "\n\n\twire [%d:0] w1%d,w1%d;\n\n\tcsa%d c1_%d(t0[%d][%d:%d],t0[%d][%d:%d],t0[%d][%d:%d],w1%d[%d:1],w1%d[%d:1]);", N + 1, i, i + 1, N + 1, i - 1, i, N + i + 1, i + 1, i + 1, N + i + 1, i + 1, i + 2, N + i + 1, i + 1, i, N + 1, i + 1, N + 1);

            fprintf(v, "\n\n\tassign w1%d[0] = t0[%d][%d];", i, i, i);

            //Updating the trackers
            temp[i] = N + 2;
            temp[i + 1] = 0;
            temp[i + 2] = N + 1;
        }

        if (l_t == n_l)
            fprintf(v, "\n\n\talways@(posedge clk)\n\tbegin\n\tres1 = t0[0][0];\n\tt1[1][%d:1] = w11;\n\tt1[2][%d:2] = w12;", N + 1, N + 2);

        else
            fprintf(v, "\n\n\talways@(*)\n\tbegin\n\t res1 = t0[0][0];\n\tt1[1][%d:1] = w11;\n\tt1[2][%d:2] = w12;", N + 1, N + 2);

        for (j = 3; j < N - 2; j = j + 3)
            fprintf(v, "\n\tt1[%d][%d:%d] = w1%d;\n\tt1[%d][%d:%d] = w1%d[%d:1];", j, N + j + 1, j, j, j + 2, N + j + 2, j + 2, j + 1, N + 1);

        if (j != N - 3)
            while (j < N) {
                fprintf(v, "\n\tt1[%d] = t0[%d];", j, j);
                j++;
            }

        fprintf(v, "\n\tend");


        //Intermediate levels
        for (i = 1; i < N - 2; i++)
        {
            d = temp[i] - 1;

            if (temp[i] == 0)
                continue;

            for (j = i + 1; j < N - 1; j++)
                if (temp[j] != 0)
                    break;

            if (j >= N - 1)
                break;

            if ((temp[j] + j - i - 1) > d)
                d = temp[j] + j - i - 1;

            for (k = j + 1; k < N; k++)
                if (temp[k] != 0)
                    break;

            if (k >= N)
                break;

            if ((temp[k] + k - i - 1) > d)
                d = temp[k] + k - i - 1;

            //Above checkings are for picking the three sets of numbers and the appropriate d is calculated.
            if (l_t == n_l) {
                K = K + 1;

                //Stage K
                fprintf(v, "\n\n\t//Stage %d:", K);

                l_t = 1;
            }
            else
                l_t = l_t + 1;

            lvl = lvl + 1;

            fprintf(v, "\n\treg [%d:0] res%d;\n\treg [%d:%d][%d:%d] t%d = 0;", i, i + 1, N - 1, lvl, 2 * N - 1, lvl, i + 1);
            fprintf(v, "\n\twire [%d:0] w%d1,w%d2;", d - j + i, i + 1, i + 1);
            fprintf(v, "\n\n\tcsa%d c%d_1(t%d[%d][%d:%d], t%d[%d][%d:%d], t%d[%d][%d:%d], w%d1,w%d2);", d - j + i + 1, i + 1, i, i, d + i, j, i, j, d + i, j, i, k, d + i, j, i + 1, i + 1);

            if (l_t == n_l) {
                fprintf(v, "\n\n\talways@(posedge clk)\n\tbegin\n\tt%d[%d][%d:%d] = w%d1;\n\tt%d[%d][%d:%d] = w%d2;\n\tend", i + 1, j, d + i, j, i + 1, i + 1, j + 1, d + i + 1, j + 1, i + 1);

                if (j != i + 1)
                    fprintf(v, "\n\n\talways@(posedge clk)\n\tres%d = {t%d[%d][%d:%d],res%d};", i + 1, i, i, j - 1, i, i);

                else
                    fprintf(v, "\n\n\talways@(posedge clk)\n\tres%d = {t%d[%d][%d],res%d};", i + 1, i, i, i, i);
            }
            else {
                fprintf(v, "\n\n\talways@(*)\n\tbegin\n\t t%d[%d][%d:%d] = w%d1;\n\tt%d[%d][%d:%d] = w%d2;\n\tend", i + 1, j, d + i, j, i + 1, i + 1, j + 1, d + i + 1, j + 1, i + 1);

                if (j != i + 1)
                    fprintf(v, "\n\n\talways@(*)\n\t res%d = {t%d[%d][%d:%d],res%d};", i + 1, i, i, j - 1, i, i);

                else
                    fprintf(v, "\n\n\talways@(*)\n\t res%d = {t%d[%d][%d],res%d};", i + 1, i, i, i, i);
            }

            //Updating the trackers
            csa_t[d - j + i + 1] = 1;
            temp[i] = 1;
            temp[j] = d - j + i + 1;
            temp[k] = 0; //Here if k!=j+1 then k becomes zero and j+1 is updated
            temp[j + 1] = d - j + i + 1;

            for (j = k + 1, pos = k + 1; j < N - 2; j++)
            {
                d = temp[j];

                if (temp[j] == 0)
                    continue;

                for (k = j + 1; k < N - 1; k++)
                    if (temp[k] != 0)
                        break;

                if (k >= N - 1)
                    break;

                if ((temp[k] + k - j) > d)
                    d = temp[j] + k - j;

                for (l = k + 1; l < N; l++)
                    if (temp[l] != 0)
                        break;

                if (l >= N)
                    break;

                if ((temp[l] + l - j) > d)
                    d = temp[l] + l - j;

                fprintf(v, "\n\n\twire [%d:0] w%d%d,w%d%d;", d - 1, i + 1, j, i + 1, j + 1);
                fprintf(v, "\n\n\tcsa%d c%d_%d(t%d[%d][%d:%d], t%d[%d][%d:%d], t%d[%d][%d:%d], w%d%d[%d:%d], w%d%d[%d:%d]);", d - k + j, i + 1, j, i, j, d + j - 1, k, i, k, d + j - 1, k, i, l, d + j - 1, k, i + 1, j, d - 1, k - j, i + 1, j + 1, d - 1, k - j);

                if (k != j + 1)
                    fprintf(v, "\n\tassign w%d%d[%d:0] = t%d[%d][%d:%d];", i + 1, j, k - j - 1, i, j, k - 1, j);

                else
                    fprintf(v, "\n\tassign w%d%d[0] = t%d[%d][%d];", i + 1, j, i, j, j);

                if (l_t == n_l)
                    fprintf(v, "\n\n\talways@(posedge clk)\n\tbegin\n\tt%d[%d][%d:%d] = w%d%d;\n\tt%d[%d][%d:%d] = w%d%d[%d:%d];\n\tend", i + 1, j, d + j - 1, j, i + 1, j, i + 1, k + 1, d + j, k + 1, i + 1, j + 1, d - 1, k - j);

                else
                    fprintf(v, "\n\n\talways@(*)\n\tbegin\n\t t%d[%d][%d:%d] = w%d%d;\n\tt%d[%d][%d:%d] = w%d%d[%d:%d];\n\tend", i + 1, j, d + j - 1, j, i + 1, j, i + 1, k + 1, d + j, k + 1, i + 1, j + 1, d - 1, k - j);

                //Updating the trackers
                csa_t[d - k + j] = 1;
                temp[j] = d;
                temp[k] = 0;
                temp[l] = 0;
                temp[k + 1] = d - k + j;

                pos = l + 1;

                j = l + 1;
            }

            if (pos < N) {
                if (l_t == n_l)
                    fprintf(v, "\n\n\talways@(posedge clk)\n\tbegin;");

                else {
                    fprintf(v, "\n\n\talways@(*)\n\tbegin\n\t t%d[%d] = t%d[%d];", lvl, pos, lvl - 1, pos);
                    pos++;
                }

                while (pos < N)
                {
                    if (temp[pos] != 0)
                        fprintf(v, "\n\tt%d[%d] = t%d[%d];", lvl, pos, lvl - 1, pos);

                    pos++;
                }

                fprintf(v, "\n\tend");
            }

        }
    }


    //Last stage
    K = K + 1;
    lvl = lvl + 1;

    //First we shall identify the final two numbers to be added. We can assume that two numbers will definitely exist for any size N
    for (i = 0; i < N; i++)
        if ((temp[i] != 1) && (temp[i] != 0))
            break;

    for (j = i + 1; j < N; j++)
        if ((temp[j] != 1) && (temp[j] != 0))
            break;

    if (temp[i] - j + i > temp[j])
        d = temp[i] - j + 1;
    else
        d = temp[j];

    fprintf(v, "\n\n\t//Stage %d:\n\twire [%d:0] rest;//unnecessary wire\n\twire cp;\n\treg [%d:0] result; \n\n\tcla%d carry_adder(t%d[%d][%d:%d], t%d[%d][%d:%d], rest, cp);", K, d - 1, 2 * N- 1, d, lvl - 1, i, d + i, i + 1, lvl - 1, j, d + i, i + 1);

    if (j == i + 1)
        fprintf(v, "\n\n\talways@(posedge clk)\n\tresult = {rest[%d:0],t%d[%d][%d],res%d};", 2 * N - lvl - 1, lvl - 1, i, i, lvl - 1);
    else
        fprintf(v, "\n\n\talways@(posedge clk)\n\tresult = {rest[%d:0],t%d[%d][%d:%d],res%d};", 2 * N - lvl - 1, lvl - 1, i, j - 1, i, lvl - 1);

    fprintf(v,"\n\n\tassign out = result;");
    fprintf(v, "\n\n\tendmodule");

    cla_t = d;

    //Sample input values for the Testbench
    printf("Enter two values, a and b, to be multiplied in the Testbench: ");
    scanf("%d %d", &a, &b);

    //Finding the value of clk so that the stages are executed successfully
    clk = ((24 * n_l + 3) > (6 * ceil(log(cla_t) / log(2))))? (24 * n_l + 3) : (6 * ceil(log(cla_t) / log(2)));


    //The verilog code for Testbench is being stored in tb_Wallace.v
    fprintf(tb, "module tb;\n\treg [%d:0] a,b;\n\twire [%d:0] out;\n\treg clk;\n\n\tMULT M(a,b,out,clk);", N - 1, 2 * N - 1);
    fprintf(tb, "\n\n\talways@(*)\n\t#%d clk = !clk;",clk);
    fprintf(tb, "\n\n\tinitial\n\tbegin\n\ta = %d;\n\tb = %d;\n\tclk = 0;", a, b);
    fprintf(tb, "\n\n\t$monitor($time,\" %%d x %%d = %%d \",a,b,out);\n\n\t#%d $finish;\n\tend\nendmodule", 1000 * N);


    //In Wallace.v, verilog code for Full Adder module is being dumped.
    fprintf(v, "\n\n\nmodule FullAdder(input a,b,c, output cout,s);\n\tassign cout = a&b|b&c|c&a;\n\tassign s = a^b^c;\nendmodule");

    //In Wallace.v, verilog code for Carry-Save Adder modules are being dumped. Different CSA modules are dumped based on the requirements
    for (i = 1; i < 2 * N; i++)
    {
        if (csa_t[i] == 0)
            continue;

        fprintf(v, "\n\nmodule csa%d(a,b,c,x_out,c_out);\n\tparameter N = %d;\n\n\tinput [N-1:0] a,b,c;\n\toutput [N-1:0] x_out,c_out;", i, i);
        fprintf(v, "\n\n\tgenvar p;\n\tfor(p = 0;p<N;p=p+1)\n\tbegin:fa\n\tFullAdder FA(a[p],b[p],c[p],c_out[p],x_out[p]);\n\tend");
        fprintf(v, "\n\nendmodule");
    }

    //The files have been created. Here I am simply reusing the N and K
    printf("Verilog file for %d-bit Wallace multiplier with %d stages of pipelining has been created and can be found as Wallace.v.\nTestbench has been created and can be found as tb_Wallace.v\n", N, K);

    // In Wallace.v, verilog code for opr module is being dumped. Opr module is used to compute the resultant of two carry statuses for the CLA (like generate or kill)
    fprintf(v, "\n\n\nmodule opr(p,q,o);\n\tinput [1:0] p,q;\n\toutput [1:0] o;\n\n\tassign o[0] = p[1] | q[0]&p[0];\n\tassign o[1] = p[1] | q[1]&p[0];\nendmodule\n\n");

    // In Wallace.v, verilog code for Carry Look-ahead adder is being dumped. Here based on cla_t the size of the variables are given.
    N = cla_t;
    K = ceil(log(N) / log(2));

    fprintf(v, "module cla%d(a,b,sum,cout);\n\tinput [%d:0] a,b;\n\toutput [%d:0] sum;\n\toutput cout;\n\n\twire [%d:0][1:0] c0;\n\twire [%d:0] t0,t1;\n\n\tassign t0 = a|b;\n\tassign t1 = a&b;\n\n\tassign c0[0] = 2'b0;\n", N, N - 1, N - 1, N, N - 1);

    for (i = 1; i <= N; i++)
        fprintf(v, "\tassign c0[%d] = {t1[%d],t0[%d]};\n", i, i - 1, i - 1);

    fprintf(v, "\n\twire [%d:0][1:0] c1", N);

    //Loop to declare wires
    for (i = 2; i <= K + 1; i++)
        fprintf(v, ", c%d", i);

    fprintf(v, ";\n");

    int r = 1;

    //Loop to assign each wire
    for (i = 0; i <= K; i++)
    {

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
        fprintf(v, "\tassign temp[%d] = c%d[%d][0];\n", j, i, j); //the final value of i is used here

    //Sum and Carry over is being calculated and assigned.
    fprintf(v, "\n\tassign sum = temp^a^b;\n\tassign cout = c%d[%d][0];\n", i, N);

    fprintf(v, "endmodule");
}

//Function to calculate maximum number of stages given the size of multiplier
//Here I am using the same logic as in the code but without the level trackers and the File generation
double KMAX_calc(int N)
{
	int Kmax = 0, i, j, k, l, d;
	int temp[100];

	for (i = 0; i < 2 * N; i++)
		temp[i] = N;

	if (N > 2) {
		Kmax = 1;
       	temp[0] = 1;
        temp[1] = N + 1;
        temp[2] = N + 1;

        for (i = 3; i < N - 2; i = i + 3)
        {
            temp[i] = N + 2;
            temp[i + 1] = 0;
            temp[i + 2] = N + 1;
        }

        for (i = 1; i < N - 2; i++)
        {
            d = temp[i] - 1;

            if (temp[i] == 0)
                continue;

            for (j = i + 1; j < N - 1; j++)
                if (temp[j] != 0)
                    break;

            if (j >= N - 1)
                break;

            if ((temp[j] + j - i - 1) > d)
                d = temp[j] + j - i - 1;

            for (k = j + 1; k < N; k++)
                if (temp[k] != 0)
                    break;

            if (k >= N)
                break;

            if ((temp[k] + k - i - 1) > d)
                d = temp[k] + k - i - 1;

            Kmax = Kmax + 1;
            temp[i] = 1;
            temp[j] = d - j + i + 1;
            temp[k] = 0; //Here if k!=j+1 then k becomes zero and j+1 is updated
            temp[j + 1] = d - j + i + 1;

            for (j = k + 1; j < N - 2; j++)
            {
                d = temp[j];

                if (temp[j] == 0)
                    continue;

                for (k = j + 1; k < N - 1; k++)
                    if (temp[k] != 0)
                        break;

                if (k >= N - 1)
                    break;

                if ((temp[k] + k - j) > d)
                    d = temp[j] + k - j;

                for (l = k + 1; l < N; l++)
                    if (temp[l] != 0)
                        break;

                if (l >= N)
                    break;

                if ((temp[l] + l - j) > d)
                    d = temp[l] + l - j;

                temp[j] = d;
                temp[k] = 0;
                temp[l] = 0;
                temp[k + 1] = d - k + j;
                j = l + 1;
            }
        }
    }

    Kmax = Kmax + 1;
    return Kmax;
}
