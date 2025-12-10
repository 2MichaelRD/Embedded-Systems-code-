module encodingBinary(
    input  logic        clk,
    input  logic        reset,       
    input  logic [1:0]  in,          

    // full 5-bit state output 
    output logic [4:0]  state,

    output logic        out_signal
);

    
    typedef enum logic [4:0] {
        S0  = 5'd0,
        S1  = 5'd1,
        S2  = 5'd2,
        S3  = 5'd3,
        S4  = 5'd4,
        S5  = 5'd5,
        S6  = 5'd6,
        S7  = 5'd7,
        S8  = 5'd8,
        S9  = 5'd9,
        S10 = 5'd10,
        S11 = 5'd11,
        S12 = 5'd12,
        S13 = 5'd13,
        S14 = 5'd14,
        S15 = 5'd15,
        S16 = 5'd16,
        S17 = 5'd17,
        S18 = 5'd18,
        S19 = 5'd19,
        S20 = 5'd20,
        S21 = 5'd21,
        S22 = 5'd22,
        S23 = 5'd23,
        S24 = 5'd24,
        S25 = 5'd25,
        S26 = 5'd26,
        S27 = 5'd27,
        S28 = 5'd28,
        S29 = 5'd29,
        S30 = 5'd30,
        S31 = 5'd31
    } state_t;

    // ensure Vivado cannot optimize away the FSM
    (* keep = "true" *) state_t current;
    (* keep = "true" *) state_t next;

    // Next-state logic  
    // advance only when certain in values occur
    always_comb begin
        next = current;

        unique case (current)
            S0:  next = (in == 2'b00) ? S1  : S0;
            S1:  next = (in == 2'b01) ? S2  : S1;
            S2:  next = (in == 2'b10) ? S3  : S2;
            S3:  next = (in == 2'b11) ? S4  : S3;
            S4:  next = (in == 2'b00) ? S5  : S4;
            S5:  next = (in == 2'b01) ? S6  : S5;
            S6:  next = (in == 2'b10) ? S7  : S6;
            S7:  next = (in == 2'b11) ? S8  : S7;
            S8:  next = (in == 2'b00) ? S9  : S8;
            S9:  next = (in == 2'b01) ? S10 : S9;
            S10: next = (in == 2'b10) ? S11 : S10;
            S11: next = (in == 2'b11) ? S12 : S11;
            S12: next = (in == 2'b00) ? S13 : S12;
            S13: next = (in == 2'b01) ? S14 : S13;
            S14: next = (in == 2'b10) ? S15 : S14;
            S15: next = (in == 2'b11) ? S16 : S15;
            S16: next = (in == 2'b00) ? S17 : S16;
            S17: next = (in == 2'b01) ? S18 : S17;
            S18: next = (in == 2'b10) ? S19 : S18;
            S19: next = (in == 2'b11) ? S20 : S19;
            S20: next = (in == 2'b00) ? S21 : S20;
            S21: next = (in == 2'b01) ? S22 : S21;
            S22: next = (in == 2'b10) ? S23 : S22;
            S23: next = (in == 2'b11) ? S24 : S23;
            S24: next = (in == 2'b00) ? S25 : S24;
            S25: next = (in == 2'b01) ? S26 : S25;
            S26: next = (in == 2'b10) ? S27 : S26;
            S27: next = (in == 2'b11) ? S28 : S27;
            S28: next = (in == 2'b00) ? S29 : S28;
            S29: next = (in == 2'b01) ? S30 : S29;
            S30: next = (in == 2'b10) ? S31 : S30;
            S31: next = (in == 2'b11) ? S0  : S31;
            default: next = S0;
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current <= S0;
        else
            current <= next;
    end

    assign state = current;

    // prevent optimization  
    assign out_signal = current[0] ^ current[1] ^ current[2];

endmodule
