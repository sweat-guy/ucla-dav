`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 03:56:40 PM
// Design Name: 
// Module Name: calculator_top
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


module calculator_top(
    input logic [3:0] op1, op2,         // switches 15-12 and 9-6
    input logic operation, sign,        // switches 11 and 10
    input clk,                          // board clock
    output logic [6:0] segBits,         // segments A-G
    output logic [3:0] trigger          // which display is on
    );

    // Internal wires between modules
    logic [19:0] result;                // miniALU -> displayEncoder
    logic [3:0]  numberBits [0:3];      // displayEncoder -> sevenSegDigits
    logic [6:0]  displayBits [3:0];     // sevenSegDigits -> seg_driver

    // Compute the result from the switches
    miniALU alu(.op1(op1), .op2(op2), .operation(operation), .sign(sign), .result(result));

    // Split the result into 4 decimal digits (index 0 = ones)
    displayEncoder enc(.result(result), .numberBits(numberBits));

    // Turn each digit into a segment pattern
    sevenSegDigit digit0(.digit(numberBits[0]), .displayBits(displayBits[0]));
    sevenSegDigit digit1(.digit(numberBits[1]), .displayBits(displayBits[1]));
    sevenSegDigit digit2(.digit(numberBits[2]), .displayBits(displayBits[2]));
    sevenSegDigit digit3(.digit(numberBits[3]), .displayBits(displayBits[3]));

    // Cycle through the 4 displays (provided module)
    seg_driver DUT1(.displayBits(displayBits), .clk(clk), .trigger(trigger), .segBits(segBits));

endmodule
