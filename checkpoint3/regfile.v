module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	wire [31:0] write_enable_reg;
	wire [31:0] trans_num;
	five_bit_decoder decoder_1(trans_num, ctrl_writeReg);
	wire [1023:0] q;
	assign write_enable_reg[0] = 1'b0;
	genvar m;
	generate
		for (m = 1; m < 32; m = m + 1) begin : label_0
			assign write_enable_reg[m] = ctrl_writeEnable & trans_num[m];
		end
	endgenerate
	genvar i;
	generate
	for (i = 0; i < 32; i = i + 1) begin : label
		register register_1(q[31+i*32:i*32], data_writeReg, clock, write_enable_reg[i], ctrl_reset);
	end
	endgenerate
	wire [31:0] read_enable_regA;
	wire [31:0] read_enable_regB;
	five_bit_decoder decoder_2(read_enable_regA, ctrl_readRegA);
	five_bit_decoder decoder_3(read_enable_regB, ctrl_readRegB);
	wire [1023:0] read_regA_input;
	wire [1023:0] read_regB_input;
	genvar j;
	generate
		for (j = 0; j < 32; j = j + 1) begin : label_1
			assign read_regA_input[31+j*32:j*32] = read_enable_regA[j] ? q[31+j*32:j*32] : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
			assign read_regB_input[31+j*32:j*32] = read_enable_regB[j] ? q[31+j*32:j*32] : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		end
	endgenerate
	genvar k;
	generate
		for (k = 0; k < 32; k = k + 1) begin : label_2
			assign data_readRegA = read_regA_input[31+k*32:k*32];
			assign data_readRegB = read_regB_input[31+k*32:k*32];
		end
	endgenerate
endmodule
