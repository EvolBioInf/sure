scripts =  qDat qSim qsDat qsSim
all: 
	for script in $(scripts); do \
		make -C $$script; \
		cp $$script/$$script.sh scripts; \
	done
.PHONY: doc data newNeidb
doc:
	make -C doc
clean:
	make clean -C doc
	for script in $(scripts); do \
		make clean -C $$script; \
	done

