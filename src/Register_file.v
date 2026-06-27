module Register_file(A1,A2,A3,WE3,WD3,clk,rst,RD1,RD2);
    input [4:0] A1,A2,A3;
    input [31:0] WD3;
    input clk,rst,WE3;
    output [31:0] RD1,RD2;
    
    reg [31:0] Register [31:0];
    
    always @(posedge clk)
    begin
      if(WE3)
       begin
       Register[A3] <= WD3;
       end
    end      
    
    assign RD1 = (rst) ? 32'd0 : ((A1 == 5'b00000) ? 32'h00000000 : Register[A1]);
    assign RD2 = (rst) ? 32'd0 : ((A2 == 5'b00000) ? 32'h00000000 : Register[A2]);
     
     initial begin 
        Register[5] = 32'h00000005;
        Register[6] = 32'h00000004;
     end
endmodule
