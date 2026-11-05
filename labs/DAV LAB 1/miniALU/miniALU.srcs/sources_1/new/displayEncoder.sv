`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 09:51:01 AM
// Design Name: 
// Module Name: displayEncoder
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


module displayEncoder(
    input logic [19:0] result,
    output logic [3:0] numberBits [0:3]
    );

    assign numberBits[0] = result % 10;
    assign numberBits[1] = (result / 10) % 10;
    assign numberBits[2] = (result / 100) % 10;
    assign numberBits[3] = (result / 1000) % 10;

endmodule
