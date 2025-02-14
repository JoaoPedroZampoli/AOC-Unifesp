.data
    base_address: .word 0x10008000  # Base address for Bitmap Display

.text
main:
    # Load base address
    lw $t0, base_address        
    
    # Define colors
    li $t1, 0x87CEEB    # Sky blue
    li $t2, 0x8B4513    # Brown (for walls)
    li $t3, 0xFF0000    # Red (for roof)
    li $t4, 0x4A2604    # Dark brown (for door)
    li $t9, 0xADD8E6    # Light blue (for window)
    
    # First, fill background with sky blue
    move $t7, $t0       # Keep original base address
    li $t5, 65536       # Total pixels
bg_loop:
    sw $t1, 0($t7)      # Write sky blue color
    addiu $t7, $t7, 4   # Next pixel
    subi $t5, $t5, 1    # Decrement counter
    bnez $t5, bg_loop   # Continue until done
    
    # Draw house walls (brown rectangle)
    move $t7, $t0       # Reset to base address
    addi $t7, $t7, 49152    # Move down 48 rows
    addi $t7, $t7, 288      # Center horizontally
    li $t5, 60          # Height of walls
wall_loop_y:
    li $t6, 80          # Width of walls
    move $t8, $t7       # Save start of current row
wall_loop_x:
    sw $t2, 0($t8)      # Draw wall pixel
    addiu $t8, $t8, 4   # Next pixel
    subi $t6, $t6, 1    # Decrement width counter
    bnez $t6, wall_loop_x
    
    addi $t7, $t7, 1024 # Move to next row
    subi $t5, $t5, 1    # Decrement height counter
    bnez $t5, wall_loop_y
    
    # Draw roof (red triangle)
    move $t7, $t0       # Reset to base address
    addi $t7, $t7, 49152    # Move down 48 rows
    addi $t7, $t7, 448      # Center horizontally
    subi $t7, $t7, 1024     # Move up one row for roof
    li $t5, 30          # Height of roof
    li $t6, 40          # Initial width from center
    
roof_loop_y:
    move $t8, $t7       # Center position for current row
    # Draw left side of roof
    move $s2, $t6       # Width counter for left side
    move $s3, $t8       # Start from center
left_roof:
    sw $t3, 0($s3)      # Draw roof pixel
    subi $s3, $s3, 4    # Move left
    subi $s2, $s2, 1    # Decrement width counter
    bnez $s2, left_roof
    
    # Draw right side of roof
    move $s2, $t6       # Width counter for right side
    move $s3, $t8       # Start from center again
right_roof:
    sw $t3, 0($s3)      # Draw roof pixel
    addiu $s3, $s3, 4   # Move right
    subi $s2, $s2, 1    # Decrement width counter
    bnez $s2, right_roof
    
    subi $t7, $t7, 1024 # Move up one row
    subi $t6, $t6, 1    # Decrease width for next row
    subi $t5, $t5, 1    # Decrement height counter
    bnez $t5, roof_loop_y
    
    # Draw door
    move $t7, $t0       # Reset to base address
    addi $t7, $t7, 48152    # Move down 48 rows
    addi $t7, $t7, 288      # Center horizontally
    addi $t7, $t7, 20480    # Move down 20 rows for door
    addi $t7, $t7, 160      # Move right 40 pixels
    li $t5, 30          # Door height
door_loop_y:
    li $t6, 20          # Door width
    move $t8, $t7       # Save start of current row
door_loop_x:
    sw $t4, 0($t8)      # Draw door pixel
    addiu $t8, $t8, 4   # Next pixel
    subi $t6, $t6, 1    # Decrement width counter
    bnez $t6, door_loop_x
    
    addi $t7, $t7, 1024 # Move to next row
    subi $t5, $t5, 1    # Decrement height counter
    bnez $t5, door_loop_y
    
    # Draw window
    move $t7, $t0       # Reset to base address
    addi $t7, $t7, 57152    # Move down 48 rows
    addi $t7, $t7, 288      # Center horizontally
    addi $t7, $t7, 8192     # Move down 8 rows
    addi $t7, $t7, 240      # Move right 60 pixels
    li $t5, 20          # Window height
window_loop_y:
    li $t6, 20          # Window width
    move $t8, $t7       # Save start of current row
window_loop_x:
    sw $t9, 0($t8)      # Draw window pixel
    addiu $t8, $t8, 4   # Next pixel
    subi $t6, $t6, 1    # Decrement width counter
    bnez $t6, window_loop_x
    
    addi $t7, $t7, 1024 # Move to next row
    subi $t5, $t5, 1    # Decrement height counter
    bnez $t5, window_loop_y

    # Exit program
    li $v0, 10
    syscall