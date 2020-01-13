# df -Bm (check sd card disk space)

f = 1/60 # f/s
p = 500 # kb pic size
d = 30 # days

print("needed space: {}".format(d*p*10**3*24*60**2*f*10**-9))

