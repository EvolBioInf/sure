set terminal postscript eps color size 6cm, 3cm
set output "acc1.ps"
set xlabel "Position (kb)"
unset ytics
plot [0:10][-1:3]  "-" t "p" w li lw 5, \
                  "-" t "t" w li lw 5, \
		  "-" t "" w li lc "black", \
		  "-" t "" w li lc "black"
4.480 1
5.523 1
e
4.501 0
5.500 0
e
4.501 -1
4.501 3
e
5.500 -1
5.500 3
e

set key top center
set output "acc2.ps"
plot [4.4:5.7][-1:3]  "-" t "p" w li lw 5, \
                  "-" t "t" w li lw 5, \
		  "-" t "" w li lc "black", \
		  "-" t "" w li lc "black"
4.480 1
5.523 1
e
4.501 0
5.500 0
e
4.501 -1
4.501 3
e
5.500 -1
5.500 3
e