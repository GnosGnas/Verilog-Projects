// Header files
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void main()
{
    // Two file pointers have been declared. v is for generating the verilog file for Carry Ripple Adder module and other related modules and tb is for generating the corresponding Test Bench
    FILE *v, *tb;

    int N; //Stores the number of bits
    int a, b; //Stores the sample values to be added in the Test Bench
    int T;  //Stores the delay for each transistor    

    v = fopen("CRA.v", "w");
    tb = fopen("tb_CRA.v", "w");

    printf("Enter the size of the input numbers to be added (in bits): ");
    scanf("%d", &N);
    
    printf("Enter delay of a transistor: ");
    scanf("%d", &T);

    //Checking for positive value of N
    if (N < 0) {
        printf("Invalid entry");
        exit(0);
    }

    // In CRA.v, verilog code for Full adder module is being dumped
    fprintf(v, "module FullAdder(input a,b,cin, output cout,s);\n\tassign #%d cout = a&b|b&cin|cin&a;\n\tassign #%d s = a^b^cin;\nendmodule\n\n", 6*T, 12*T);

    // In CRA.v, verilog code for the Carry Ripple adder is being dumped. Here I am using a constant parameter N which will have the number of bits. The rest of the code is generalised for any n.
    fprintf(v, "module CRA(a,b,sum,cout);\n\tparameter N = ");
    fprintf(v, "%d", N);

    fprintf(v, ";\n\n\tinput [N-1:0] a,b;\n\toutput cout;\n\toutput [N-1:0] sum;\n\n\twire [N-1:0] c;\n\n\tassign cout = c[N-1];\n\n\tFullAdder FA0(a[0],b[0],1'b0,c[0],sum[0]);\n\n\tgenvar p;\n\tfor(p = 1;p<N;p=p+1)\n\t\tbegin:fa\n\t\tFullAdder FA(a[p],b[p],c[p-1],c[p],sum[p]);\n\t\tend\nendmodule");

    //CRA.v has been created
    printf("Verilog code for Carry Ripple Adder has been generated for %d bits and dumped in CRA.v\n", N);

    //Sample input values for the Test Bench
    printf("Enter two values, a and b, to be added in the Test Bench: ");
    scanf("%d %d", &a, &b);

    //The verilog code for Test Bench is being stored in tb_CRA.v
    fprintf(tb, "module tb;\n\tparameter N = %d;\n\n\treg [N-1:0] a,b;\n\twire [N-1:0] s;\n\twire cout;\n\n\tCRA CarryRipple(a,b,s,cout);\n\n\tinitial\n\t\tbegin\n\t\t$monitor($time,\"%%d + %%d = %%d  (+8*%%d)\",a,b,s,cout);\n\t\ta = %d;\n\t\tb = %d;\n\n\t\t#%d $finish;\n\t\tend\nendmodule", N, a, b, 100*T);

    printf("Test Bench has been created and can be found as tb_CRA.v\n");
}

