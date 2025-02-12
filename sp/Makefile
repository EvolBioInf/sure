nw = $(shell which noweb)
all: sp.awk

sp.awk: sp.org
	if [ "$(nw)" != "" ]; then\
		bash ../scripts/org2nw sp.org | notangle -Rsp.awk > sp.awk;\
	fi
clean:
	rm -rf sp.awk
