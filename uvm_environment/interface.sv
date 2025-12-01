interface intf (input logic clk);
    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 4 ;
    parameter MEM_DEPTH  = 16 ;

    logic                     rst ;
    logic                     WE ;
    logic                     RE ;
    logic  [ADDR_WIDTH-1:0]   Address ;
    logic  [DATA_WIDTH-1:0]   Data_in ;
    logic  [DATA_WIDTH-1:0]   Data_out ;
    logic                     valid_out ;

	clocking driver_cb @(posedge clk);
		default output #0;
		output Address ;
		output WE ;
		output RE ;
		output Data_in ;
		input  Data_out ;
		input  valid_out ;
	endclocking
	

	clocking monitor_cb @(posedge clk);
		default input #0 ;
		input  Address ;
		input  WE ;
		input  RE ;
		input  Data_in ;
		input  Data_out ;
		input  valid_out ;
	endclocking
	
    modport dut_modport (
        input   clk,
        input   rst,
        input   WE,
        input   RE,
        input   Address,
        input   Data_in,
        output  Data_out,
        output  valid_out 
    );
endinterface