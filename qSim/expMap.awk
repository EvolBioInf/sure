BEGIN {
  k = 15   # k-mer length
  m = 1/100 # mutation rate
  p0 = (1-m)^k # probability k-mer not mutated
  pm = 1-p0 # probability k-mer mutated
  c = 2*p0 + pm # expected count
  map = p0/2 + pm # expected mappability
  print "expected mappability: " map
  print "expected count: " c
  print "expected mappability from count: " 1/c
}
