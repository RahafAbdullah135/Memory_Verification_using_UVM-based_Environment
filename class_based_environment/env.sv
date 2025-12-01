// import pack::*;
class   Env ;

    Sequencer   sequencer_inst ;
    Driver      driver_inst ;
    Monitor     monitor_inst ;
    Subscriber  subscriber_inst ;
    Scoreboard  scoreboard_inst ;

    mailbox #(Transaction)  seq_drive_mbox = new(1);
    mailbox #(Transaction)  mon_sub_mbox   = new(1);
    mailbox #(Transaction)  mon_scb_mbox   = new(1);

    event       seq_start ;
    event       seq_end ;
    event       scb_start ;
    event       scb_end ;

    function new(virtual intf v_intf);
        seq_drive_mbox   = new(1);
        mon_sub_mbox     = new(1);
        mon_scb_mbox     = new(1);
        
        sequencer_inst   = new(seq_drive_mbox, seq_start, seq_end);
        driver_inst      = new(seq_drive_mbox, v_intf, seq_start, seq_end);
        monitor_inst     = new(mon_sub_mbox, mon_scb_mbox, v_intf,scb_start,scb_end);
        subscriber_inst  = new(mon_sub_mbox);
        scoreboard_inst  = new(mon_scb_mbox,scb_start,scb_end);
    endfunction

    task run;    
            fork
                sequencer_inst.random_operation();
                driver_inst.drive();
                monitor_inst.monitor();
                scoreboard_inst.scoreboard();
                subscriber_inst.subscriber();
            join_any
            #25;
            $stop;
    endtask 
endclass 
