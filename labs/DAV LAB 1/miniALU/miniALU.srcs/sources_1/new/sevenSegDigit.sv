`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 09:51:01 AM
// Design Name: 
// Module Name: sevenSegDigit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sevenSegDigit(
    input logic [3:0] digit,
    output logic [6:0] displayBits
    );

    always_comb begin
        case (digit)
            // bits are GFEDCBA (bit 0 = A), active low: 0 = segment on
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
            default: displayBits = 7'b1111111;  // 10-15: blank
        endcase
    end 

endmodule
