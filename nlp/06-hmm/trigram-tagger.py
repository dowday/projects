__author__ = 'mod'
# This file put the _RARE_ in the train to create a new counts file

with open("./gene/gene.counts") as f:
    content = f.readlines()
c = []
for i in range(len(content)):
    a = content[i]
    a = a.split()
    c.append(a)
rare = []
for i in range(len(c)):
    if int(c[i][0]) < 5:
        rare.append(c[i][len(c[i]) - 1])
with open("./gene/gene.train") as f:
    train = f.readlines()
tr = []
for i in range(len(train)):
    a = train[i]
    a = a.split()
    tr.append(a)

f = open('./gene/gene.train2.txt', 'w')

for i in range(len(tr)):
    if tr[i]:
        if tr[i][0] in rare:
            tr[i][0] = '_RARE_'
            f.write("{} {}\n".format(tr[i][0], tr[i][1]))


f.close()
