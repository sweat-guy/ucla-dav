module fsm_3heads(

    input logic heads, clk,

    output logic three_out
);

typedef enum state_t {ZERO, ONE, TWO, THREE} state, next_state;

always_comb begin
    case (state)

        ZERO: if(~heads) begin 

                next_state = ZERO;

            end else begin

                next_state = ONE;

            end
        ONE: if(~heads) begin 

                next_state = ZERO;

            end else begin

                next_state = TWO;
            
            end
        TWO: if(~heads) begin 

                next_state = ZERO;

            end else begin

                next_state = THREE;
            
            end
        THREE: next_state = ZERO;
    endcase
end

always_ff @(posedge clk) begin
    state <= next_state;
end

always_comb begin //output
    case state

        ZERO: three_out = 0;
        ONE: three_out = 0;
        TWO: three_out = 0;
        THREE: three_out = 1;
    endcase
end

endmodule