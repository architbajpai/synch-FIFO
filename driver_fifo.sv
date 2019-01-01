class driver_fifo;
packet_fifo pkt;
mailbox #(packet_fifo) gen_drv;
virtual intf_fifo i;
virtual intf_fifo j;

function new (mailbox #(packet_fifo) gen_drv, virtual intf_fifo i, virtual intf_fifo j);
this.gen_drv=gen_drv;
this.i=i;
this.j=j;
endfunction

task run;
pkt=new();
gen_drv.get(pkt);
i.we=pkt.we;
i.re=pkt.re;
i.din=pkt.din;
j.we=pkt.we;
j.re=pkt.re;
j.din=pkt.din;

endtask
endclass