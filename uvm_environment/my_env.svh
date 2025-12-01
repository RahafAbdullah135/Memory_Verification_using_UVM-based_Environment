class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    virtual intf  config_virtual ;

    my_agent      my_agent_inst;
    my_subscriber my_subscriber_inst;
    my_scoreboard my_scoreboard_inst;

    function new (string name = "my_env" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction
       
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my env build phase");
        my_agent_inst      = my_agent::type_id::create("my_agent_inst",this);
        my_subscriber_inst = my_subscriber::type_id::create("my_subscriber_inst",this);
        my_scoreboard_inst = my_scoreboard::type_id::create("my_scoreboard_inst",this);
        if(!uvm_config_db#(virtual intf)::get(this,"","my_vif",config_virtual)) 
            `uvm_fatal(get_full_name(),"Error!")
        uvm_config_db#(virtual intf)::set(this,"my_agent_inst","my_vif",config_virtual);
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my env connect phase");
        my_agent_inst.my_analysis_port.connect(my_scoreboard_inst.my_analysis_imp);
        my_agent_inst.my_analysis_port.connect(my_subscriber_inst.analysis_export);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my env run phase");
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my env extract phase");
    endfunction

endclass