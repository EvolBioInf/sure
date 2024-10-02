datasets download genome accession GCF_000001405.40 \
           --include genome,gff3 \
           --dehydrated
unzip ncbi_dataset.zip
datasets rehydrate --directory .
mv ncbi_dataset/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna hs.fna
mv ncbi_dataset/data/GCF_000001405.40/genomic.gff hs.gff
grep '^>' hs.fna | grep NC
getSeq NC_000021.9 hs.fna > chr21.fna
cres chr21.fna
genmap index -F chr21.fna -I chr21_gm.idx
genmap map -I chr21_gm.idx/ -K 15 -E 0 -O chr21_gm.out -t 
tail -n +2 chr21_gm.out.txt |
    tr ' ' '\n' |
    sw -w 10000 > chr21.map
macle -s chr21.fna > chr21_ma.idx
macle -w 10000 chr21_ma.idx > chr21.cm
macle -l chr21_ma.idx
mantile -l 46709983 -g 0.4094 -w 10000 -p 0.05
merwin -w 10000 -t 0.9951 chr21.cm |
    awk '{l=$3-$2+1;printf "%s\t%d\n", $0, l}' |
    sort -n -k 5 -r
awk '$1=="NC_000021.9" && $3=="gene" && $4<=36714000 && $5>=36688001' hs.gff
awk '$2>=36588001 && $2<=36814000 {print $2/1000000, $3, "c"}' chr21.cm > chr21.dat
awk '$2>=36588001 && $2<=36814000 {print $2/1000000, $3, "m"}' chr21.map >> chr21.dat
echo "36.588001 0.9951 t" >> chr21.dat
echo "36.814000 0.9951 t" >> chr21.dat
echo "36.688001 0.2 u"  >> chr21.dat
echo "36.714000 0.2 u"  >> chr21.dat
echo "36.632681 0.1 g1" >> chr21.dat
echo "36.698991 0.1 g1" >> chr21.dat
echo "36.699115 0.1 g2" >> chr21.dat
echo "36.749917 0.1 g2" >> chr21.dat
echo "36.700516 0.1 g3" >> chr21.dat
echo "36.709131 0.1 g3" >> chr21.dat
plotLine -Y "0:1.1" -x "Position (Mb)" -y "Uniqueness" chr21.dat
