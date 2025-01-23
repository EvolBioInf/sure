all: fp.awk

fp.awk: fp.org
	bash ../scripts/org2nw fp.org | notangle -Rfp.awk > fp.awk
clean:
	rm -rf fp.awk
