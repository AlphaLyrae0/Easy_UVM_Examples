module dut (
    input       clk, rst_n,
    input       param_a, param_b, param_c,
    input [0:2] sig,
    output logic x,y,z
);

    always_ff @ (posedge clk, negedge rst_n)
        if (!rst_n) begin
            x <= 1'b0;
            y <= 1'b0;
            z <= 1'b0;
        end
        else begin
            x <= param_a ? sig[0] : 1'b0;
            y <= param_b ? sig[1] : 1'b0;
            z <= param_c ? sig[2] : 1'b0;
        end

endmodule
