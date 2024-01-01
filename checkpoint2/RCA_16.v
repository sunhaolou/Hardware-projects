module RCA_16(sum, cout, a, b, cin);
	input [15:0] a;
	input [15:0] b;
	input cin;
	output [15:0] sum;
	output [15:0] cout;
	wire [16:0] temp_c;
	assign temp_c[0] = cin;
	genvar i;
	generate
		for (i = 0; i < 16; i = i + 1) begin : label
			full_adder func1(sum[i], temp_c[i+1], a[i], b[i], temp_c[i]);		
		end
	endgenerate
	assign cout = temp_c[16:1];
endmodule
