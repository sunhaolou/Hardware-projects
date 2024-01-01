module isLessThanNotEqual(isNotEqual, isLessThan, a, b_prime);
	input [31:0] a;
	input [31:0] b_prime;
	output isNotEqual;
	output isLessThan;
	wire [31:0] temp_sum;
	wire [31:0] temp_cout;
	wire temp_overflow;
	CSA_32 csa_func(temp_sum, temp_cout, temp_overflow, a, b_prime, 1);
	xor xor_func(isLessThan, temp_overflow, temp_sum[31]);
	wire [15:0] comp_res_1;
	genvar i;
	generate
		for (i = 0; i < 16; i = i + 1) begin : label_1
			or or_func_11(comp_res_1[i], temp_sum[2*i], temp_sum[2*i + 1]);
		end
	endgenerate
	wire [7:0] comp_res_2;
	genvar j;
	generate
		for (j = 0; j < 8; j = j + 1) begin : label_2
			or or_func_21(comp_res_2[j], comp_res_1[2*j], comp_res_1[2*j + 1]);
		end
	endgenerate
	wire [3:0] comp_res_3;
	genvar k;
	generate
		for (k = 0; k < 4; k = k + 1) begin : label_3
			or or_func_31(comp_res_3[k], comp_res_2[2*k], comp_res_2[2*k + 1]);
		end
	endgenerate
	wire [1:0] comp_res_4;
	genvar l;
	generate
		for (l = 0; l < 2; l = l + 1) begin : label_4
			or or_func_41(comp_res_4[l], comp_res_3[2*l], comp_res_3[2*l + 1]);
		end
	endgenerate
	or or_func_res(isNotEqual, comp_res_4[0], comp_res_4[1]);
endmodule
