module AND_func(out, a, b);
	input [31:0] a;
	input [31:0] b;
	output [31:0] out;
	genvar i;
	generate
		for(i = 0; i < 32; i = i + 1) begin : label
			and and_func(out[i], a[i], b[i]);
		end
	endgenerate
endmodule
