`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2026 06:57:16 PM
// Design Name: 
// Module Name: miniALU
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


module miniALU(
    input logic [3:0] op1, op2,
    input logic operation, sign,
    output logic [19:0] result
    );

    always_comb begin
        if (operation) begin
            // Arithmetic shifter
            if (sign) begin
                result = op1 >>> op2;
            end
            else begin
                result = op1 <<< op2;
            end
        end
        else begin
            // Addition and subtraction
            if (sign) begin
                result = op1 - op2;     // sign = 1: subtract
            end 
            else begin
                result = op1 + op2;     // sign = 0: add
            end
        end
    end

endmodule
