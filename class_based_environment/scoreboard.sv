// import pack::*;
class Scoreboard;

    parameter DATA_WIDTH = 32 ;
    parameter ADDR_WIDTH = 4 ;
    parameter MEM_DEPTH  = 16 ;

    Transaction            trans_inst ;
    mailbox #(Transaction) mbox = new(1);
    event                  scb_start ;
    event                  scb_end ;

    logic [DATA_WIDTH-1:0] mem [MEM_DEPTH] ;

    function new ( mailbox #(Transaction) mbox,event scb_start, event scb_end);
        this.trans_inst = new() ;
        this.mbox       = mbox ;
        this.scb_start  = scb_start ;
        this.scb_end    = scb_end ;
    endfunction

    task scoreboard ();
        forever 
            begin
                @(scb_start);
                mbox.get(trans_inst);
                trans_inst.display("scoreboard") ;
                if(!trans_inst.rst) 
                    begin
                        if(trans_inst.valid_out == 0)
                            begin
                                $display(" (reset is done) ");
                            end
                        else
                            begin
                                $display(" (error in reset) ");
                            end
                    end
                else if(trans_inst.WE) 
                    begin
                        mem[trans_inst.Address] = trans_inst.Data_in;
                        $display(" (writing operation) Address = %0d, Data = %0h", trans_inst.Address, trans_inst.Data_in);
                    end
                else if(trans_inst.RE) 
                    begin
                        if((mem[trans_inst.Address] !== trans_inst.Data_out) && trans_inst.valid_out !== 1) 
                            begin
                                $display(" (failed reading operation)  Address = %0d, Data : Expected = %0h, Actual = %0h valid = %0d",trans_inst.Address, mem[trans_inst.Address], trans_inst.Data_out, trans_inst.valid_out);
                            end
                        else 
                            begin
                                $display(" (passed reading operation)  Address = %0d, Data : Expected = %0h, Actual = %0h valid = %0d",trans_inst.Address, mem[trans_inst.Address], trans_inst.Data_out, trans_inst.valid_out);
                            end
                    end
                else
                    begin
                        $display(" (nothing to do) ") ;
                    end
            end
    endtask 
endclass 


