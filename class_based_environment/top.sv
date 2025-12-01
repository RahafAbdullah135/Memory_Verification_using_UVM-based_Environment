// import pack::*;

module top ;
    import pack::*;

    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 4 ;
    parameter MEM_DEPTH  = 16 ;

    logic clk ;

    Env  env_inst ;
    intf intf_inst(clk) ;
    memory16x32 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.MEM_DEPTH(MEM_DEPTH)) memory16x32_inst(intf_inst.dut_modport);

    initial 
        begin
            clk = 0 ;
            forever #5 clk = ~clk ;
        end

    initial 
        begin
            env_inst = new(intf_inst.dut_modport);
            env_inst.run() ;
            $stop ;
        end
    
endmodule