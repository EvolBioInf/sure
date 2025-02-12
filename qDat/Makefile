nw = $(shell which noweb)
SH = qDat

all: $(SH).sh

$(SH).sh: $(SH).org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh;\
	fi
test: $(SH).sh
	rm -rf *.idx ncbi_dataset* README.md md5sum.txt
	bash $(SH).sh
clean:
	rm -rf $(SH).sh
