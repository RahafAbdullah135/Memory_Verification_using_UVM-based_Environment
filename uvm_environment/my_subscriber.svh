class my_subscriber extends uvm_subscriber#(my_sequence_item);
   `uvm_component_utils(my_subscriber)

   my_sequence_item my_sequence_item_inst;

   covergroup group_1 ;
        coverpoint my_sequence_item_inst.rst {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }
        coverpoint my_sequence_item_inst.RE {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }
        coverpoint my_sequence_item_inst.WE {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }
        coverpoint my_sequence_item_inst.Address {
            bins address[]={[0:15]};
        }
        coverpoint my_sequence_item_inst.valid_out {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }
    endgroup

    function new (string name = "my_subscriber" , uvm_component parent = null);
        super.new(name,parent);
        group_1 = new();   
    endfunction

    function void write (my_sequence_item t);
        my_sequence_item_inst.display("subscriber") ;
        my_sequence_item_inst = t ;
        group_1.sample();
    endfunction

    function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       $display("my subscriber build phase");
       my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst",this);
    endfunction

    function void connect_phase (uvm_phase phase);
       super.connect_phase(phase);
       $display("my subscriber connect phase");
    endfunction

    task run_phase (uvm_phase phase);
       super.run_phase(phase);
       $display("my subscriber run phase");
    endtask

    function void extract_phase (uvm_phase phase);
       super.extract_phase(phase);
       $display("my subscriber extract phase");
    endfunction

endclass