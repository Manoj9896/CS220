            .data
arrayA:     .space 30
size:       .asciiz "Enter the dimension size(<=15)(if size >15 then 15 will be taken): "
msg1:       .asciiz "\nEnter the floating-point vector A: "
msg2:       .asciiz "\nEnter the floating-point vector B: "
sum:        .asciiz "\nFinal Result is: "

            .text
            .globl main

main:       la		$s1, arrayA		            #
            li		$v0, 4		                # system call #4 - print string
            la		$a0, size
            syscall				                # execute
            li		$v0,   5		            # $v0 = 5
            syscall 
            slti    $t0, $v0, 15
            bne		$t0, $0, LABEL	            # if $t0 != $0 then LABEL
            addi	$v0, $0, 15			        # $v0 = $0 + 15      

LABEL:      ble		$v0, $0, EXIT	            # if $v0 <= $0 then EXIT
            addi	$t0, $0, 0			        # $t0 = $0 + 0
            addi	$t1, $v0, 0			        # $t0 = $v0 + 0

            li		$v0, 4		                # system call #4 - print string
            la		$a0, msg1
            syscall				                # execute            
loop1:      li		$v0,  6		                # $v0 = 6 
            syscall
            swc1	$f0, 0($s1)		            # 
            addi	$s1, $s1, 4			        # $s1 = $s1 + 4
            addi	$t0, $t0, 1			        # $t0 = $t0 + 1
            bne		$t0, $t1, loop1	            # if $t0 != $t1 then loop1

            addi	$t0, $0, 0			        # $t0 = $0 + 0
            addi	$s2, $s1, 0			        # $s2 = $s1 + 0
            li		$v0, 4		                # system call #4 - print string
            la		$a0, msg2
            syscall
      
loop2:      li		$v0,  6		                # $v0 = 6 
            syscall
            swc1	$f0, 0($s1)		            # 
            addi	$s1, $s1, 4			        # $s1 = $s1 + 4
            addi	$t0, $t0, 1			        # $t0 = $t0 + 1
            bne		$t0, $t1, loop2	            # if $t0 != $t1 then loop2

            addi	$t0, $0, 0			        # $t0 = $0 + 0
            mtc1    $0,  $f12
            la		$s1, arrayA		            #      
loop3:      lwc1	$f0, 0($s1)		            # 
            lwc1	$f1, 0($s2)		            # 
            mul.s   $f0, $f0, $f1
            add.s   $f12, $f12, $f0
            addi	$s1, $s1, 4			        # $s1 = $s1 + 4
            addi	$s2, $s2, 4			        # $s2 = $s2 + 4
            addi	$t0, $t0, 1			        # $t0 = $t0 + 1
            bne		$t0, $t1, loop3	            # if $t0 != $t1 then loop    

            li		$v0, 4		                # system call #4 - print string
            la		$a0, sum
            syscall
            li		$v0, 2		                # system call #2 - print float
            syscall				                # execute
EXIT:       jr		$ra					        # jump to $ra   
