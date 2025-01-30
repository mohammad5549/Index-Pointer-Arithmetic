.data
array: .space 8000        # Reserve 4000 bytes (1000 words, 4 bytes each)

.text
.globl main
main:
    # Syscall to get the start time in milliseconds
    li $v0, 30            # 30 is the syscall code for time in milliseconds
    syscall
    move $t0, $a0         # Store start time in $t0
    
#    li $v0, 1
#    syscall

    # Clear the array
    li $t1, 0             # $t1 = index
    li $t2, 0             # $t2 = value to store (0)

clear_loop:
    bge $t1, 2000, end_clear  # if index >= 1000, exit the loop
    sll $t3, $t1, 2           # $t3 = index * 4 (for byte offset)
    add $t4, $t3, $t4         # Calculate array address: array + (index * 4)
    sw $t2, array($t3)        # Set array[index] = 0
    addi $t1, $t1, 1          # index++

    j clear_loop              # Jump back to the beginning of the loop

end_clear:
    # Syscall to get the end time in milliseconds
    li $v0, 30
    syscall
    move $t5, $a0             # Store end time in $t5
    
#    li $v0, 1
#    syscall

    # Calculate runtime
    sub $t6, $t5, $t0         # runtime = end_time - start_time

    # Print runtime
    li $v0, 1                 # 1 is the syscall code to print integer
    move $a0, $t6             # Move runtime to $a0 for printing
    syscall

    # Exit
    li $v0, 10                # 10 is the syscall code to exit
    syscall
