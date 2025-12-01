// import pack::*;
class Driver ;

    virtual intf           v_intf ;
    Transaction            trans_inst ;
    mailbox #(Transaction) mbox = new(1);
    event                  seq_start ;
    event                  seq_end ;

    function new(mailbox #(Transaction) mbox , virtual intf v_intf, event seq_start, event seq_end);
        this.trans_inst = new() ;
        this.mbox       = mbox ;
        this.v_intf     = v_intf ;
        this.seq_start  = seq_start ;
        this.seq_end    = seq_end ;
    endfunction 

    task drive ();
        forever 
            begin
                ->seq_start ;
                @(seq_end);
                mbox.get(trans_inst) ;
                trans_inst.display("Driver");
                @(v_intf.driver_cb) ;
                v_intf.rst     <= trans_inst.rst ;
                v_intf.WE      <= trans_inst.WE ;
                v_intf.RE      <= trans_inst.RE ;
                v_intf.Address <= trans_inst.Address ;
                v_intf.Data_in <= trans_inst.Data_in ;
                ->seq_start ;
            end
    endtask 

endclass 
