class my_monitor extends uvm_monitor ;
    `uvm_component_utils(my_monitor)

    virtual intf     config_virtual ;

    my_sequence_item   my_sequence_item_inst;
    uvm_analysis_port #(my_sequence_item) my_analysis_port ;

    function new (string name = "my_monitor" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction
       
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my monitor build phase");
        my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst",this);
        my_analysis_port = new("my_analysis_port",this) ;
        if(!uvm_config_db#(virtual intf)::get(this,"","my_vif",config_virtual)) 
            `uvm_fatal(get_full_name(),"Error!")
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my monitor connect phase");
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);     
        $display("my monitor run phase"); 
        forever 
            begin
                @(config_virtual.monitor_cb) ;
                my_sequence_item_inst.rst       <= config_virtual.rst;
                my_sequence_item_inst.WE        <= config_virtual.WE;  
                my_sequence_item_inst.RE        <= config_virtual.RE; 
                my_sequence_item_inst.Address   <= config_virtual.Address;
                my_sequence_item_inst.Data_in   <= config_virtual.Data_in;
                my_sequence_item_inst.Data_out  <= config_virtual.Data_out;
                my_sequence_item_inst.valid_out <= config_virtual.valid_out;
                # 1step ;
                my_sequence_item_inst.display("monitor") ;
                my_analysis_port.write(my_sequence_item_inst) ;
                
                
            end
        
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my monitor extract phase");
    endfunction

endclass