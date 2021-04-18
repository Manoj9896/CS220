            .data
size:       .asciiz "Enter the dimension size: "
msg1:       .asciiz "Enter the floating-point vector A: "
Result:     .asciiz "Final Result is: "

            .text
            .globl main

main:       la		$a0, size
            syscall				                # execute
            li		$v0,   5		            # $v0 = 5
            syscall       

            ble		$v0, $0, EXIT	            # if $v0 <= $0 then EXIT
            addi	$t0, $0, 0			        # $t0 = $0 + 0
            addi	$t1, $v0, 0			        # $t0 = $v0 + 0
            addi	$t3, $0, 0			        # $t03 = $0 + 0
            mtc1    $0,  $f12

            li		$v0, 4		                # system call #4 - print string
            la		$a0, msg1
            syscall				                # execute            
loop1:      li		$v0,  6		                # $v0 = 6 
            syscall
            beq		$t3, $0, even	            # if $t3 == $0 then even
            sub.s   $f12, $f12,$f0
            addi	$t3, $0, 0			        # $t03 = $0 + 0
            j		odd				            # jump to odd      

even:       add.s   $f12,$f12,$f0
            addi	$t3, $0, 1			        # $t03 = $0 + 1          
            
odd:        addi	$t0, $t0, 1			        # $t0 = $t0 + 1
            bne		$t0, $t1, loop1	            # if $t0 != $t1 then loop1

            li		$v0, 4		                # system call #4 - print string
            la		$a0, Result
            syscall
            li		$v0, 2		                # system call #2 - print float
            syscall				                # execute
EXIT:       jr		$ra					        # jump to $ra   
