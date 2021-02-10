.global _start

.text
_start:

  ldr x28, =100  // input number
  mov x27, #16
  udiv x26, x28, x27
  mul x27, x26, x27
  sub sp, sp, x27 // allocate stack

  mov x27, #1
  loop_prime:
    add x27, x27, #1
    mov x19, #8
    udiv x26, x27, x19
    msub x19, x26, x19, x27
    ldr x20, [ sp, x26 ]
    mov x21, #1
    lsl x21, x21, x19
    and x21, x20, x21
    cmp x21, #0
    bne continue
    mov x25, x27
    loop_sieve:
      add x25, x25, x27
      mov x19, #8
      udiv x26, x25, x19
      msub x19, x26, x19, x25
      ldr x20, [ sp, x26 ]
      mov x24, #1
      lsl x24, x24, x19
      orr x24, x20, x24
      str x24, [ sp, x26 ]
      cmp x25, x28
      blt loop_sieve
    continue:
    cmp x27, x28
    blt loop_prime

  mov x25, #2
  loop_through:
    mov x19, #8
    udiv x26, x25, x19
    msub x24, x26, x19, x25
    ldr x26, [ sp, x26 ]
    mov x19, #1
    lsl x19, x19, x24
    and x26, x26, x19
    cmp x26, #0
    bne continue2
    mov x21, #0
    mov x22, #10
    mov x20, x25
    loop_reverse:
      udiv x19, x20, x22
      msub x23, x19, x22, x20
      madd x21, x21, x22, x23
      mov x20, x19
      cmp x19, #0
      bne loop_reverse

    loop_print:
      mov x20, x21
      udiv x21, x20, x22
      msub x23, x21, x22, x20
      add x23, x23, #48
      adr x24, char
      str x23, [ x24 ]
      mov x8, #64
      mov x0, #1
      adr x1, char
      mov x2, #1
      svc #0
      cmp x21, #0
      bne loop_print

    mov x8, #64
    mov x0, #1
    adr x1, spc
    mov x2, #1
    svc #0

    continue2:
    add x25, x25, #1
    cmp x25, x28
    blt loop_through

  mov x8, #64
  mov x0, #1
  adr x1, n
  mov x2, #1
  svc #0

  mov x27, #16
  udiv x26, x28, x27
  mul x27, x26, x27
  add sp, sp, x28 // free stack

  // exit
  mov x8, #93
  mov x0, #0
  svc 0

.data
     n: .ascii "\n"
   spc: .ascii " "
  char: .ascii "."
