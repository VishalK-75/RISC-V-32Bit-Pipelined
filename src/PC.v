module PC(PC_Next,PC,EN,rst,clk);
    input [31:0] PC_Next;
    input rst,clk,EN;
    output reg [31:0] PC;
    
    always @(posedge clk)
    begin   
    if (rst == 1'b1)
      begin
      PC <= 32'h00000000;
      end
    else if(EN)
      begin
      PC <= PC_Next;
      end    
    end   
endmodule
