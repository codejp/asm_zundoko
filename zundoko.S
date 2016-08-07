#define LGCS_A		5
#define LGCS_B		3
#define LGCS_M_1	32767
#define CHK_MSK		/*0x0004*/ /*0x0008*/ /*0x0010*/ 0x0080

	.code16

	.text

.macro	putch	chr
	movb	$0x0e, %ah
	movb	$\chr, %al
	movw	$0x000f, %bx
	int	$0x10
.endm

	cli

	movw	$0x07c0, %ax
	movw	%ax, %ds

	/* set video mode */
	movw	$0x0003, %ax
	int	$0x10

	/* init random seed */
	movb	$0x00, %ah
	int	$0x1a
	movw	%dx, %si

	/* clear zun counter */
clear_counter:
	movw	$0, %di

	/* get a random number */
get_random:
	movw	$LGCS_A, %ax
	mulw	%si
	addw	$LGCS_B, %ax
	andw	$LGCS_M_1, %ax
	movw	%ax, %si

	/* check zun or doko */
	testw	$CHK_MSK, %ax
	jz	doko
zun:
	putch	'z'
	putch	'u'
	putch	'n'
	putch	' '

	addw	$1, %di
	jmp	get_random
doko:
	putch	'd'
	putch	'o'
	putch	'k'
	putch	'o'
	putch	' '

	cmpw	$4, %di
	jl	clear_counter

	putch	'k'
	putch	'i'
	putch	' '
	putch	'y'
	putch	'o'
	putch	' '
	putch	's'
	putch	'h'
	putch	'i'

end:
	hlt
	jmp	end
