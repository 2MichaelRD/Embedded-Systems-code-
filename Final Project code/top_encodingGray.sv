module top_encodingGray(
    input  logic       clk,
    input  logic       reset,
    input  logic [1:0] in,
    output logic [4:0] state,
    output logic       out_signal
);

    encodingGray dut(
        .clk(clk),
        .reset(reset),
        .in(in),
        .state(state),
        .out_signal(out_signal)
    );
endmodule
