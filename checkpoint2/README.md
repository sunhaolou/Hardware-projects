TO DO: write an ALU.

Description:
    Add:  I use the 32 bit CSA with the input data_operandA and data_operandB to
          get the result. When ALUopcode is 00000, the result will be assigned
          to data_result.
    Substract: I use the 32 bit CSA with the input data_operandA and b_prime
          which is the not of data_operandB. When ALUopcode is 00000, the
          the result will be assigned to data_result.
    AND:  I use 32 and gates in a for loop to get the result bit by bit of data_operandA
          and data_operandB. When ALUopcode is 00010, the result will be assigned
          to data_result.
    OR:   I use 32 or gates in a for loop to get the result bit by bit of data_operandA
          and data_operandB. When ALUopcode is 00011, the result will be assigned
          to data_result.
    SLL:  I use five groups of for loops to shift left the number five times from
          ctrl_shiftamt[0] to ctrl_shiftamt[4]. In each group, I firstly decide
          how many zeros I need to add to the right of the number. Then I decide
          the others by following the graph. When ALUopcode is 00100, the result
          will be assigned to data_result.
    SRA:  It's the reverse of SLL. I also use five groups of for loops, but start
          from the left. In each groups' first step, I decide to how many significant
          bits I need to add to the left of the number instead of zeros. When
          ALUopcode is 00101, the result will be assigned to data_result.
    isLessThan: I subtract data_operandB from data_operandA (data_operandA - data_operandB).
          Then I use a xor gate of the overflow with the significant bit of the result
          (result[31]) to get the result of isLessThan.
    isNotEqual: I need to find whether the result of (data_operandA - data_operandB)
          is 32 bits zeros. To do this, I use or gate of every two bits, then I
          get a 16 bits number. Then I use or gates again, then I get a 8 bits
          number. Then repeat the step until I get the final 1 bit number. That's
          the result of isNotEqual.
    ALUopcode: I use a nested mux to decide which result I will assign to my final
          data_result.
