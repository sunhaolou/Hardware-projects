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
	wire overflow_add;
	wire [31:0] cout_add;
	wire [31:0] res_add;
	CSA_32 csa_func1(res_add, cout_add, overflow_add, data_operandA, data_operandB, 0);
	wire overflow_sub;
	wire [31:0] cout_sub;
	wire [31:0] res_sub;
	CSA_32 csa_func2(res_sub, cout_sub, overflow_sub, data_operandA, b_prime, 1);
	isLessThanNotEqual campareFunc(isNotEqual, isLessThan, data_operandA, b_prime);
	wire [31:0] res_and;
	AND_func and_func(res_and, data_operandA, data_operandB);
	wire [31:0] res_or;
	OR_func or_func(res_or, data_operandA, data_operandB);
	wire [31:0] res_sll;
	SLL sll_func(res_sll, ctrl_shiftamt, data_operandA);
	wire [31:0] res_sra;
	SRA sra_func(res_sra, ctrl_shiftamt, data_operandA);
	assign data_result = ctrl_ALUopcode[2] ? (ctrl_ALUopcode[0] ? res_sra : res_sll) : (ctrl_ALUopcode[1] ? (ctrl_ALUopcode[0] ? res_or : res_and) : (ctrl_ALUopcode[0] ? res_sub : res_add));
	assign overflow = ctrl_ALUopcode[0] ? overflow_sub : overflow_add;
endmodule
