__author__ = 'mod'
""" 0 => NOGENE , 1 => GENE"""
import sys


# e = {}


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
		eval = e0  # value of e
	if e1 > e0:
		e = '1'
		eval = e1
	return e, e0, e1  # return tag e(O) and e(I)


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
with open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev") as f:
	# a= f.readlines()
	a = [line[:-1] for line in f]
evalues = {}
f = open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev", 'w')
for i in range(len(a)):
	word = a[i]
	if not word:
		f.write("\n")
	else:
		E = emission(a[i], words, count0, count1)
		f.write("{} {}\n".format(word, E[0]))
		evalues[word] = [E[1], E[2]]  # assign for each word its e(0) and e(1)

"""---------------------- """
Gramtagvalue = {}
tagvalue = {}
tags = set()
e = {}
words = set()

with open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.counts", 'r') as f:
	for line in f:
		c = line.strip().split(' ')
		if c[1] == "WORDTAG":
			Gramtagvalue[(c[3], c[2])] = int(c[0])
			words.add(c[3])
		elif c[1] == "1-GRAM":
			tagvalue[c[2]] = int(c[0])
			tags.add(c[2])
	f.close()
	for (word, tag) in Gramtagvalue:
		e[(word, tag)] = Gramtagvalue[(word, tag)] / tagvalue[tag]

""" This function calculate the Qs """


def q():
	q1 = (Gramtagvalue['111'] / Gramtagvalue['11']) * (Gramtagvalue['011'] / Gramtagvalue['01']) * (
		Gramtagvalue['101'] / Gramtagvalue['10']) * (Gramtagvalue['001'] / Gramtagvalue['00'])
	q0 = (Gramtagvalue['110'] / Gramtagvalue['11']) * (Gramtagvalue['010'] / Gramtagvalue['01']) * (
		Gramtagvalue['100'] / Gramtagvalue['10']) * (Gramtagvalue['000'] / Gramtagvalue['00'])
	return q1, q0


q1 = Gramtagvalue['**1'] / Gramtagvalue['**']
q0 = Gramtagvalue['**0'] / Gramtagvalue['**']

I = '1'
O = '0'
f = open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev.p1.out2.txt", 'w')

for i in range(len(a)):
	if not word:
		f.write("\n")
	elif i > 1:
		R = q()
		R1 = R[0] * evalues[a[i]][1]
		R0 = R[1] * evalues[a[i]][0]
		if R1 > R0:
			f.write("{} {}\n".format(word, I))
		else:
			f.write("{} {}\n".format(word, O))
f.close()
