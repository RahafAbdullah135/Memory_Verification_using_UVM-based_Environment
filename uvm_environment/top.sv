module top ;
    import uvm_pkg::*;
    import pack::*;

    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 4 ;
    parameter MEM_DEPTH  = 16 ;

    logic clk ;

    intf in1 (clk);
    memory16x32 #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH),.MEM_DEPTH(MEM_DEPTH)) memory16x32_inst(in1.dut_modport);

    initial 
        begin
            clk = 0 ;
            forever #5 clk = ~clk ;
        end

    initial 
        begin
            uvm_config_db#(virtual intf)::set(null,"uvm_test_top","my_vif",in1);
            run_test("my_test");
            #100;
            $stop;
        end
endmodule