            .data
msg1:       .asciiz "Enter the value of n: "
msg2:       .asciiz "\nThe first n fibonacci numbers are: "

            .text
            .globl main

Fibonacci:  slti        $t5, $a0, 2
            beq		$t5, $0, Label	                        # if $t5 == $0 then Label
            addi	$v0, $0, 1			        # $v0 = $0 + 1
            jr		$ra					# jump to $ra
Label:      addi	$sp, $sp, -12			        # $sp = $sp + -12
            sw		$ra, 8($sp)		                # 
            sw		$a0, 4($sp)		                #             
            addi	$a0, $a0, -1			        # $a0 = $a0 + -1
            jal		Fibonacci				# jump to Fibonacci and save position to $ra
            sw		$v0, 0($sp)		                # 
            lw		$a0, 4($sp)		                #             
            addi	$a0, $a0, -2			        # $a0 = $a0 + -2
            jal		Fibonacci			        # jump to Fibonacciand save position to $ra
            lw		$t4, 0($sp)		                # 
            lw		$ra, 8($sp)		                #            
            addu	$v0, $v0, $t4		                # $v0 = $v0 + $t4
            addi	$sp, $sp, 12			        # $sp = $sp + 12            
            jr		$ra					# jump to $ra          

main:       li		$v0, 4		                        # system call #4 - print string
            la		$a0, msg1
            syscall				                # execute
            li		$v0,  5		                        # $v0 = 5 
            syscall
            addi	$t0, $0, 0			        # $t0 = $0 + 0
            addi	$t1, $v0, 0			        # $t1 = $v0 + 0
            slti        $t2, $t1, 1
            addi        $sp, $sp, -4
            sw		$ra, 0($sp)		                # 
            bne		$t2, $0, EXIT	                        # if $t2 != $0 then EXIT
            li		$v0, 4		                        # system call #4 - print string
            la		$a0, msg2
            syscall				                # execute
loop_begin: addi	$a0, $t0, 0			        # $a0 = $t0 + 0
            jal		Fibonacci				# jump to fibonacci and save position to $ra
            addi	$t0, $t0, 1			        # $t0 = $t0 + 1
            addi	$a0, $v0, 0			        # $a0 = $v0 + 0        
            li		$v0,  1	                                # $v0 = 1
            syscall
            sltu        $v0, $t0, $t1
            beq	        $v0, $0, loop_END                       # if $v0 == $0 then END        
            addi	$a0, $0, 44			        # $a0 = $0 + 44
            li	        $v0,  11		                # $v0 = 11 
            syscall
loop_END:   bne	        $v0, $0, loop_begin                     # if $v0 != $0 then loop 
EXIT:       lw		$ra, 0($sp)		                # 
            addi	$sp, $sp, 4			        # $sp = $sp + 4
            jr		$ra					# jump to $ra     
