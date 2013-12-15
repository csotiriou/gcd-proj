#File Descriptions
#Legend:
#—- ’s’ indicates the size of each side
#   of the lattice. Do not change this value unless
#   you really know what you are doing.
#— ‘f’ indicates the default character. positions in
#   the lattice that are not explicitly mentioned in
#   this file will get this value
#— ’d’ indicates a position in the lattice. always comes
#   in the form ’d:<lattice>,<column>,<row>=<character>’
#   change manually the values you need. Be careful, you
#   must preserve proper format.
#LATTICE--BEGINS
s:100
f:0
#Data begins below this line
d:0,0,0=a
d:0,0,1=a
d:0,0,2=h
d:0,0,3=a
d:0,0,4=a
d:0,0,5=a
d:0,0,6=a
d:0,0,7=n
d:0,0,8=a
d:0,0,9=a
d:0,1,0=b
d:0,1,1=a
d:0,1,2=0
d:0,1,3=0
d:0,1,4=b
d:0,1,5=0
d:0,1,6=0
d:0,1,7=0
d:0,1,8=1
d:0,2,8=c
d:0,3,8=c
d:0,4,8=c
d:0,5,8=c
d:1,0,0=d
d:2,0,0=d
d:3,0,0=d
d:4,0,0=d
########this is to test the edges#
#########let's get moving...######
d:97,1,1=b
d:98,1,1=f
d:99,1,1=e
##########################
d:1,97,99=m
d:1,98,99=a
d:1,99,99=g
##########################
d:2,99,97=a
d:2,99,98=d
d:2,99,99=g
##########################diagonal??
d:3:10:10=l
d:3:11:11=g
d:3:12:12=g
##########################diagonal2
d:4:53:53=_
d:4:52:54=_
d:4:51:55=_