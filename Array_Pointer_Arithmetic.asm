.data
array: .space 48000          # Reserve 4000 bytes (1000 words, 4 bytes each)

.text
.globl main
main:
    # Syscall to get the start time in milliseconds
    li $v0, 30               # 30 is the syscall code for time in milliseconds
    syscall
    move $t0, $a0            # Store start time in $t0

    # Initialize pointers
    la $t1, array            # $t1 points to the start of the array
    li $t2, 0                # $t2 = value to store (0)
    la $t3, array + 48000     # $t3 points to the end of the array (array + 4000 bytes)

clear_loop:
    bge $t1, $t3, end_clear  # if pointer >= end of array, exit the loop
    sw $t2, 0($t1)           # Set *($t1) = 0
    addi $t1, $t1, 4         # Move pointer to the next word (4 bytes)

    j clear_loop             # Jump back to the beginning of the loop

end_clear:
    # Syscall to get the end time in milliseconds
    li $v0, 30
    syscall
    move $t5, $a0            # Store end time in $t5

    # Calculate runtime
    sub $t6, $t5, $t0        # runtime = end_time - start_time

    # Print runtime
    li $v0, 1                # 1 is the syscall code to print integer
    move $a0, $t6            # Move runtime to $a0 for printing
    syscall

    # Exit
    li $v0, 10               # 10 is the syscall code to exit
    syscall
