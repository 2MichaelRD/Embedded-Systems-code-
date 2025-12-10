module encodingOneHot(
    input  logic        clk,
    input  logic        reset,
    input  logic [1:0]  in,
    output logic [31:0] state,
    output logic        out_signal
);

    typedef enum logic [31:0] {
        S0  = 32'h00000001, S1  = 32'h00000002, S2  = 32'h00000004, S3  = 32'h00000008,
        S4  = 32'h00000010, S5  = 32'h00000020, S6  = 32'h00000040, S7  = 32'h00000080,
        S8  = 32'h00000100, S9  = 32'h00000200, S10 = 32'h00000400, S11 = 32'h00000800,
        S12 = 32'h00001000, S13 = 32'h00002000, S14 = 32'h00004000, S15 = 32'h00008000,
        S16 = 32'h00010000, S17 = 32'h00020000, S18 = 32'h00040000, S19 = 32'h00080000,
        S20 = 32'h00100000, S21 = 32'h00200000, S22 = 32'h00400000, S23 = 32'h00800000,
        S24 = 32'h01000000, S25 = 32'h02000000, S26 = 32'h04000000, S27 = 32'h08000000,
        S28 = 32'h10000000, S29 = 32'h20000000, S30 = 32'h40000000, S31 = 32'h80000000
    } state_t;

    (* keep = "true" *) state_t current, next;

    // next-state logic
    always_comb begin
        next = current;
        unique case (current)
            S0:  next = (in==2'b00) ? S1 : S0;
            S1:  next = (in==2'b01) ? S2 : S1;
            S2:  next = (in==2'b10) ? S3 : S2;
            S3:  next = (in==2'b11) ? S4 : S3;
            S4:  next = (in==2'b00) ? S5 : S4;
            S5:  next = (in==2'b01) ? S6 : S5;
            S6:  next = (in==2'b10) ? S7 : S6;
            S7:  next = (in==2'b11) ? S8 : S7;
            S8:  next = (in==2'b00) ? S9 : S8;
            S9:  next = (in==2'b01) ? S10 : S9;
            S10: next = (in==2'b10) ? S11 : S10;
            S11: next = (in==2'b11) ? S12 : S11;
            S12: next = (in==2'b00) ? S13 : S12;
            S13: next = (in==2'b01) ? S14 : S13;
            S14: next = (in==2'b10) ? S15 : S14;
            S15: next = (in==2'b11) ? S16 : S15;
            S16: next = (in==2'b00) ? S17 : S16;
            S17: next = (in==2'b01) ? S18 : S17;
            S18: next = (in==2'b10) ? S19 : S18;
            S19: next = (in==2'b11) ? S20 : S19;
            S20: next = (in==2'b00) ? S21 : S20;
            S21: next = (in==2'b01) ? S22 : S21;
            S22: next = (in==2'b10) ? S23 : S22;
            S23: next = (in==2'b11) ? S24 : S23;
            S24: next = (in==2'b00) ? S25 : S24;
            S25: next = (in==2'b01) ? S26 : S25;
            S26: next = (in==2'b10) ? S27 : S26;
            S27: next = (in==2'b11) ? S28 : S27;
            S28: next = (in==2'b00) ? S29 : S28;
            S29: next = (in==2'b01) ? S30 : S29;
            S30: next = (in==2'b10) ? S31 : S30;
            S31: next = (in==2'b11) ? S0 : S31;
        endcase
    end

    always_ff @(posedge clk or posedge reset)
        if (reset) current <= S0;
        else       current <= next;

    assign state = current;

    assign out_signal = ^current;  // XOR reduction

endmodule
