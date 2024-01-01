module SLL(out, shiftamt, a);
	input [31:0] a;
	input [4:0] shiftamt;
	output [31:0] out;
	wire [31:0] out_1;
	wire [31:0] out_2;
	wire [31:0] out_3;
	wire [31:0] out_4;
	genvar i;
	generate
		for(i = 0; i < 1; i = i + 1) begin : label_1
			assign out_1[i] = shiftamt[0] ? 1'b0 : a[i];
		end
		for(i = 1; i < 32; i = i + 1) begin : label_2
			assign out_1[i] = shiftamt[0] ? a[i - 1] : a[i];
		end
	endgenerate
	genvar j;
	generate
		for(j = 0; j < 2; j = j + 1) begin : label_3
			assign out_2[j] = shiftamt[1] ? 1'b0: out_1[j];
		end
		for(j = 2; j < 32; j = j + 1) begin : label_4
			assign out_2[j] = shiftamt[1] ? out_1[j - 2] : out_1[j];
		end
	endgenerate
	genvar k;
	generate
		for(k = 0; k < 4; k = k + 1) begin : label_5
			assign out_3[k] = shiftamt[2] ?  1'b0: out_2[k];
		end
		for(k = 4; k < 32; k = k + 1) begin : label_6
			assign out_3[k] = shiftamt[2] ? out_2[k - 4] : out_2[k];
		end
	endgenerate
	genvar l;
	generate
		for(l = 0; l < 8; l = l + 1) begin : label_7
			assign out_4[l] = shiftamt[3] ?  1'b0: out_3[l];
		end
		for(l = 8; l < 32; l = l + 1) begin : label_8
			assign out_4[l] = shiftamt[3] ? out_3[l - 8] : out_3[l];
		end
	endgenerate
	genvar m;
	generate
		for(m = 0; m < 16; m = m + 1) begin : label_9
			assign out[m] = shiftamt[4] ?  1'b0: out_4[m];
		end
		for(m = 16; m < 32; m = m + 1) begin : label_10
			assign out[m] = shiftamt[4] ? out_4[m - 16] : out_4[m];
		end
	endgenerate
endmodule
