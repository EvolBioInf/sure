nw = $(shell which noweb)
SH = qsSim

all: $(SH).sh cut.awk

$(SH).sh: $(SH).org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh;\
	fi
cut.awk: $(SH).org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw $(SH).org | notangle -Rcut.awk > cut.awk;\
	fi
test: clean $(SH).sh cut.awk
	bash $(SH).sh
clean:
	rm -rf $(SH).sh targets neighbors fur.db
