{
  if (NF != 12) {
    printf "Blast output should have twelve columns, not %d.\n", NF
    printf "Please check your input.\n"
    exit 1
  }
  curQuery = $1
  qs = $7
  qe = $8
  if (curQuery == prevQuery) {
    for (i = qs; i <= qe; i++)
      query[i] = 1
  } else {
    if (NR > 1) {
      for (i in query) {
        len++
        fp += query[i]
      }
    }
    for (i in query)
      delete query[i]
    for (i = qs; i <= qe; i++)
      query[i] = 0
  }
  prevQuery = curQuery
}
END {
  for (i in query) {
    len++
    fp += query[i]
  }
  printf "Total: %d\n", len
  printf "False: %d\n", fp
  fp = fp / len * 100.0
  printf "False_prediction_rate: %.2f %\n", fp
}
