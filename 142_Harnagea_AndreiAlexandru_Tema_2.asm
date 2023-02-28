.data
	minus: .long -1
	newline: .asciz "\n"
	string: .space 6000
	total: .space 1000
	fr: .long 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 
	fr_len: .long 31
	i: .long 0
	aux: .long 0
	elemCurent: .space 4
	sum: .long 0
	index: .space 4
	formatScanf: .asciz "%s"
	formatPrintfN: .asciz "%d "
	formatPrintfS: .asciz "%s "
	chDelim: .asciz " "
	n: .space 1000
	m: .space 1000
	v: .space 6000
	k: .space 1000
	el: .space 100
	aux2: .space 1000
	
.text

.global main

et_afisare:
	movl $0, %ecx
	movl $v, %edi
	xorl %ecx, %ecx
	
for_afisare:
	cmp total, %ecx
	je exit
	
	
	movl (%edi, %ecx, 4), %eax
	pushl %ecx
	
	pushl %eax
	pushl $formatPrintfN
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	
	incl %ecx
	jmp for_afisare
	
	
check_vecini:

	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	movl 12(%ebp), %eax #k
	movl 8(%ebp), %edx #el
	
	movl %eax, el
	movl %edx, k
		
	movl m, %ecx
	
	movl k, %edx
bel1:
	cmp %edx,m
	jge k_eg_m 
	
	
vecini_st:

	cmp $0, %ecx
	je check_cont
	
	cmp k, %ecx
	jg check_cont
	
	movl k, %eax
	subl %ecx, %eax
	movl (%edi, %eax,4), %eax
	
	vezieax:cmp %eax, el
	je check_ret_zero
	
	decl %ecx
	jmp vecini_st

vecini_dr:
	cmp m, %ecx
	jg check_exit
	
	movl %ecx, %eax
	addl k, %eax
	
	cmp total, %eax
	jge check_exit
	
	movl k, %eax
	addl %ecx, %eax
	movl (%edi, %eax,4), %eax
	
	cmp %eax, el
	je check_ret_zero
	
	incl %ecx
	jmp vecini_dr
	

k_eg_m:
	movl k, %ecx
	jmp vecini_st

check_cont:
	movl $0, %ecx
	jmp vecini_dr
	
check_ret_zero:
	popl %ebx
	popl %ebp
	movl $0, %edx
	ret
	
check_exit:
	popl %ebx
	popl %ebp
	movl $1, %edx
	ret

bkt:
	pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ebx
	movl %ebx, k		
	cmp %ebx, total
	je et_afisare
	movl (%edi, %ebx, 4), %eax
	cmp $0,%eax
	jne next_bkt

	movl $1, %ecx
		
bkt_for:
	cmp n,%ecx
	jg exit_bkt
	
	movl %ecx, el
	
	pushl %ecx
	
checkecxel:
	pushl el
	pushl k
	call check_vecini
	popl %ebx
	popl %ebx
	
	popl %ecx
	
	cmp $1, %edx
	je cond1_btk_for
	
	incl %ecx
	jmp bkt_for
	
cond1_btk_for:
	movl (%esi, %ecx, 4), %eax
	cmp $3, %eax
	jl valid
	incl %ecx
	jmp bkt_for

valid:
	movl k, %eax
	movl %ecx, (%edi, %eax, 4)
	movl (%esi, %ecx,4), %eax
	incl %eax
	movl %eax, (%esi, %ecx, 4)
	/*movl %ecx, aux
	movl k, %eax
	movl %eax, aux2*/
	vezieax2:
	
	pushl %ecx
	pushl %eax
	
	movl k, %eax
	
	incl %eax
	vezieax3:
	
	pushl %eax
	call bkt
	popl %ebx
	
	popl %eax
	popl %ecx
checkeaxecxx2:
	/*movl aux2,%eax
	movl aux, %ecx*/
	
	movl $0, (%edi, %eax, 4)
	movl (%esi, %ecx, 4), %eax
checkeaxecxx:
	decl %eax
	movl %eax, (%esi, %ecx, 4)
checkeaxecxx1:
	
	incl %ecx
	jmp bkt_for
	
next_bkt:
	pushl %ebx 
	addl $1, %ebx
	
	pushl %ebx
	call bkt
	popl %ebx
	
	popl %ebx
	jmp exit_bkt
	
exit_bkt:
	popl %ebp
	ret
	
main:
	pushl $string
	call gets
	popl %ebx
	
	pushl $chDelim
	pushl $string
	call strtok 
	popl %ebx
	popl %ebx
	 
	pushl %eax
	call atoi
	popl %ebx
	
	movl %eax, n
	
	movl $3,total
	
	mull total
	
	movl %eax, total
	
	pushl $chDelim
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx
	 
	pushl %eax
	call atoi
	popl %ebx
	movl %eax, m
	
	movl $v, %edi
	movl $fr, %esi
	xorl %ecx, %ecx
	
for_citire:

	pushl %ecx
	
	pushl $chDelim
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx
	
	cmp $0, %eax
	je cont
	
	pushl %eax
	call atoi
	popl %ebx
	
	popl %ecx
	
	movl %eax, (%edi, %ecx,4)
	incl %ecx
	
	movl (%esi, %eax, 4), %edx
	addl $1, %edx
	movl %edx, (%esi, %eax, 4)
	
	jmp for_citire

	
	
cont:
	pushl $0
	call bkt
	popl %ebx
	
	pushl minus
	pushl $formatPrintfN
	call printf
	popl %ebx
	popl %ebx
	
exit:
	pushl $newline
	pushl $formatPrintfS
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80