class scoreboard_fifo;
packet_fifo pkt1,pkt2;
mailbox #(packet_fifo) mon_sb;

function new (mailbox #(packet_fifo) mon_sb);
this.mon_sb=mon_sb;
endfunction

task run;
mon_sb.get(pkt1);
mon_sb.get(pkt2);
if (pkt1.flagf==pkt2.flagf&&pkt1.flage==pkt2.flage)
$display("success!! matched");
else
begin
$display("mismatch!!");
$display($time,"pkt1.flagf=%b pkt2.flagf=%b",pkt1.flagf,pkt2.flagf);
end
endtask
endclass