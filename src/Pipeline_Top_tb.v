module Pipeline_Top_tb();
    
    reg clkh=0,rst;
    
    Pipeline_Top uut(.clkh(clkh), .rst(rst));
    
    always begin
        clkh=~clkh;
        #50;
    end
    
    initial begin
        rst <= 1'b1;
        #100;
        rst <= 1'b0;
        #2000;
        $finish;
    end
    
    initial begin
       $dumpfile("dump.vcd");
       $dumpvars(0);
    end
endmodule
