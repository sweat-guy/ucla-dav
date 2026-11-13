`timescale 1ns / 1ps

// displayEncoder: splits the 20-bit result into 4 decimal digits (4 bits each, 0-9).
// Slicing result[3:0], [7:4]... would give HEX digits (25 -> "19"), so use
// / (drops remainder) and % (remainder) instead: e.g. 2345 -> 5, 4, 3, 2.
// Values stay binary; / and % by 10 is the base-10 conversion.
// Only 4 displays, so results over 9999 show just the lowest 4 digits.

module displayEncoder(
    input logic [19:0] result,                  // from miniALU
    output logic [3:0] numberBits [0:3]         // 4 entries, 4 bits each
    );

    assign numberBits[0] = result % 10;             // ones
    assign numberBits[1] = (result / 10) % 10;      // tens
    assign numberBits[2] = (result / 100) % 10;     // hundreds
    assign numberBits[3] = (result / 1000) % 10;    // thousands

endmodule
