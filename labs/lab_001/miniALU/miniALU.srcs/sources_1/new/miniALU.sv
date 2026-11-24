`timescale 1ns / 1ps    // simulation time unit / precision

// miniALU: the calculator's ALU
//   op=0 sign=0: op1 + op2     op=1 sign=0: op1 << op2 (x 2^op2)
//   op=0 sign=1: op1 - op2     op=1 sign=1: op1 >> op2 (/ 2^op2)
// Hardware: all 4 operations compute in parallel; the if/else becomes muxes
// (two on sign, one on operation) that pick one.
// result is 20 bits because the max is 15 << 15 = 491,520 (19 bits). Inputs are
// zero-extended to 20 bits before the math, so nothing is cut off.
// Vivado widths: add 5 (max 30), right shift 4 (only shrinks), left shift 20,
// subtract 20 (negatives wrap to 20-bit two's complement, e.g. 3-5 = 1111...1110).

module miniALU(
    input logic [3:0] op1, op2,         // unsigned, 0-15
    input logic operation, sign,        // operation: 0 = add/sub, 1 = shift
                                        // sign: 0 = add / left, 1 = subtract / right
    output logic [19:0] result
    );

    // always_comb: combinational, re-runs when any input changes. Use = inside.
    // Every path must assign result, or Vivado infers a latch.
    always_comb begin
        if (operation) begin                // operation = 1: shift
            if (sign) begin
                result = op1 >>> op2;       // right shift. >>> only copies the sign bit for
                                            // signed signals; op1 is unsigned, so same as >>
            end
            else begin
                result = op1 <<< op2;       // left shift (same as <<), e.g. 7 << 5 = 224
            end
        end
        else begin                          // operation = 0: add/sub
            if (sign) begin
                result = op1 - op2;         // subtract
            end
            else begin
                result = op1 + op2;         // add
            end
        end
    end

endmodule
