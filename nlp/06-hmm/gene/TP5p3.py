def emission(word, words, count0, count1):
	e1 = 0
	e0 = 0
	if word not in words:
		word = '_RARE_'
	x = words[word]
	if '0' in x:
		j = x.index('0')
		e0 = float(x[j - 1]) / float(count0)
	if '1' in x:
		k = x.index('1')
		e1 = float(x[k - 1]) / float(count1)
	if e0 > e1:
		e = '0'  # type of gene
		ev = e0  # value of e
	if e1 > e0:
		e = '1'
		ev = e1
	return e, ev


with open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.counts") as f:
	content = f.readlines()

c = []
for i in range(len(content)):
	a = content[i]
	a = a.split()
	c.append(a)

words = {}
for i in range(len(c)):
	if c[i][1] == 'WORDTAG':
		if c[i][3] in words:
			words[c[i][3]].append(c[i][0])
			words[c[i][3]].append(c[i][2])
		else:
			words[c[i][3]] = [c[i][0], c[i][2]]

for i in range(len(c)):
	if '1-GRAM' in c[i] and '0' in c[i]:
		count0 = c[i][0]
	if '1-GRAM' in c[i] and '1' in c[i]:
		count1 = c[i][0]
	# The following to generate dev.p1.out1
with open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev") as f:
	a = [line[:-1] for line in f]
evalues = []
f = open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev.p1.out1.txt", 'w')
for i in range(len(a)):
	word = a[i]
	if not word:
		f.write("\n")
	else:
		E = emission(a[i], words, count0, count1)
		f.write("{} {}\n".format(word, E[0]))
		evalues.append(E[1])

f.close()
# The following to generate the file test.p1.out1
with open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.test") as f:
	a = [line[:-1] for line in f]
evalues = []
f = open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.test.p1.out1.txt", 'w')
for i in range(len(a)):
	word = a[i]
	if not word:
		f.write("\n")
	else:
		E = emission(a[i], words, count0, count1)
		f.write("{} {}\n".format(word, E[0]))

f.close()
