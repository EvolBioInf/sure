url="owncloud.gwdg.de/index.php/s/ppwwPU5zppLkV2q/download"
wget "https://${url}" -O neidb_08_oct_24.bz2
bunzip2 neidb_08_oct_24.bz2
name="Legionella pneumophila subsp. pneumophila"
name="$name str. Philadelphia 1"
taxi "$name" neidb_08_oct_24
ants 272624 neidb_08_oct_24
printf 91891 | neighbors -g neidb_08_oct_24
printf 91891 |
    neighbors -l neidb_08_oct_24 > acc.txt
head acc.txt
grep -c '^t' acc.txt
grep -c '^n' acc.txt
grep '^t' acc.txt | awk '{print $2}' > tacc.txt
grep '^n' acc.txt | awk '{print $2}' > nacc.txt
for a in t n; do
    datasets download genome accession \
               --inputfile ${a}acc.txt \
               --assembly-level complete \
               --include genome \
               --exclude-atypical \
               --dehydrated \
               --filename ${a}data.zip
done
for a in t n; do
    unzip ${a}data.zip -d ${a}data
    datasets rehydrate --directory ${a}data
done
mkdir all
for p in t n; do
    for a in ${p}data/ncbi_dataset/data/*/*.fna; do
          b=$(basename $a)
          mv $a all/${p}$b
    done
done
ls all/t* | wc -l
ls all/n* | wc -l
phylonium all/* |
    nj |
    midRoot > all.nwk
sed -E 's/([tn])[^a]*.fna/\1/g' all.nwk |
    plotTree
land all.nwk | plotTree
mkdir targets
land all.nwk |
    pickle 16 |
    grep -v '^#' |
    while read a; do
          ln -s $(pwd)/all/$a $(pwd)/targets/$a
    done
mkdir neighbors
land all.nwk |
    pickle -c 16 |
    grep -v '^#' |
    while read a; do
          ln -s $(pwd)/all/$a $(pwd)/neighbors/$a
    done
kec e -t targets/ -n neighbors/ --min 100 -k 15 -o diff.fasta
bash sortSeq.sh diff.fasta > tmp
mv tmp diff.fasta
head diff.fasta
head -n 3 diff.fasta > diff1.fasta
sblast diff1.fasta targets/*.fna |
    tail -n +2 |
    awk '{print $2}' |
    sort |
    uniq |
    wc -l
sblast diff1.fasta neighbors/*.fna  |
    tail -n +2 |
    awk '{print $2}' |
    sort |
    uniq |
    wc -l
makeFurDb -t targets/ -n neighbors/ -d fur.db
fur -d fur.db > markers.fasta
head -n 3 markers.fasta > markers1.fasta
sblast markers1.fasta targets/*.fna |
    tail -n +2 |
    awk '{print $2}' |
    sort |
    uniq |
    wc -l
sblast markers1.fasta neighbors/*.fna
