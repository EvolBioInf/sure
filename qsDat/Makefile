nw = $(shell which noweb)
SH = qsDat

all: $(SH).sh

$(SH).sh: $(SH).org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw $(SH).org | notangle -R$(SH).sh > $(SH).sh;\
	fi
test: clean $(SH).sh 
	bash qsDat.sh
clean:
	rm -rf $(SH).sh acc.txt all all.nwk diff1.fasta diff.fasta frag.fasta fur.db markers1.fasta markers.fasta md5sum.txt nacc.txt ncbi_dataset* ndata ndata.zip neidb_08_oct_24 neighbors README.md tacc.txt targets tdata tdata.zip
