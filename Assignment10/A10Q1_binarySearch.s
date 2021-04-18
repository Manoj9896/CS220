    
# array index starts from 0 i.e. A[0....n-1]    
    
              .data
nums:         .space 30
msg1:         .asciiz "Enter the size of array (<=12) : "
msg2:         .asciiz "Enter the array elements : "
msg3:         .asciiz "Enter the number/element to be searched : "
msg4:         .asciiz "Array size must be greater than 0."
msg5:         .asciiz "Array size should not be greater than 12 (problem constraint)."
Not_found:    .asciiz "Element was not found"
found:        .asciiz "Found element at index "

              .text 
              .globl main

binarySearch: ble		$a1, $a2, case1	       # if $a1 <= $a2 then case1   *if low > high return -1*        				 
              addi	       $v0, $0, -1			# $v0 = $0 + -1       if not found return -1       
              jr		$ra				# jump to $ra
    
    case1:    addu		$t0, $a2, $a1		       # $t0 = $a2 + $a1
              srl           $t0, $t0, 1
              addi	       $t1, $0, 4			# $t1 = $0 + 4              
              mult	       $t0, $t1			# $t0 * $t1 = Hi and Lo registers
              mflo	       $t1				# copy Lo to $t1              
              addu		$t1, $a0, $t1		       # $t1 = $a0 + $t0              
              lw		$t1, 0($t1)		       # getting the value at index $t0, $t1 contains the address of that position
              bne		$t1, $a3, case2	       # if $t1 != $a3 then case2 else if found return index 
              addi	       $v0, $t0, 0			# $v0 = $t0 + 0  $t0 contains the index
              jr		$ra				# jump to $ra

    case2:    addi	       $sp, $sp, -4			# $sp = $sp + -4, case 2 if A[mid] < K then do low = mid + 1
              sw		$ra, 0($sp)		       #               
              blt		$a3, $t1, case3	       # if $a3 < $t1 then case3
              addi	       $a1, $t0, 1			# $a1 = $t0 + 1, low = mid + 1
              jal		binarySearch			# jump to binarySearch and save position to $ra
              lw		$ra, 0($sp)		       # 
              addi	       $sp, $sp, 4			# $sp = $sp + 4
              jr		$ra				# jump to $ra
              
    case3:    addi	       $a2, $t0, -1			# $a2 = $t0 + -1 case 3 if A[mid] > k then do high = mid-1
              jal		binarySearch			# jump to binarySearch and save position to $ra
              lw		$ra, 0($sp)		       # 
              addi	       $sp, $sp, 4			# $sp = $sp + 4
              jr		$ra				# jump to $ra           
                            
              


main:  li		$v0, 4		                     # system call #4 - print string
       la		$a0, msg1
       syscall				              # execute
       la		$v0, 5		                     # 
       syscall
       addi	       $t1, $v0, 0			       # $t1 = $v0 + 0
       ble		$t1, $0, Exit1	              # if $t1 <= $0 then Exit1
       addi	       $t0, $0, 12			       # $t0 = $0 + 12
       bgt		$t1, $t0, Exit2	              # if $t1 > $t0 then Exit2
       la		$s1, nums		              #
       li		$v0, 4		                     # system call #4 - print string
       la		$a0, msg2
       syscall				              # execute

       addi	       $t0, $0, 0			       # $t0 = $0 + 0
loop:  la		$v0, 5		                     # 
       syscall
       sw		$v0, 0($s1)		              # 
       addi	       $t0, $t0, 1			       # $t0 = $t0 + 1
       addi	       $s1, $s1, 4			       # $s1 = $s1 + 4
       bne		$t0, $t1, loop	              # if $t0 != $t1 then loop
       addi	       $sp, $sp, -4			       # $sp = $sp + -4
       sw		$ra, 0($sp)		              # 
       li		$v0, 4		                     # system call #4 - print string
       la		$a0, msg3
       syscall				              # execute
       la		$v0, 5		                     # 
       syscall
       addi	       $a3, $v0, 0			       # $a3 = $v0 + 0
       addi	       $a2, $t1, -1			       # $a2 = $t1 + -1
       addi	       $a1, $0, 0			       # $a1 = $0 + 0
       la	       $a0, nums		              #       
       jal		binarySearch				# jump to binarySearch and save position to $ra         
       lw		$ra, 0($sp)		              # 
       addi	       $sp, $sp, 4			       # $sp = $sp + 4

       addi	       $t0, $v0, 0			              # $t0 = $v0 + 0

       blt		$t0, $0, jump	                     # if $a0 < $0 then jump 
       li		$v0, 4		                     # system call #4 - print string
       la		$a0, found
       syscall				              # execute   
       addi	       $a0, $t0, 0			              # $a0 = $t0 + 0   
       li		$v0, 1		                     # system call #1 - print int
       syscall				              # execute
       j		Exit				       # jump to Exit
jump:  li		$v0, 4		                     # system call #4 - print string
       la		$a0, Not_found
       syscall				              # execute
       j		Exit				       # jump to Exit
       
       
Exit1: li		$v0, 4		                     # system call #4 - print string
       la		$a0, msg4
       syscall				              # execute
       j		Exit				       # jump to Exit

Exit2: li		$v0, 4		                     # system call #4 - print string
       la		$a0, msg5
       syscall				              # execute
       
Exit: jr		$ra					# jump to $ra
