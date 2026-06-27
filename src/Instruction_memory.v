module Instr_memory(rst,A,RD);
    input rst;
    input [31:0] A;
    output [31:0] RD;
    
    reg [31:0] Mem [1023:0];
    
    assign RD = (rst == 1'b1) ? 32'h00000000 : Mem[A[31:2]];  
    
  initial begin
   $readmemh("E:/RISC_V Pipeline/RISC_V Pipeline/RISC_V Pipeline.srcs/sources_1/new/memoryfile.txt",Mem);
  end

 
    //integer i;
    //initial begin
      //  for (i = 0; i < 1024; i = i + 1) begin
        //    Mem[i] = 32'h00000013; 
        //end
        
       // Mem[0] = 32'h0062E3B3; // or  x7, x5, x6
        //Mem[1] = 32'h0062F433; // and x8, x5, x6
    //end
endmodule
