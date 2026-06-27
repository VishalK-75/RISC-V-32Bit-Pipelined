module Decode_Cycle(
    input clk, rst, RegWriteW, FlushE,
    input [31:0] InstrD, PCD, PCPlus4D, ResultW,
    input [4:0] RdW,
    output RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,
    output [2:0] ALUControlE,
    output [31:0] RD1E, RD2E, Imm_ExtE, PCE, PCPlus4E,
    output [4:0] RS1_E, RS2_E, RdE,
    output [4:0] RS1_D, RS2_D);
    
   wire RegWriteD, ALUSrcD, MemWriteD, ResultSrcD, BranchD;
   wire [1:0] ImmSrcD;
   wire [2:0] ALUControlD;
   wire [31:0] RD1D, RD2D, Imm_ExtD;
   
   reg RegWriteD_r, ALUSrcD_r, MemWriteD_r, ResultSrcD_r, BranchD_r;
   reg [2:0] ALUControlD_r;
   reg [31:0] RD1D_r, RD2D_r, Imm_ExtD_r, PCD_r, PCPlus4D_r;
   reg [4:0] RdD_r, RS1D_r, RS2D_r;
   
   assign RS1_D = InstrD[19:15];
   assign RS2_D = InstrD[24:20];

   Control_Unit_Top Control(.funct3(InstrD[14:12]), 
                            .funct7(InstrD[31:25]), 
                            .Op(InstrD[6:0]),
                            .ALUControl(ALUControlD), 
                            .RegWrite(RegWriteD), 
                            .Branch(BranchD),
                            .MemWrite(MemWriteD), 
                            .ImmSrc(ImmSrcD), 
                            .ALUSrc(ALUSrcD), 
                            .ResultSrc(ResultSrcD));                                       
   
   Register_file RegFile(.A1(RS1_D), 
                            .A2(RS2_D), 
                            .A3(RdW), 
                            .WE3(RegWriteW), 
                            .WD3(ResultW),
                            .clk(clk), 
                            .rst(rst), 
                            .RD1(RD1D), 
                            .RD2(RD2D)); 

   Sign_Extend SignExt(.In(InstrD), 
                       .Imm_Ext(Imm_ExtD), 
                       .ImmSrc(ImmSrcD));
               
   always @(posedge clk) begin
       if (rst == 1'b1 || FlushE == 1'b1) begin
          RegWriteD_r   <= 1'b0;   
          ALUSrcD_r     <= 1'b0;
          MemWriteD_r   <= 1'b0;   
          ResultSrcD_r  <= 1'b0;
          BranchD_r     <= 1'b0;   
          ALUControlD_r <= 3'b000;
          RD1D_r        <= 32'h0;  
          RD2D_r        <= 32'h0;
          Imm_ExtD_r    <= 32'h0;  
          PCD_r         <= 32'h0;
          PCPlus4D_r    <= 32'h0;  
          RdD_r         <= 5'b0;
          RS1D_r        <= 5'b0;   
          RS2D_r        <= 5'b0;
       end 
       else begin
          RegWriteD_r   <= RegWriteD;   
          ALUSrcD_r     <= ALUSrcD;
          MemWriteD_r   <= MemWriteD;   
          ResultSrcD_r  <= ResultSrcD;
          BranchD_r     <= BranchD;     
          ALUControlD_r <= ALUControlD;
          RD1D_r        <= RD1D;        
          RD2D_r        <= RD2D;
          Imm_ExtD_r    <= Imm_ExtD;    
          PCD_r         <= PCD;
          PCPlus4D_r    <= PCPlus4D;    
          RdD_r         <= InstrD[11:7];
          RS1D_r        <= RS1_D;       
          RS2D_r        <= RS2_D;
      end  
   end 
   
   assign RegWriteE = RegWriteD_r;     
   assign ALUSrcE = ALUSrcD_r;
   assign MemWriteE = MemWriteD_r;     
   assign ResultSrcE = ResultSrcD_r; 
   assign BranchE = BranchD_r;         
   assign ALUControlE = ALUControlD_r; 
   assign RD1E = RD1D_r;               
   assign RD2E = RD2D_r;
   assign Imm_ExtE = Imm_ExtD_r;      
   assign PCE = PCD_r;                         
   assign PCPlus4E = PCPlus4D_r;       
   assign RdE = RdD_r;
   assign RS1_E = RS1D_r;              
   assign RS2_E = RS2D_r;                                                                                
endmodule