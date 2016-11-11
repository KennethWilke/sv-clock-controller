`timescale 1ns / 1ps

module clock_controller (
  input reset,
  input clk_in,
  output logic clk_out
);

  parameter CLOCKS_UP = 2;
  parameter CLOCKS_DOWN = 2;
  parameter REGISTER_WIDTH = 8;
  logic [REGISTER_WIDTH-1:0] count;

  always_ff @ (posedge clk_in) begin
    if (reset) begin
      // Reset state
      count <= 1;
      clk_out <= 0;
    end else if (clk_out) begin
      // Clock up state
      if (count == CLOCKS_UP) begin
        // Switch state
        clk_out <= 0;
        count <= 1;
      end else begin
        // Wait state
        count <= count + 1;
      end
    end else begin
      // Clock down state
      if (count == CLOCKS_DOWN) begin
        // Switch state
        clk_out <= 1;
        count <= 1;
      end else begin
        // Wait state
        count <= count + 1;
      end
    end
  end

endmodule
