module memory16x32 #(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 4 ,
    parameter MEM_DEPTH  = 16 
)
(intf intf1);

 logic [DATA_WIDTH-1:0] mem [MEM_DEPTH] ;
 logic [DATA_WIDTH-1:0] Data_out_reg ;
 logic                  valid_out_reg ;
 
 always_ff @(posedge intf1.clk or negedge intf1.rst) 
     begin
         if (!(intf1.rst)) 
             begin
                 valid_out_reg <= 1'b0  ;
             end 
         else if (intf1.WE)
             begin
                 mem[intf1.Address] <= intf1.Data_in ;
                 valid_out_reg <= 1'b0  ;
             end
         else if (intf1.RE) 
             begin
                 Data_out_reg  <= mem[intf1.Address] ;
                 valid_out_reg <= 1'b1 ;
             end
         else
             begin
                 valid_out_reg <= 1'b0  ;
             end 
     end
     
 assign intf1.Data_out  = Data_out_reg  ;
 assign intf1.valid_out = valid_out_reg ;
 
endmodule