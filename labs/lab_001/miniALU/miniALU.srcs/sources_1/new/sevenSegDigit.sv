`timescale 1ns / 1ps

// sevenSegDigit: digit (0-9) -> segment pattern
//      A          displayBits = G F E D C B A  (bit 0 = A)
//    F   B        ACTIVE LOW: 0 = segment on
//      G
//    E   C        Online tables are usually A->G and active high:
//      D          reverse the bits, then flip them.

module sevenSegDigit(
    input logic [3:0] digit,            // from displayEncoder
    output logic [6:0] displayBits
    );

    // case = truth table in code; first exact match wins
    always_comb begin
        case (digit)
            4'd0: displayBits = 7'b1000000;     // A B C D E F
            4'd1: displayBits = 7'b1111001;     // B C
            4'd2: displayBits = 7'b0100100;     // A B D E G
            4'd3: displayBits = 7'b0110000;     // A B C D G
            4'd4: displayBits = 7'b0011001;     // B C F G
            4'd5: displayBits = 7'b0010010;     // A C D F G
            4'd6: displayBits = 7'b0000010;     // A C D E F G
            4'd7: displayBits = 7'b1111000;     // A B C
            4'd8: displayBits = 7'b0000000;     // all segments
            4'd9: displayBits = 7'b0010000;     // A B C D F G
            default: displayBits = 7'b1111111;  // 10-15: blank (also prevents a latch)
        endcase
    end

endmodule
