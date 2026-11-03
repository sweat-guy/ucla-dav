module project_1_top(input sw1, input sw2, output led);

assign led = sw1 & sw2;

endmodule