/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module task3_5 (
    input clk,
    input rst,
    input enable,
    input r,
    input b,
    input g,
    input y,
    output reg rout,
    output reg bout,
    output reg gout,
    output reg yout,
    output reg [2:0] out
  );
  
  
  
  wire [1-1:0] M_edr_out;
  reg [1-1:0] M_edr_in;
  edge_detector_9 edr (
    .clk(clk),
    .in(M_edr_in),
    .out(M_edr_out)
  );
  wire [1-1:0] M_bcr_out;
  reg [1-1:0] M_bcr_in;
  button_conditioner_10 bcr (
    .clk(clk),
    .in(M_bcr_in),
    .out(M_bcr_out)
  );
  wire [1-1:0] M_edb_out;
  reg [1-1:0] M_edb_in;
  edge_detector_9 edb (
    .clk(clk),
    .in(M_edb_in),
    .out(M_edb_out)
  );
  wire [1-1:0] M_bcb_out;
  reg [1-1:0] M_bcb_in;
  button_conditioner_10 bcb (
    .clk(clk),
    .in(M_bcb_in),
    .out(M_bcb_out)
  );
  wire [1-1:0] M_edg_out;
  reg [1-1:0] M_edg_in;
  edge_detector_9 edg (
    .clk(clk),
    .in(M_edg_in),
    .out(M_edg_out)
  );
  wire [1-1:0] M_bcg_out;
  reg [1-1:0] M_bcg_in;
  button_conditioner_10 bcg (
    .clk(clk),
    .in(M_bcg_in),
    .out(M_bcg_out)
  );
  wire [1-1:0] M_edy_out;
  reg [1-1:0] M_edy_in;
  edge_detector_9 edy (
    .clk(clk),
    .in(M_edy_in),
    .out(M_edy_out)
  );
  wire [1-1:0] M_bcy_out;
  reg [1-1:0] M_bcy_in;
  button_conditioner_10 bcy (
    .clk(clk),
    .in(M_bcy_in),
    .out(M_bcy_out)
  );
  reg [1:0] M_stage_d, M_stage_q = 1'h0;
  reg [29:0] M_counter_d, M_counter_q = 1'h0;
  reg [0:0] M_offon_d, M_offon_q = 1'h0;
  reg [3:0] M_sequence_d, M_sequence_q = 1'h0;
  localparam IDLE_state = 4'd0;
  localparam SEQ1_state = 4'd1;
  localparam INPUT1_state = 4'd2;
  localparam ERR_state = 4'd3;
  localparam SEQ2_state = 4'd4;
  localparam INPUT2_state = 4'd5;
  localparam SEQ3_state = 4'd6;
  localparam INPUT3_state = 4'd7;
  localparam WIN_state = 4'd8;
  
  reg [3:0] M_state_d, M_state_q = IDLE_state;
  
  always @* begin
    M_state_d = M_state_q;
    M_sequence_d = M_sequence_q;
    M_offon_d = M_offon_q;
    M_counter_d = M_counter_q;
    M_stage_d = M_stage_q;
    
    M_edr_in = M_bcr_out;
    M_bcr_in = r;
    M_edb_in = M_bcb_out;
    M_bcb_in = b;
    M_edg_in = M_bcg_out;
    M_bcg_in = g;
    M_edy_in = M_bcy_out;
    M_bcy_in = y;
    out = 1'h0;
    rout = r;
    bout = b;
    gout = g;
    yout = y;
    
    case (M_state_q)
      IDLE_state: begin
        if (enable) begin
          M_stage_d = M_stage_q + 1'h1;
          M_state_d = SEQ1_state;
        end
      end
      SEQ1_state: begin
        rout = 1'h0;
        bout = 1'h0;
        gout = 1'h0;
        yout = 1'h0;
        if (M_offon_q) begin
          
          case (M_sequence_q)
            1'h1: begin
              rout = 1'h1;
            end
            2'h2: begin
              bout = 1'h1;
            end
            2'h3: begin
              bout = 1'h1;
            end
            3'h4: begin
              yout = 1'h1;
            end
            3'h5: begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_offon_d = 1'h0;
              M_state_d = INPUT1_state;
            end
          endcase
        end
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[23+0-:1] == 1'h1 && !M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1 && M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
          M_sequence_d = M_sequence_q + 1'h1;
        end
      end
      INPUT1_state: begin
        
        case (M_sequence_q)
          1'h0: begin
            if (M_edb_out) begin
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          1'h1: begin
            if (M_edr_out) begin
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h2: begin
            if (M_edr_out) begin
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h3: begin
            if (M_edg_out) begin
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edr_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h4: begin
            M_sequence_d = 1'h0;
            M_stage_d = M_stage_q + 1'h1;
            M_state_d = SEQ2_state;
          end
        endcase
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q == 27'h5f5e100 && M_sequence_q == 1'h0) begin
          M_counter_d = 1'h0;
          M_state_d = SEQ1_state;
        end
      end
      SEQ2_state: begin
        rout = 1'h0;
        bout = 1'h0;
        gout = 1'h0;
        yout = 1'h0;
        if (M_offon_q) begin
          
          case (M_sequence_q)
            1'h0: begin
              rout = 1'h1;
              bout = 1'h1;
              gout = 1'h1;
              yout = 1'h1;
            end
            1'h1: begin
              gout = 1'h1;
            end
            2'h2: begin
              rout = 1'h1;
            end
            2'h3: begin
              yout = 1'h1;
            end
            3'h4: begin
              bout = 1'h1;
            end
            3'h5: begin
              gout = 1'h1;
            end
            3'h6: begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_offon_d = 1'h0;
              M_state_d = INPUT2_state;
            end
          endcase
        end
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[23+0-:1] == 1'h1 && !M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1 && M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
          M_sequence_d = M_sequence_q + 1'h1;
        end
      end
      INPUT2_state: begin
        
        case (M_sequence_q)
          1'h0: begin
            if (M_edb_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          1'h1: begin
            if (M_edy_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edg_out || M_edr_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h2: begin
            if (M_edr_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h3: begin
            if (M_edg_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edr_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h4: begin
            if (M_edb_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edg_out || M_edr_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h5: begin
            M_sequence_d = 1'h0;
            M_stage_d = M_stage_q + 1'h1;
            M_state_d = SEQ3_state;
          end
        endcase
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q == 27'h5f5e100 && M_sequence_q == 1'h0) begin
          M_counter_d = 1'h0;
          M_state_d = SEQ2_state;
        end
      end
      SEQ3_state: begin
        rout = 1'h0;
        bout = 1'h0;
        gout = 1'h0;
        yout = 1'h0;
        if (M_offon_q) begin
          
          case (M_sequence_q)
            1'h0: begin
              rout = 1'h1;
              bout = 1'h1;
              gout = 1'h1;
              yout = 1'h1;
            end
            1'h1: begin
              rout = 1'h1;
            end
            2'h2: begin
              yout = 1'h1;
            end
            2'h3: begin
              bout = 1'h1;
            end
            3'h4: begin
              rout = 1'h1;
            end
            3'h5: begin
              yout = 1'h1;
            end
            3'h6: begin
              bout = 1'h1;
            end
            3'h7: begin
              gout = 1'h1;
            end
            4'h8: begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_offon_d = 1'h0;
              M_state_d = INPUT3_state;
            end
          endcase
        end
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[23+0-:1] == 1'h1 && !M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
        end
        if (M_counter_q[25+0-:1] == 1'h1 && M_offon_q) begin
          M_counter_d = 1'h0;
          M_offon_d = M_offon_q + 1'h1;
          M_sequence_d = M_sequence_q + 1'h1;
        end
      end
      INPUT3_state: begin
        
        case (M_sequence_q)
          1'h0: begin
            if (M_edb_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          1'h1: begin
            if (M_edg_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edy_out || M_edr_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h2: begin
            if (M_edy_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edb_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          2'h3: begin
            if (M_edb_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edy_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h4: begin
            if (M_edg_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edb_out || M_edy_out || M_edr_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h5: begin
            if (M_edy_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edr_out || M_edg_out || M_edb_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h6: begin
            if (M_edr_out) begin
              M_counter_d = 1'h0;
              M_sequence_d = M_sequence_q + 1'h1;
            end
            if (M_edy_out || M_edg_out || M_edb_out) begin
              M_sequence_d = 1'h0;
              M_counter_d = 1'h0;
              M_state_d = ERR_state;
            end
          end
          3'h7: begin
            M_sequence_d = 1'h0;
            M_stage_d = M_stage_q + 1'h1;
            M_state_d = WIN_state;
          end
        endcase
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q == 27'h5f5e100 && M_sequence_q == 1'h0) begin
          M_counter_d = 1'h0;
          M_state_d = SEQ3_state;
        end
      end
      ERR_state: begin
        rout = 1'h1;
        bout = 1'h1;
        gout = 1'h1;
        yout = 1'h1;
        M_counter_d = M_counter_q + 1'h1;
        if (M_counter_q[27+0-:1] == 1'h1) begin
          M_counter_d = 1'h0;
          
          case (M_stage_q)
            1'h1: begin
              M_state_d = SEQ1_state;
            end
            2'h2: begin
              M_state_d = SEQ2_state;
            end
            2'h3: begin
              M_state_d = SEQ3_state;
            end
          endcase
        end
      end
      WIN_state: begin
        rout = 1'h1;
        bout = 1'h1;
        gout = 1'h1;
        yout = 1'h1;
        out = 3'h1;
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (rst == 1'b1) begin
      M_stage_q <= 1'h0;
      M_counter_q <= 1'h0;
      M_offon_q <= 1'h0;
      M_sequence_q <= 1'h0;
      M_state_q <= 1'h0;
    end else begin
      M_stage_q <= M_stage_d;
      M_counter_q <= M_counter_d;
      M_offon_q <= M_offon_d;
      M_sequence_q <= M_sequence_d;
      M_state_q <= M_state_d;
    end
  end
  
endmodule
