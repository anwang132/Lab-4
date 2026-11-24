    # addi 
    addi x4, x0, -20        
    addi x5, x4, 0x7F0      
    addi x6, x5, 0x701      
    addi x7, x6, 0x531      

    # andi  
    andi x14, x6, 0x123     
    andi x15, x14, 0x71C    
    andi x17, x15, 0x541    

    # slti (
    slti x18, x4, 311       # set x18 = (x4 < 311) ? 1 : 0
    slti x19, x18, 2        # set x19 = (x18 < 2) ? 1 : 0
    slti x20, x19, 0        # set x20 = (x19 < 0) ? 1 : 0
    slti x21, x20, -3       # set x21 = (x20 < -3) ? 1 : 0
    slti x22, x21, 5        # set x22 = (x21 < 5) ? 1 : 0
    addi x0,  x22, 0        # write to x0 is ignored (still 0)
    slti x23, x4,  -20      
    addi x0,  x23, 0
    slti x24, x11, -90     
    addi x0,  x24, 0
    slti x25, x4,  0        
    addi x0,  x25, 0
    slti x26, x11, 600      
    addi x0,  x26, 0
    slti x27, x4,  -1       
    addi x0,  x27, 0

    # add 
    addi x8,  x0, 100       # x8 = 100
    addi x9,  x0, -1        # x9 = -1
    add  x10, x8, x9        # x10 = 100 + -1 = 99
    add  x11, x10, x4       # x11 = 99 + -20 = 79 (uses previous result)
    add  x12, x9, x9        # x12 = -2
    add  x0,  x8, x8        # write to x0 is ignored
    add  x13, x0, x12       # x13 = 0 + -2 = -2 (x0 still reads 0)

    # sub
    sub  x16, x8, x9        # x16 = 100 - -1 = 101
    sub  x28, x9, x8        # x28 = -1 - 100 = -101
    sub  x29, x16, x16      # x29 = 0
    sub  x30, x29, x28      # x30 = 0 - -101 = 101

    # or
    or   x31, x5, x6        # x31 = 2012 | 3805 = 4061
    or   x1,  x31, x0       # x1 = 4061
    or   x2,  x8, x9        # x2 = 100 | -1 = -1

    # and
    and  x3,  x5, x6        # x3 = 2012 & 3805 = 1756
    and  x10, x3, x9        # x10 = 1756 & -1 = 1756
    and  x11, x10, x0       # x11 = 0

    # negative and boundary immediates
    addi x12, x0, -2048     # x12 = -2048
    addi x13, x12, 2047     # x13 = -1
    andi x16, x13, -2048    # x16 = -1 & 0xFFFFF800 = -2048
    andi x28, x6, -1        # x28 = 3805
    slti x29, x4, -19       # x29 = (-20 < -19) = 1
    slti x30, x8, -1        # x30 = (100 < -1) = 0
    slti x31, x9, 1         # x31 = (-1 < 1) = 1
    addi x0,  x29, 0        # read x29
    addi x0,  x30, 0        # read x30
    addi x0,  x31, 0        # read x31

    # slt
    slt  x1,  x4, x8        # x1 = (-20 < 100) = 1
    slt  x2,  x8, x4        # x2 = (100 < -20) = 0
    slt  x3,  x9, x0        # x3 = (-1 < 0) = 1
    slt  x10, x0, x9        # x10 = (0 < -1) = 0
    slt  x11, x8, x8        # x11 = (100 < 100) = 0
    add  x0,  x1, x2        # read x1, x2
    add  x0,  x3, x10       # read x3, x10
    addi x0,  x11, 0        # read x11

    # sll 
    addi x1,  x0, 31        # x1 = 31
    addi x2,  x0, 1         # x2 = 1
    addi x3,  x0, 32        # x3 = 32
    sll  x10, x2, x1        # x10 = 1 << 31 = 0x80000000
    sll  x11, x9, x0        # x11 = -1 << 0 = -1
    sll  x12, x2, x3        # x12 = 1 << (32 & 31) = 1
    sll  x13, x8, x2        # x13 = 100 << 1 = 200
    add  x16, x10, x9       # x16 = 0x80000000 + -1 = 0x7FFFFFFF (wraps)
    add  x28, x16, x2       # x28 = 0x7FFFFFFF + 1 = 0x80000000 (wraps)
    slt  x29, x10, x16      # x29 = (-2147483648 < 2147483647) = 1
    slt  x30, x16, x10      # x30 = 0
    add  x0,  x11, x12      # read x11, x12
    add  x0,  x13, x28      # read x13, x28
    add  x0,  x29, x30      # read x29, x30

    # srl
    srl  x11, x10, x1       # x11 = 0x80000000 >>> 31 = 1
    srl  x12, x4, x2        # x12 = -20 >>> 1 = 0x7FFFFFF6
    srl  x13, x4, x3        # x13 = -20 >>> (32 & 31) = -20
    srl  x16, x4, x0        # x16 = -20 >>> 0 = -20
    add  x0,  x11, x12      # read x11, x12
    add  x0,  x13, x16      # read x13, x16

    # sra
    sra  x11, x10, x1       # x11 = 0x80000000 >> 31 = -1
    sra  x12, x4, x2        # x12 = -20 >> 1 = -10
    sra  x13, x4, x3        # x13 = -20 >> (32 & 31) = -20
    sra  x16, x4, x0        # x16 = -20 >> 0 = -20
    sra  x28, x8, x2        # x28 = 100 >> 1 = 50
    add  x0,  x11, x12      # read x11, x12
    add  x0,  x13, x16      # read x13, x16
    addi x0,  x28, 0        # read x28
