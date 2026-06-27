module Data_Memory(A,clk,rst,WD,WE,RD);
    input rst,clk,WE;
    input [31:0] A,WD;
    output [31:0]RD;
    
    reg [31:0] Data_Mem [1023:0];
    
    assign RD = (WE == 1'b0) ? Data_Mem[A] : 32'h00000000;
    
    always @(posedge clk)
    begin
      if(WE)
        begin
        Data_Mem[A] <= WD;
        end
    end
endmodule
