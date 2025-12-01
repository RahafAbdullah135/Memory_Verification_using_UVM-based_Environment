// import pack::*;
class Subscriber;
    Transaction            trans_inst ;
    mailbox #(Transaction) mbox = new(1) ;

    covergroup group_1 ;

        coverpoint trans_inst.rst {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }

        coverpoint trans_inst.RE {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }

        coverpoint trans_inst.WE {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }

        coverpoint trans_inst.Address {
            bins address[]={[0:15]};
        }

        coverpoint trans_inst.valid_out {
            bins low  = {0};
            bins high = {1};
            bins l_h  = (0=>1);
            bins h_l  = (1=>0);
        }

    endgroup


    function new ( mailbox #(Transaction) mbox);
        this.trans_inst = new() ;
        this.mbox       = mbox ;
        this.group_1    = new() ;
    endfunction

    task subscriber ();
        forever 
            begin
                mbox.get(trans_inst);
                group_1.sample();
            end
    endtask 

endclass 