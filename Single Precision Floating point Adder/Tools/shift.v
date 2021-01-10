module Shift(input [31:0]A, input [7:0]shift, output [31:0]B);
    assign B = A>>shift;
endmodule