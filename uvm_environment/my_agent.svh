class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    virtual intf config_virtual ;

    my_driver    my_driver_inst;
    my_monitor   my_monitor_inst;
    my_sequencer my_sequencer_inst;

    uvm_analysis_port #(my_sequence_item) my_analysis_port ;

    function new (string name = "my_agent" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction
       
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my agent build phase");
        my_driver_inst    = my_driver::type_id::create("my_driver_inst",this);
        my_monitor_inst   = my_monitor::type_id::create("my_monitor_inst",this);
        my_sequencer_inst = my_sequencer::type_id::create("my_sequencer_inst",this);
        my_analysis_port  = new("my_analysis_port", this);
        if(!uvm_config_db#(virtual intf)::get(this,"","my_vif",config_virtual)) 
            `uvm_fatal(get_full_name(),"Error!")
        uvm_config_db#(virtual intf)::set(this,"my_driver_inst","my_vif",config_virtual);
        uvm_config_db#(virtual intf)::set(this,"my_monitor_inst","my_vif",config_virtual);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my agent connect phase");
        my_monitor_inst.my_analysis_port.connect(this.my_analysis_port) ;
        my_driver_inst.seq_item_port.connect(my_sequencer_inst.seq_item_export);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my agent run phase");
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my agent extract phase");
    endfunction

endclass