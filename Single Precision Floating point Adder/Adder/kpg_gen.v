`include "Adder/kpg.v"

module kpg_gen(out,ai,bi);

input [7:0] ai,bi;

output [7:0][7:0]out;

kpg kpg_0(out[0],ai[0],bi[0]);
kpg kpg_1(out[1],ai[1],bi[1]);
kpg kpg_2(out[2],ai[2],bi[2]);
kpg kpg_3(out[3],ai[3],bi[3]);
kpg kpg_4(out[4],ai[4],bi[4]);
kpg kpg_5(out[5],ai[5],bi[5]);
kpg kpg_6(out[6],ai[6],bi[6]);
kpg kpg_7(out[7],ai[7],bi[7]);

endmodule
