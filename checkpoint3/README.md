### TODO
write a register file.
#### Description
- five_bit_decoder.v: I used "bitwise and" to "and" all the five digits to
  change the 5 bits code to a 32 bits code, where each index reference to
  the register number.
- register.v: I used 32 DFF to get a register which has a 32 bits "d" input,
  and a 32 bits "q" output.
- regfile.v: In the write part, I firstly assign 0 to the index 0 value of
  the 32 bits enable code so that the output value of register 0 is always
  all zeros. Then I used my five_bit_decoder to change the code to 32 bits
  code and "and" with the write_enable bit to decide which register I need
  to write. All the 32 bits register output will be write in a 32*32 long wire.
  In the read part, I firstly used the tristate to decide which q should be
  in as real number and others will be the high impedence. Since I have at
  least one high impedence as input, I can repeatedly assign to the result,
  and get the final result.
