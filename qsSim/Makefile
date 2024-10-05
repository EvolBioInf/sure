SH = qsSim

all: $(SH).sh cut.awk

$(SH).sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh
cut.awk: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -Rcut.awk > cut.awk
test: $(SH).sh cut.awk
	rm -rf qs.db queries subjects
	bash $(SH).sh
clean:
	rm -rf $(SH).sh
