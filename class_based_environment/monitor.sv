// import pack::*;
class Monitor;
    Transaction            trans_inst ;
    virtual intf           v_intf ;
    mailbox #(Transaction) mbox_1 = new(1);
    mailbox #(Transaction) mbox_2 = new(1);
    event                  scb_start ;
    event                  scb_end ;
    function new (mailbox #(Transaction) mbox_1, mailbox #(Transaction) mbox_2, virtual intf v_intf,event scb_start, event scb_end);
        this.trans_inst = new() ;
        this.v_intf     = v_intf ;
        this.mbox_1     = mbox_1 ;
        this.mbox_2     = mbox_2 ;
        this.scb_start  = scb_start ;
        this.scb_end    = scb_end ;
    endfunction

    task monitor ();
        forever 
            begin
                @(v_intf.monitor_cb) ;
                trans_inst.rst       <= v_intf.rst ;   
                trans_inst.WE        <= v_intf.WE ; 
                trans_inst.RE        <= v_intf.RE ; 
                trans_inst.Address   <= v_intf.Address ; 
                trans_inst.Data_in   <= v_intf.Data_in ;
                trans_inst.Data_out  <= v_intf.Data_out ;
                trans_inst.valid_out <= v_intf.valid_out ;
                #1step ;
                mbox_1.put(trans_inst);
                mbox_2.put(trans_inst);
                trans_inst.display("monitor");
                ->scb_start;
            end     
    endtask 
endclass 