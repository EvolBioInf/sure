nw = $(shell which noweb)
all: acc.awk acc1.ps acc2.ps
acc.awk: acc.org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw acc.org | notangle -Racc.awk > acc.awk;\
	fi
acc1.ps: acc.gp
	gnuplot acc.gp
acc2.ps: acc.gp
	gnuplot acc.gp
test: acc.awk
	bash test.sh
clean:
	rm -f acc.awk acc1.ps acc2.ps
