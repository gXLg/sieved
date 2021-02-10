# prime generator made by gXLg #
from sys import argv as a
from time import perf_counter as c
t = c ( )
n = set ( )
p = [ ]
if str.isdigit ( a [ -1 ] ) :
  m = int ( a [ - 1 ] )
else :
  m = 1000

l = 1
for i in range ( 2, m ) :
  if i not in n :
    p.append ( i )
    n.update ( j for j in range ( i * i, m, i * l ))
    l = 2
print ( c ( ) - t )
print ( p )
# usage: python prime.py [maxnum] #
