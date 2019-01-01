module synch_fifo_3
(input logic clk,rst,we,re,
input logic [15:0] din,
output logic [15:0] dout,
output logic flagf,flage);
int wp,rp;
reg [15:0] ram [15:0];
always_ff @ (posedge clk)
begin
 	if (rst)
	begin
	wp<=-1; rp<=-1;
	flage<=1'b0;
	flagf<=1'b0;
	end

	else
	begin
		case({we,re})
		2'b00:  begin
			wp<=wp; rp<=rp; 
			end
		2'b10:  begin
			if (flagf!=1)
			begin
				if (wp==-1)
				begin
				wp<=0; flagf<=0; flage<=0;
				end
				else if ((wp==15&&rp==-1))
				begin
				wp<=-1;
				flagf<=1;	
				flage<=0;		
				end
				else if (wp==15&&rp!=0)
				wp<=0;
				else if (rp!=(wp))
				wp<=wp+1;
				else
				begin
				wp<=-1;
				flagf<=1;	
				flage<=0;		
				end
			end
			
			else
			begin
			flagf<=flagf; wp<=wp; flage<=flage;
			end
			end

		2'b01: begin
			if (flage!=1)
			begin
				if (rp==-1)
				begin
				rp<=0;
				flagf<=0;
				end
				else if (rp==wp)
				begin
				flage<=1;
				flagf<=0;
				rp<=-1; wp<=-1;
				end
				else if (rp==15)
				begin
				flagf<=0;
				rp<=0;
				end
				else
				begin
				flagf<=0;
				rp<=rp+1;
				end
			end
			
			else
			begin
			flage<=flage; rp<=rp; flagf<=flagf;
			end
			end

		2'b11: begin
			begin
			if (flagf!=1)
			begin
				if (wp==-1)
				begin
				wp<=0; flagf<=0; flage<=0;
				end
				else if ((wp==15&&rp==-1))
				begin
				wp<=-1;
				flagf<=1;	
				flage<=0;		
				end
				else if (wp==15&&rp!=0)
				wp<=0;
				else if (rp!=(wp))
				wp<=wp+1;
				else
				begin
				wp<=-1;
				flagf<=1;	
				flage<=0;		
				end
			end
			
			else
			begin
			flagf<=flagf; wp<=wp; flage<=flage;
			end
			end
			if (flage!=1)
			begin
				if (rp==-1)
				begin
				rp<=0;
				flagf<=0;
				end
				else if (rp==wp)
				begin
				flage<=1;
				flagf<=0;
				rp<=-1; wp<=-1;
				end
				else if (rp==15)
				begin
				flagf<=0;
				rp<=0;
				end
				else
				begin
				flagf<=0;
				rp<=rp+1;
				end
			end
			
			else
			begin
			flage<=flage; rp<=rp; flagf<=flagf;
			end
			end
			
		endcase
	end

end

always_ff @ (posedge clk)
begin
case({we,re})
2'b00:dout<=16'bx;
2'b01:dout<=ram[rp];
2'b10:ram[wp]<=din;
2'b11: begin
	ram[wp]<=din;
	dout<=ram[rp];
	end
endcase
/*if (we==1)
ram[wp]<=din;
if (re==1)
dout<=ram[rp];
end
*/
end
endmodule

	 