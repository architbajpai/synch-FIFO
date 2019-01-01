module synch_fifo
(input logic clk,rst,we,re,
input logic [15:0] din,
output logic [15:0] dout,
output logic flagf,flage);
reg [15:0] ram [15:0];
int rp,wp;
always_ff @ (posedge clk)
begin
	if (rst)
	begin
	dout<=0;
	flagf<=0;
	flage<=0;
	rp<=-1;
	wp<=-1;
	end

	else
	begin
	$display("fifo last content is: %d ",ram[rp]);
		if ((we==1)&&(flagf!=1))
		begin
			if (wp==-1)
			begin 
			$display("flagf:%d",flagf);
			ram[0]<=din;
			wp<=0;
			rp<=0;
			end
			
			else if (wp==rp)
			flagf<=1;

			else if (wp>rp)
			begin
			ram[wp]<=din;
				if (wp==15&&rp==0)
				flagf<=1;
				else if (wp==15)
				wp<=0;
				else
				wp<=wp+1;
			end
			

			else
			begin
			ram[wp]<=din;
				if ((wp+1)==rp)
				begin
				wp<=wp+1;
				flagf<=1;
				end
				else
				wp<=wp+1;
			end
		end
		
		else if ((we==1)&&(flagf==1))
		begin
		flagf<=1; flage<=0; //dout<=ram[rp];
		$display("can't insert! queue overflow!!!");
		end
		else
		begin
		flagf<=flagf; flage<=flage; //dout<=ram[rp];
		end


		if((re==1)&&(flage!=1))
		begin
		$display("fifo last content is: %d ",ram[rp]);
			if (rp==-1)
			begin
			flage<=-1;
			$display("underflow!!");
			end

			else if (rp==wp)
			begin
			dout<=ram[rp];
			rp<=-1; wp<=-1;		
			end
			
			else
			begin
			dout<=ram[rp];	rp<=rp+1;
			end
		end
		
		else if((re==1)&&(flage==1))	
		begin
		flagf<=0; flage<=1; dout<=16'bx;
		$display("can't read! queue underflow!!!");
		end
	
		else
		begin
		flagf<=flagf; flage<=flage;
		end

end
end
endmodule

