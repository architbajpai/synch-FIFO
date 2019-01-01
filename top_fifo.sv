`include "packet_fifo.sv"
`include "generator_fifo.sv"
`include "driver_fifo.sv"
`include "intf_fifo.sv"
`include "coverage_fifo_sample.sv"
`include "synch_fifo_3.sv"
`include "fifo_sync.v"
`include "monitor_fifo.sv"
`include "scoreboard_fifo.sv"
`include "environment_fifo.sv"
`include "test_fifo.sv"

module top_fifo;
reg clk,rst;
reg we,re;
initial 
clk=1'b0;
always #5 clk=~clk;
initial 
begin
rst=1'b0;
#100 rst=1'b1;
#100 rst=1'b0;
end
/*initial begin
we=1'b1; re=1'b0;
#100 we=1'b0; re=1'b1;
#100 we=1'b1; re=1'b0;
#5 we=1'b1; re=1'b1;
end*/
intf_fifo i(clk,rst);
intf_fifo j(clk,rst);

synch_fifo_3 r1 (.clk(clk),.rst(rst),.din(i.din),.dout(i.dout),.we(i.we),.re(i.re),.flagf(i.flagf),.flage(i.flage));
fifo_sync a2 (.clk(clk),.rst(rst),.data_in(j.din),.data_out(j.dout),.push(j.we),.pop(j.re),.full(j.flagf),.empty(j.flage));

test_fifo t1 (i,j);
endmodule