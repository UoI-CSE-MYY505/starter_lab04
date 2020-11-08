        .data
n1:
        .word  1
n15:
        .word  15
n_m5:
        .word  -5
       
        .globl main

        .text
main:   
        la   $t0, n1
        lw   $t1, 0($t0)   # 1
        lw   $t2, 4($t0)   # 15 = 32'b000...0_1111
        lw   $t3, 8($t0)   # -5 = 32'b111...1_1011
        beq  $t1, $zero, notTaken
        j    skip
notTaken:  # should never get here!
        sw   $t2, 0($t0)    # Detect it by storing 15 in n1
        add  $t0, $t4, $t4  # should generate X's in simulation, break $t0!
taken:
        sw   $t3, 0($t0)    # Store -5 in n1
        addi $t8, $t2, 3    # should be 18
        add  $s0, $t3, $zero # Should be -5
        j    end
skip:
	and  $t4, $t1, $t3 #  t4 = 32'b000...0_0001 
        or   $t5, $t3, $t2 #  t5 = 32'b111...1_1111 = -1
        slt  $t6, $t4, $t5 # Should be 0
        beq  $t6, $zero, taken  # backwards branch works?
        j    notTaken

end:
        sub  $t7, $t2, $t1 # Should be 14

