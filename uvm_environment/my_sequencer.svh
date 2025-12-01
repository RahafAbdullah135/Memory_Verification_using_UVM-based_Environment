class my_sequencer extends uvm_sequencer#(my_sequence_item,my_sequence_item);
    `uvm_component_utils(my_sequencer)

    my_sequence_item my_sequence_item_inst;

    function new (string name = "my_sequencer" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction
       
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my sequencer build phase");
        my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst",this);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my sequencer connect phase");
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my sequencer run phase");
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my sequencer extract phase");
    endfunction

endclass