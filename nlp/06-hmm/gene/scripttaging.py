__author__ = 'mod'
#! /usr/bin/env python3
import sys
words = set()
tags = set()
e = {}

def collectCounts(infilename):
	wordtagcounts = {}
	tagcounts = {}
	f = open(infilename, 'r')
	for line in f:
		elements = line.strip().split(' ')
		if elements[1] == "WORDTAG":
			wordtagcounts[(elements[3], elements[2])] = int(elements[0])
			words.add(elements[3])
		elif elements[1] == "1-GRAM":
			tagcounts[elements[2]] = int(elements[0])
			tags.add(elements[2])
	f.close()
	for (word, tag) in wordtagcounts:
		e[(word, tag)] = wordtagcounts[(word, tag)] / tagcounts[tag]
def sentenceIterator(filehandle):
	currentSentence = [] #Buffer for the current sentence
	for l in filehandle:
		l = l.strip()
		if l == "":
			if currentSentence:
				yield currentSentence
				currentSentence = []
			else:
				sys.stderr.write("WARNING: Got empty input file/stream.\n")
				raise StopIteration
		else:
			currentSentence.append(l)
	if currentSentence:
		yield currentSentence
def tagFile(infilename, outfilename):
	infile = open(infilename, 'r')
	outfile = open(outfilename , 'w')
	for sentence in sentenceIterator(infile):
		for word in sentence:
			maxProb = 0.0
			maxClass = ""
			for c in tags:
				if word not in words:
					emissionProb = e[("_RARE_", c)]
				elif (word, c) not in e:
					emissionProb = 0
				else:
					emissionProb = e[(word, c)]
				if emissionProb > maxProb:
					maxProb = emissionProb
					maxClass = c
			outfile.write("{} {}\n".format(word, maxClass))
		outfile.write("\n")
	infile.close()
	outfile.close()
if __name__ == "__main__":
			collectCounts("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.counts")
			tagFile(sys.argv[2], sys.argv[3])