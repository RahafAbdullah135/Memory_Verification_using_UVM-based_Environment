class my_sequence_1 extends uvm_sequence;
    `uvm_object_utils(my_sequence_1)

    my_sequence_item my_sequence_item_inst ;

    function new (string name = "my_sequence");
        super.new(name);   
    endfunction

    task pre_body;
        my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst") ;
    endtask

    task body;      
        repeat(2)
            begin
                start_item(my_sequence_item_inst);
                $display("==================== Initialization ====================");    
                my_sequence_item_inst.rst     = 1'b1 ;
                my_sequence_item_inst.WE      = 1'b0 ;
                my_sequence_item_inst.RE      = 1'b0 ;
                my_sequence_item_inst.Address =  'b0 ;
                my_sequence_item_inst.Data_in =  'b0 ;
                my_sequence_item_inst.display("sequence") ;
                finish_item(my_sequence_item_inst);
            end        
          
        repeat(2)
            begin
                start_item(my_sequence_item_inst);
                $display("==================== Randomization ====================");    
                my_sequence_item_inst.randomize() with {rst==0;};
                my_sequence_item_inst.display("sequence") ;
                finish_item(my_sequence_item_inst);
            end        
        
        repeat(16)
            begin
                start_item(my_sequence_item_inst);
                $display("==================== Randomization ====================");    
                my_sequence_item_inst.randomize() with {rst==1; WE==1; RE==0;};
                my_sequence_item_inst.display("sequence") ;
                finish_item(my_sequence_item_inst);
            end        
       
        repeat(16)
            begin
                start_item(my_sequence_item_inst);
                $display("==================== Randomization ====================");    
                my_sequence_item_inst.randomize() with {rst==1; WE==0; RE==1;};
                my_sequence_item_inst.display("sequence") ;
                finish_item(my_sequence_item_inst);
            end        
        
        repeat(16)
            begin
                start_item(my_sequence_item_inst);
                $display("==================== Randomization ====================");    
                my_sequence_item_inst.randomize();
                my_sequence_item_inst.display("sequence") ;
                finish_item(my_sequence_item_inst);
            end        
            
        
    endtask
endclass
