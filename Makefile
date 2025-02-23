scripts =  qDat qSim qsDat qsSim
all: 
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
	cp qsSim/cut.awk scripts
	make -C sp
	cp sp/sp.awk scripts
	make -C acc
	cp acc/acc.awk scripts
.PHONY: doc data newNeidb
doc:
	make -C doc
clean:
	make clean -C doc
	for script in $(scripts); do \
		make clean -C $$script; \
	done

