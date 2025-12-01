// import pack::*;
class Sequencer ;

    Transaction             trans_inst ;
    mailbox #(Transaction)  mbox = new(1);
    event                   seq_start ;
    event                   seq_end ;

    function new (mailbox #(Transaction) mbox, event seq_start, event seq_end);
        this.mbox       = mbox ;
        this.seq_start  = seq_start ;
        this.seq_end    = seq_end ;
        this.trans_inst = new() ;
    endfunction
    
    task random_operation ();

        repeat(1)
            begin   
                @(seq_start) ;     
                $display("==================== Initialization ====================");    
                trans_inst.rst     = 1'b1 ;
                trans_inst.WE      = 1'b0 ;
                trans_inst.RE      = 1'b0 ;
                trans_inst.Address =  'b0 ;
                trans_inst.Data_in =  'b0 ;
                mbox.put(trans_inst);
                trans_inst.display("sequencer") ;
                -> seq_end ;          
            end

        repeat(2)
            begin   
                @(seq_start) ;         
                if (trans_inst.randomize() with {rst==0;}) 
                    begin
                        $display("==================== randomization started ====================");
                        mbox.put(trans_inst);
                        trans_inst.display("sequencer") ;
                    end    
                else
                    begin
                        $fatal("==================== randomization falied ====================");
                    end  
                -> seq_end ;          
            end

        repeat(20)
            begin   
                @(seq_start) ;         
                if (trans_inst.randomize() with {rst==1; WE==1; RE==0;}) 
                    begin
                        $display("==================== randomization started ====================");
                        mbox.put(trans_inst);
                        trans_inst.display("sequencer") ;
                    end    
                else
                    begin
                        $fatal("==================== randomization falied ====================");
                    end  
                -> seq_end ;          
            end

            repeat(20)
            begin   
                @(seq_start) ;         
                if (trans_inst.randomize() with {rst==1; WE==0; RE==1;}) 
                    begin
                        $display("==================== randomization started ====================");
                        mbox.put(trans_inst);
                        trans_inst.display("sequencer") ;
                    end    
                else
                    begin
                        $fatal("==================== randomization falied ====================");
                    end  
                -> seq_end ;          
            end

             repeat(20)
            begin   
                @(seq_start) ;         
                if (trans_inst.randomize()) 
                    begin
                        $display("==================== randomization started ====================");
                        mbox.put(trans_inst);
                        trans_inst.display("sequencer") ;
                    end    
                else
                    begin
                        $fatal("==================== randomization falied ====================");
                    end  
                -> seq_end ;          
            end
    endtask 

endclass 