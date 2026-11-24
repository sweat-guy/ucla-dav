`timescale 1ns / 1ps

// calculator_top: wires everything together; its ports are the board pins.
// switches -> miniALU -> displayEncoder -> 4x sevenSegDigit -> seg_driver -> displays
// .port(signal) = connect the module's port to this module's signal.

module calculator_top(
    input logic [3:0] op1, op2,         // switches 15-12 and 9-6
    input logic operation, sign,        // switches 11 and 10
    input clk,                          // 100 MHz board clock
    output logic [6:0] segBits,         // segments A-G, shared by all 4 displays
    output logic [3:0] trigger          // which display is on (active low)
    );

    // Wires between modules (array ranges match the ports they connect to)
    logic [19:0] result;                // miniALU -> displayEncoder
    logic [3:0]  numberBits [0:3];      // displayEncoder -> sevenSegDigits
    logic [6:0]  displayBits [3:0];     // sevenSegDigits -> seg_driver

    miniALU alu(.op1(op1), .op2(op2), .operation(operation), .sign(sign), .result(result));

    displayEncoder enc(.result(result), .numberBits(numberBits));   // index 0 = ones

    // One instance (copy of the hardware) per display
    sevenSegDigit digit0(.digit(numberBits[0]), .displayBits(displayBits[0]));
    sevenSegDigit digit1(.digit(numberBits[1]), .displayBits(displayBits[1]));
    sevenSegDigit digit2(.digit(numberBits[2]), .displayBits(displayBits[2]));
    sevenSegDigit digit3(.digit(numberBits[3]), .displayBits(displayBits[3]));

    // Provided: cycles through the 4 displays on the shared segment pins
    seg_driver DUT1(.displayBits(displayBits), .clk(clk), .trigger(trigger), .segBits(segBits));

endmodule
