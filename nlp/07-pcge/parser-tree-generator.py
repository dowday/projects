__author__ = 'zeroday'
import json
import sys

sys.path.insert(0, "./grammar-definition")
path = "./"
from DiveFct import gmr


class treeBank:
	def __init__(self, treebank_f):
		f = open(treebank_f, "r")
		self.treebank_f = treebank_f
		self.treebank_f = json.load(f)
		f.close()
		self.grammarRL = gmr(self.treebank_f)


LexalizedGrmRL = treeBank(path + 'outputa.json').grammarRL
print("How many grammar rules did you find? \n Found Rules grammar are: ", len(LexalizedGrmRL), "\n")
# print(LexalizedGrmRL)

""" """
cntr1 = 0
for i, j, in LexalizedGrmRL.items():
	if len(i) > 3 or not (i[0].isupper()):
		cntr1 += 1
	ChomRL = cntr1
print("How many of them are not in Chomsky Normal Form?\n", ChomRL, "of", len(LexalizedGrmRL), "are not in Chomsky normal form", "\n")
""" """
cntr2 = 0
for i, j, in LexalizedGrmRL.items():
	if j['P'] == 1:
		cntr2 += 1
	P = cntr2
print("How many rules have a probability of exactly 1? \n", P, "Rules have a probability of exactly 1")
