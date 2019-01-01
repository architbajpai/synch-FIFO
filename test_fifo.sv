module test_fifo ( intf_fifo i,intf_fifo j);
environment_fifo en;
initial begin
en=new(i,j);
en.build();
repeat(1000)
begin
#10 en.run();
end
end
endmodule