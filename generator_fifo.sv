class generator_fifo;
packet_fifo pkt;
int j;
mailbox #(packet_fifo) gen_drv;
function new (mailbox #(packet_fifo) gen_drv);
this.gen_drv=gen_drv;
endfunction
task run;
pkt=new();
assert (pkt.randomize())
begin
$display("success");
gen_drv.put(pkt);
end
else
$error("randomization failed");
/*
$write($time,"---------");
$write($time,"\nwithout rand val\n");
pkt.print();
$write($time,"\nwith rand val\n");
#10 j=pkt.randomize();
pkt.print();
$write($time,"-----------");
$write($time,"\nwith rand off\n ");
pkt.rand_mode(0);
#20 j=pkt.randomize();
pkt.print();
$write($time,"--------");
$write($time,"\nwith rand on\n");
pkt.rand_mode(1);
#30 j=pkt.randomize();
pkt.print();
$write($time,"----------");
$write($time,"\nwith rand off on din\n");
pkt.din.rand_mode(0);
#40 j=pkt.randomize();
pkt.print();*/
endtask
endclass