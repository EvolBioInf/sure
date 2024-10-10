SH = qsSim

all: $(SH).sh cut.awk sortSeq.sh

$(SH).sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh
cut.awk: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -Rcut.awk > cut.awk
sortSeq.sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -RsortSeq.sh > sortSeq.sh
test: $(SH).sh cut.awk
	rm -rf qs.db queries subjects
	bash $(SH).sh
clean:
	rm -rf $(SH).sh
