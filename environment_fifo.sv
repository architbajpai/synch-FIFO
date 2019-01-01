class environment_fifo;
mailbox #(packet_fifo) gen_drv;
mailbox #(packet_fifo) mon_sb;
virtual intf_fifo i;
virtual intf_fifo j;
generator_fifo g1;
driver_fifo d1;
monitor_fifo m1;
scoreboard_fifo s1;
coverage_fifo c1;
function new (virtual intf_fifo i, virtual intf_fifo j);

//this.gen_drv=gen_drv;
//this.mon_sb=mon_sb;
this.i=i;
this.j=j;
endfunction

function build();
gen_drv=new();
mon_sb=new();

g1=new(gen_drv);
d1=new(gen_drv,i,j);
m1=new(mon_sb,i,j);
s1=new(mon_sb);
c1=new(i);
endfunction

task run;
g1.run; d1.run; m1.run; s1.run; c1.sample;
endtask
endclass