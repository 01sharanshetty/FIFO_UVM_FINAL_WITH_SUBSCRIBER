class subscriber_fifo extends uvm_subscriber #(transactions_fifo);
  uvm_analysis_imp #(transactions_fifo, subscriber_fifo) analysis_p1;
  `uvm_component_utils(subscriber_fifo)
  
    transactions_fifo fsi;


    covergroup cg;
    
        cov_i_wren_p : coverpoint fsi.i_wren;
        
        cov_i_rden_p : coverpoint fsi.i_rden;
      
        cov_o_full_p  : coverpoint fsi.o_full;
      
        cov_o_alm_full_p  : coverpoint fsi.o_alm_full;
      
        cov_o_alm_empty_p  : coverpoint fsi.o_alm_empty ;
      
        cov_empty_p  : coverpoint fsi.o_empty;
      

         
      write_X_read: cross cov_i_wren_p, cov_i_rden_p;
      full_X_empty: cross cov_o_full_p, cov_empty_p;
      alm_full_X_alm_empty: cross cov_o_alm_full_p, cov_o_alm_empty_p;
      
    endgroup
  
        
  function new(string name="f_subscriber", uvm_component parent);
        super.new(name, parent);
        analysis_p1 = new("analysis_p1",this);
    fsi=transactions_fifo::type_id::create("fsi");
        cg = new();
    endfunction: new

  function void write(transactions_fifo t);
        fsi=t;
    cg.sample();
    $display("Coverage is=%0d", cg.get_coverage());
    endfunction: write
  
	

endclass