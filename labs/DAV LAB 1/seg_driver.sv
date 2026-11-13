// seg_driver (provided by the leads; comments added, code unchanged)
// The 4 displays share ONE set of segment pins, so this lights one display at a
// time and cycles fast enough (~kHz) that all 4 look on at once.
// Sequential logic: always @(posedge clk) runs on each clock edge; <= updates registers.

module seg_driver(
    input logic [6:0] displayBits [3:0],    // 4 segment patterns
    input clk,                              // 100 MHz
    output logic [3:0] trigger,             // display enables, active low
    output logic [6:0] segBits              // shared segment pins
    );
    logic [1:0] counter;        // current display, 0-3
    logic [15:0] clkdiv;        // clock divider

    // Bit 15 flips every 2^15 cycles: 100 MHz / 2^16 = ~1.5 kHz.
    // Note: = in a declaration only sets a starting value; the usual form is
    // "assign slow_clk = clkdiv[15];". Suspect this if the display is stuck.
    logic slow_clk = clkdiv[15];

    always @(posedge clk) begin
    clkdiv <= clkdiv + 1;               // +1 every 10 ns
    end


    // Each slow clock edge: show one pattern, enable only that display
    always @(posedge slow_clk) begin
        case (counter)
        0: begin
        segBits <= displayBits[0];      // ones
        trigger <= 4'b1110;             // rightmost display on
        end
        1: begin
        segBits <= displayBits[1];      // tens
        trigger <= 4'b1101;
        end
        2: begin
        segBits <= displayBits[2];      // hundreds
        trigger <= 4'b1011;
        end
        3: begin
        segBits <= displayBits[3];      // thousands
        trigger <= 4'b0111;             // leftmost display on
        end
        endcase

        if (counter == 3) begin         // next display, wrap 3 -> 0
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule
