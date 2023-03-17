lda $0
cop a x
lda $1
cop a y

loo:

lda $0
cop x a
add y
jmp c1 fin
cop a x

jum loo

fin: