module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;

   // YOUR CODE HERE //
	wire [31:0] b_prime;
	genvar i;
	generate
		for (i = 0; i < 32; i = i + 1) begin : label
			not not_func1(b_prime[i], data_operandB[i]);
		end
	endgenerate
	wire [31:0] input_B;
	assign input_B = ctrl_ALUopcode[0] ? b_prime : data_operandB;
	wire [31:0] cout;
	CSA_32 csa_func(data_result, cout, overflow, data_operandA, input_B, ctrl_ALUopcode[0]);
endmodule

module full_adder(sum, cout, a, b, cin);
	input a, b, cin;
	output sum, cout;
	wire temp1, temp2, temp3;
	xor func1(temp1, a, b);
	xor func2(sum, temp1, cin);
	and func3(temp2, temp1,cin);
	and func4(temp3, a, b);
	or func5(cout, temp2,temp3);
endmodule

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

module CSA_32(sum, cout, overflow, a, b, cin);
	input [31:0] a;
	input [31:0] b;
	input cin;
	output [31:0] sum;
	output [31:0] cout;
	output overflow;
	wire [15:0] cout_right;
	RCA_16 rca_func1(sum[15:0], cout_right, a[15:0], b[15:0], cin);
	assign cout[15:0] = cout_right;
	wire [15:0] one_output;
	wire [15:0] zero_output;
	wire [15:0] cout_1;
	wire [15:0] cout_0;
	RCA_16 rca_func2(one_output, cout_1, a[31:16], b[31:16], 1);
	RCA_16 rca_func3(zero_output, cout_0, a[31:16], b[31:16], 0);
	assign sum[31:16] = cout_right[15] ? one_output : zero_output;
	assign cout[31:16] = cout_right ? cout_1 : cout_0;
	xor xor_func(overflow, cout[31], cout[30]);
endmodule

	