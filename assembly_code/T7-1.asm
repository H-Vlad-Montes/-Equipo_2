.text
	addi $s2, $s2, 5
	addi $s0, $s0, 1
	addi $s1, $s1, 2
main:
	ori $s3,$s3, 1
	beq $s2,$s3, else
if:
	addi $s0, $s0, 1
	j main
else:
	addi $s1, $s1, 2
	j main
