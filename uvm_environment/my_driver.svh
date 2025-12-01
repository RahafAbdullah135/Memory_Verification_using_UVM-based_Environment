class my_driver extends uvm_driver#(my_sequence_item,my_sequence_item);
    `uvm_component_utils(my_driver)

    virtual intf     config_virtual ;

    my_sequence_item my_sequence_item_inst;

    function new (string name = "my_driver" , uvm_component parent = null);
        super.new(name,parent);   
    endfunction

    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        $display("my driver build phase");
        my_sequence_item_inst = my_sequence_item::type_id::create("my_sequence_item_inst",this);
        if(!uvm_config_db#(virtual intf)::get(this,"","my_vif",config_virtual)) 
            `uvm_fatal(get_full_name(),"Error!")
    endfunction

    function void connect_phase (uvm_phase phase);
        super.connect_phase(phase);
        $display("my driver connect phase");
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        $display("my driver run phase");
        forever 
            begin
                seq_item_port.get_next_item(my_sequence_item_inst);
                @(config_virtual.driver_cb) ;
                config_virtual.rst     <= my_sequence_item_inst.rst ;
                config_virtual.WE      <= my_sequence_item_inst.WE ;
                config_virtual.RE      <= my_sequence_item_inst.RE ;
                config_virtual.Address <= my_sequence_item_inst.Address ;
                config_virtual.Data_in <= my_sequence_item_inst.Data_in ;
                my_sequence_item_inst.display("driver") ;
                #1step 
                seq_item_port.item_done();
            end
    endtask

    function void extract_phase (uvm_phase phase);
        super.extract_phase(phase);
        $display("my driver extract phase");
    endfunction

endclass