class monitor_fifo;
packet_fifo pkt1,pkt2;
mailbox #(packet_fifo) mon_sb;
virtual intf_fifo i;
virtual intf_fifo j;
function new (mailbox #(packet_fifo) mon_sb,virtual intf_fifo i,virtual intf_fifo j);
this.mon_sb=mon_sb;
this.i=i;
this.j=j;
endfunction

task run;
pkt1=new(); pkt2=new();
pkt1.we=i.we;
pkt1.re=i.re;
pkt1.din=i.din;
pkt1.dout=i.dout;
pkt1.flagf=i.flagf;
pkt1.flage=i.flage;
mon_sb.put(pkt1);
pkt2.we=j.we;
pkt2.re=j.re;
pkt2.din=j.din;
pkt2.dout=j.dout;
pkt2.flagf=j.flagf;
pkt2.flage=j.flage;
mon_sb.put(pkt2);

endtask
endclass