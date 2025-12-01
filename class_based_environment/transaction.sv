// import pack::*;
class Transaction ;

    parameter int DATA_WIDTH = 32 ;
    parameter int ADDR_WIDTH = 4  ;
    parameter int MEM_DEPTH  = 16 ;
 
    rand  logic                     rst ;
    rand  logic                     WE ;
    rand  logic                     RE ;
    randc logic  [ADDR_WIDTH-1:0]   Address ;
    rand  logic  [DATA_WIDTH-1:0]   Data_in ;

          logic  [DATA_WIDTH-1:0]   Data_out ;
          logic                     valid_out ;    

    function new ();

    endfunction    

    function void pre_randomize ();
        //rst = 1'b1 ;
    endfunction
    
    function void post_randomize ();
        //rst = 1'b1 ;
    endfunction


    constraint rst_c{
        if(!rst){
            RE      == 0 ;
            WE      == 0 ;
            Address =='b0 ;
            Data_in == 0 ;
        }
    }

    constraint WE_c{
        WE dist {0:=50,1:=50};
    }

    constraint RE_c{
        RE dist {0:=50,1:=50};
    }

    constraint Address_c{
        Address inside {[0:15]};
    }
    

    task display (string class_name="");
        $display(" (%s) at time = %0t --> rst=%0b, WE=%0b , RE=%0b , Address=%0d , Data_in=%0h , Data_out=%0h , valid=%0b",
                  class_name, $time,rst , WE, RE, Address, Data_in, Data_out, valid_out);
    endtask 
       
endclass 