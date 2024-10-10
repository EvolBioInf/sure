fasta2tab $1 |
    sort |
    awk '{print ">" $0}' |
    tr '\t' '\n' |
    wrapSeq
