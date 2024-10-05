NF > 2 {
  for (i=3; i<=NF; i++) {
    cmd = sprintf("cutSeq -r %d-%d markers.fasta",
                    $i, $i)
    system(cmd)
  }
}
