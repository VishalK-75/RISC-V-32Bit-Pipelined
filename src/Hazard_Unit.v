module Hazard_Unit(
    input rst, RegWriteM, RegWriteW, ResultSrcE,
    input [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW,
    output reg [1:0] ForwardAE, ForwardBE,
    output StallF, StallD, FlushE);
    
    always @(*) begin
        if ((RegWriteM == 1'b1) && (RdM != 5'b0) && (RdM == Rs1E))
            ForwardAE = 2'b10;
        else if ((RegWriteW == 1'b1) && (RdW != 5'b0) && (RdW == Rs1E))
            ForwardAE = 2'b01; 
        else
            ForwardAE = 2'b00; 
        if ((RegWriteM == 1'b1) && (RdM != 5'b0) && (RdM == Rs2E))
            ForwardBE = 2'b10; 
        else if ((RegWriteW == 1'b1) && (RdW != 5'b0) && (RdW == Rs2E))
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
    end

    wire lwStall;
    assign lwStall = (ResultSrcE == 1'b1) && ((RdE == Rs1D) || (RdE == Rs2D));
    assign StallF = (rst) ? 1'b0 : lwStall;
    assign StallD = (rst) ? 1'b0 : lwStall;
    assign FlushE = (rst) ? 1'b0 : lwStall;                 
endmodule