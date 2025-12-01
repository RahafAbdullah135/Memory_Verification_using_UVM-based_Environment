class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)

    my_sequence_item my_sequence_item_inst;
    uvm_analysis_imp #(my_sequence_item,my_scoreboard) my_analysis_imp ;

    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 4 ;
    parameter MEM_DEPTH  = 16 ;

    logic [DATA_WIDTH-1:0] mem [MEM_DEPTH] ;

    function new (string name = "my_scoreboard" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction 

    function void write (my_sequence_item t);
        my_sequence_item_inst.display("scoreboard") ;
        my_sequence_item_inst = t ;
        if(!t.rst) 
            begin
                if(t.valid_out == 0)
                    begin
                        $display("(reset is done) ");
                    end
                else
                    begin
                        $display("(error in reset) ");
                    end
            end
        else if(t.WE) 
            begin
                mem[t.Address] = t.Data_in;
                $display("(writing operation) Address = %0d, Data = %0h", t.Address, t.Data_in);
            end
        else if(t.RE) 
            begin
                if((mem[t.Address] !== t.Data_out) && t.valid_out !== 1) 
                    begin
                        $display("(failed reading operation)  Address = %0d, Data : Expected = %0h, Actual = %0h valid = %0d",t.Address, mem[t.Address], t.Data_out, t.valid_out);
                    end
                else 
                    begin
                        $display("(passed reading operation)  Address = %0d, Data : Expected = %0h, Actual = %0h valid = %0d",t.Address, mem[t.Address], t.Data_out, t.valid_out);
                    end
            end
        else
            begin
                $display("(nothing to do) ") ;
            end
    endfunction
    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my scoreboard build phase");
        my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst",this);
        my_analysis_imp = new("my_analysis_imp",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my scoreboard connect phase");
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my scoreboard run phase");
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my scoreboard extract phase");
    endfunction

endclass