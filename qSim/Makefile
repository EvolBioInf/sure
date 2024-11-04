SH = qSim

all: $(SH).sh

$(SH).sh: $(SH).org
	bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh
test: $(SH).sh
	rm -r *.idx
	bash $(SH).sh
clean:
	rm -rf $(SH).sh *.idx *.out.txt *.fasta *.map
