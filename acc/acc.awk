BEGIN {
  m = "please set the true start (ts), "
  m = m "true end (te), "
  m = m "and target length (tl)"
  if (!ts || !te || !tl) {
    print m
    exit
  }
  for (i = 1; i <= tl; i++)
    hit[i] = 0
}
!/^#/ {
  s = $5
  e = $6
  for (i = s; i <= e; i++)
    hit[i] = 1
}
END {
  tp = 0
  for (i = ts; i <= te; i++)
    tp += hit[i]
  fp = 0
  for (i = 1; i < ts; i++)
    fp += hit[i]
  for (i = te+1; i <= tl; i++)
    fp += hit[i]
  l = te - ts + 1
  tn = tl - l - fp
  fn = l - tp
  n = tp * tn - fp * fn
  d = sqrt((tp + fp) * (tn + fn) * (tn + fp) * (tp + fn))
  if (d > 0)
    c = n / d
  else
    c = 0
  printf "C: %f\n", c

}
