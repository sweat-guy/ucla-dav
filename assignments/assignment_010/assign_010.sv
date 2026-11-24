module d_latch (
    input logic d,
    input logic en,
    output logic q
);
    always_latch begin
        if (en == 1) begin
            q <= d;
        end
    end
endmodule

// Negative-edge triggered D flip-flop built from two D latches
module d_ff_from_latches (
    input  logic d,
    input  logic clk,
    output logic q
);
    logic master_q;

    // Master latch: transparent when clk is 1 (samples d while clk is high)
    d_latch master (
        .d  (d),
        .en (clk),
        .q  (master_q)
    );

    // Slave latch: transparent when clk is 0 (passes master's held value to q)
    d_latch slave (
        .d  (master_q),
        .en (~clk),
        .q  (q)
    );
endmodule

module d_ff(
    input logic d,
    input logic clk, 
    output logic q
);
    always_ff @(posedge clk) begin
        q <= d;
    end
endmodule

module register8(
    input logic [7:0] d,
    input logic clk,
    output logic [7:0] q
);
    always_ff @(posedge clk) begin
        q <= d;
    end
endmodule 

module sync_rst_register8(
    input logic [7:0] d,
    input logic clk,
    input logic rst,
    output logic [7:0] q
);
    always_ff @(posedge clk) begin
        if (rst) begin
            q <= '0;
        end else begin
            q <= d;
        end
    end
endmodule

module async_rst_neg_register8(
    input logic [7:0] d,
    input logic clk,
    input logic en,
    input logic rst_n,
    output logic [7:0] q
);
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= '0;
        end else if (en) begin
            q <= d;
        end
    end
endmodule