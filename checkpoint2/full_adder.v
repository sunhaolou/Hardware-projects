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
