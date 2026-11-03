module inverter(
    //Port interface
    input logic a,
    output logic f

    //Signal types: Logic, wire, reg
);

    //Continuous assignment
    assign f = ~a;

endmodule

module universal_gates(

    input logic [3:0] a,
    input logic [3:0] b,
    
    output logic [3:0] f_and,
    output logic [3:0] f_or,
    output logic [3:0] f_xor,
    output logic [3:0] f_nand,
    output logic [3:0] f_nor
);

    assign f_xor[3] = a[3] ^ b[3];
    assign f_xor[2] = a[2] ^ b[2];
    assign f_xor[1] = a[1] ^ b[1];
    assign f_xor[0] = a[0] ^ b[0];

    assign f_and = a & b;
    assign f_or = a | b;
    assign f_xor = a ^ b;
    assign f_nand = ~(a & b);
    assign f_nor = ~(a | b);

endmodule

module boolean_alg(
    input logic x, y, z
    output logic f
);

    assign f = (~x & y) | (x & z);

endmodule

module mux #(

    parameter WIDTH = 32;

) (

    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input logic s,
    output logic [WIDTH-1:0] f
);

    assign f = s ? b : a;

endmodule

module mux4to1(
    input logic [3:0] d0, d1, d2, d3,
    input logic [1:0] s,
    output logic y
);

    assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);

    //Another way to do combinational logic is the always_comb block
    //Procedural blocks: always_comb, always_ff, always_latch

    always_comb begin
        if (s[1] == 0) begin
            if (s[0] == 0) y = d0; 
            else y = d1;
        end
        else begin
            if (s[0] == 0) y = d2;
            else y = d3;
        end
    end

endmodule

module decoder3to8 (
    input logic [2:0] s,
    output logic [7:0] y
);

always_comb begin

    case (s)
        3'b000: y = 8'b00000001;
        3'b001: y = 8'b00000010;
        3'b010: y = 8'b00000100;
        3'b011: y = 8'b00001000;
        3'b100: y = 8'b00010000;
        3'b101: y = 8'b00100000;
        3'b110: y = 8'b01000000;
        3'b111: y = 8'b10000000;
    endcase
end
endmodule

//assign vs always_comb
/*
    Depends on convenience 

    Similarities: Both will recompute the output whenever any of the inputs 
    (RHS) changes value

    Differences:
        assign:
            describes one signal's equation
            ternary operators
            order is irrelevant; each assign is an independent hW
            Recomputes when any input changes value
        
        always_comb:
            can drive several signals
            if/else case for while
            statements run frop top to bottom 
            if assigning two signals twice, the last assignment takes effect
            recomputes when any signal read in the block changes, EXCEPT signals also
            written in the block 
            potential for errors (inferred latches) if not fully defined 
*/