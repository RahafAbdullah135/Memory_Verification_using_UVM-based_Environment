class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    virtual intf config_virtual ;

    my_env         my_env_inst;
    my_sequence_1  my_sequence_inst_1;

    function new (string name = "my_test" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction
    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my test build phase");
        my_env_inst = my_env::type_id::create("my_env_inst",this);
        my_sequence_inst_1 = my_sequence_1::type_id::create("my_sequence_inst_1");
        if(!uvm_config_db#(virtual intf)::get(this,"","my_vif",config_virtual)) 
            `uvm_fatal(get_full_name(),"Error!")
        uvm_config_db#(virtual intf)::set(this,"my_env_inst","my_vif",config_virtual);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my test connect phase");
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my test run phase");
        phase.raise_objection(this);
        my_sequence_inst_1.start(my_env_inst.my_agent_inst.my_sequencer_inst);
        phase.drop_objection(this);
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my test extract phase");
    endfunction
    
endclass