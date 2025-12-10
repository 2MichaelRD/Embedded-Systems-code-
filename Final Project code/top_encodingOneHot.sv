module top_encodingOneHot(
    input  logic       clk,
    input  logic       reset,
    input  logic [1:0] in,
    output logic [31:0] state,
    output logic       out_signal
);

    encodingOneHot dut(
        .clk(clk),
        .reset(reset),
        .in(in),
        .state(state),
        .out_signal(out_signal)
    );
endmodule
