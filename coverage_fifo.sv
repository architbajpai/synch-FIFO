class coverage_fifo;
virtual intf_fifo i;

covergroup cg @(i.clk,i.rst);
DIN: coverpoint i.din;
FF: coverpoint i.flagf;
FE: coverpoint i.flage;
DOUT: coverpoint i.dout;
//ACK: coverpoint i.ack;
wexre:cross i.we,i.re;
endgroup

function new (virtual intf_fifo i);
this.i=i;
cg=new();
endfunction
task sample;
cg.sample;
endtask
endclass