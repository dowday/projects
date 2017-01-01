__author__ = 'zeroday'
import json
from DiveFct import FLexalizethetreeB

path = "./"


class CLexalizetreeB:
	def __init__(self, treebank_f):
		# print("create a treeBank")
		f = open(treebank_f, "r")
		self.treebank_f = treebank_f
		self.treebank_f = json.load(f)
		f.close()


TreeBf = CLexalizetreeB(path + 'treebank.json')
lexGrammar = FLexalizethetreeB(TreeBf.treebank_f)
