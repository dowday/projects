__author__ = 'zeroday'
import mypath
from os import listdir
from os.path import isfile, join
from math import log, fsum

# To run this program write in the terminal 
# $ python3.5 naive-Bayes-classifier.py
'''

''' Here we import the path '''
trnegposa = mypath.patha

''' We put the name of files i the list filestrtt '''
filestrtt = []
for f in listdir(trnegposa):
	if isfile(join(trnegposa, f)):
		filestrtt.append(f)

""" The loop below are fro the files in directory
	so we loop on the file and we put content in the list of training file (lstfa-b)
	"""
lstfa = []
for f in filestrtt:
	optr = open(trnegposa + '/' + f, 'r')
	roptr = optr.read().lower().split()
	lstfa.append(roptr)

trnegposb = mypath.pathb

filestrtt = [f for f in listdir(trnegposb) if
			 isfile(join(trnegposb, f))]  # Put the names of all files in the list filestrtt
lstfb = []
for f in filestrtt:  
	optra = open(trnegposb + '/' + f, 'r')
	roptra = optra.read().lower().split()
	lstfb.append(roptra)

TestA = []
ttnegposa = mypath.pathc

filestrtt = [f for f in listdir(ttnegposa) if
			 isfile(join(ttnegposa, f))]  # Put the names of all files in the list filestrtt
for f in filestrtt:  # This loop open each file in the directory and put the content of the file as an element in the lis lstfa
	op = open(ttnegposa + '/' + f, 'r')
	rop = op.read().lower().split()
	TestA.append(rop)

TestB = []
ttnegposb = mypath.pathd
filestrtt = [f for f in listdir(ttnegposb) if
			 isfile(join(ttnegposb, f))]  # Put the names of all files in the list filestrtt
for f in filestrtt:  # This loop open each file in the directory and put the content of the file as an element in the lis lstfa
	optra = open(ttnegposb + '/' + f, 'r')
	rop = optra.read().lower().split()
	TestB.append(rop)

# the stop word on which our result depend 
stopwords = ['a', 'about', 'above', 'after', 'again', 'against', 'all', 'am', 'an', 'and', 'any', 'are', 'aren\'t','as', 'at', 'be', 'because', 'been', 'before', 'being', 'below', 'between', 'both', 'but', 'by', 'can\'t','cannot', 'could', 'couldn\'t', 'did', 'didn\'t', 'do', 'does', 'doesn\'t', 'doing', 'don\'t', 'down','during', 'each', 'few', 'for', 'from', 'further', 'had', 'hadn\'t', 'has', 'hasn\'t', 'have', 'haven\'t','having', 'he', 'he\'d', 'he\'ll', 'he\'s', 'her', 'here', 'here\'s', 'hers', 'herself', 'him', 'himself','his', 'how', 'how\'s', 'i', 'i\'d', 'i\'ll', 'i\'m', 'i\'ve', 'if', 'in', 'into', 'is', 'isn\'t', 'it','it\'s', 'its', 'itself', 'let\'s', 'me', 'more', 'most', 'mustn\'t', 'my', 'myself', 'no', 'nor', 'not','of', 'off', 'on', 'once', 'only', 'or', 'other', 'ought', 'our', 'ours', 'ourselves', 'out', 'over','own', 'same', 'shan\'t', 'she', 'she\'d', 'she\'ll', 'she\'s', 'should', 'shouldn\'t', 'so', 'some','such', 'than', 'that', 'that\'s', 'the', 'their', 'theirs', 'them', 'themselves', 'then', 'there','there\'s', 'these', 'they', 'they\'d', 'they\'ll', 'they\'re', 'they\'ve', 'this', 'those', 'through','to', 'too', 'under', 'until', 'up', 'very', 'was', 'wasn\'t', 'we', 'we\'d', 'we\'ll', 'we\'re', 'we\'ve','were', 'weren\'t', 'what', 'what\'s', 'when', 'when\'s', 'where', 'where\'s', 'which', 'while', 'who','who\'s', 'whom', 'why', 'why\'s', 'with', 'won\'t', 'would', 'wouldn\'t', 'you', 'you\'d', 'you\'ll','you\'re', 'you\'ve', 'your', 'yours', 'yourself', 'yourselves']

''' We define a dictionary for all feateur (Feas) in the class and his repetetion  '''
WordClassa = {}

lengthofCa = 0
for i in range(len(lstfa)):
	for j in range(len(lstfa[i])):
		lengthofCa += 1  # calculate the length of the class
		if lstfa[i][j] in WordClassa:  # Build a dictionary for the f in class 1
			WordClassa[lstfa[i][j]] += 1
		else:
			WordClassa[lstfa[i][j]] = 1

WordClassb = {}  # Dictionary for each feature (word) in class2 and its repetion
lengthofCb = 0
for i in range(len(lstfb)):
	for j in range(len(lstfb[i])):
		lengthofCb += 1  # calculate the length of the class
		if lstfb[i][j] in WordClassb:
			WordClassb[lstfb[i][j]] += 1
		else:
			WordClassb[lstfb[i][j]] = 1


''' Here the Total Word Class '''
AllFeas = []
for k in WordClassa:
	AllFeas.append(k)
for k in WordClassb:
	if k not in AllFeas:
		AllFeas.append(k)

''' The test of the first class, in the loop below we stock result in this list defined ClTestMoveia and with the not in
we discard the stop words'''

ClTestMoviea = []
for i in range(len(TestA)):
	fcount = {}
	for j in range(len(TestA[i])):
		if TestA[i][j] not in stopwords:
			if TestA[i][j] in fcount:
				fcount[TestA[i][j]] += 1
			else:
				fcount[TestA[i][j]] = 1
	temp1 = []
	for key in fcount:
		if key in WordClassa:
			temp1.append(log((WordClassa[key] + 1) / (lengthofCa + len(AllFeas))))
		else:  # if f not in the class
			temp1.append(log((1) / (lengthofCa + len(AllFeas))))  # if f not in the class
	ClTestMoviea.append(log(len(lstfa) / (len(lstfa) + len(lstfb))) + (fsum(temp1)))

''' The same Test as above Moviesa but here for the second file and in the condition of if key in WordClassb we discard the
words which are not in the test file'''''
ClTestMovieb = []
for i in range(len(TestA)):
	fcount = {}
	for j in range(len(TestA[i])):
		if TestA[i][j] not in stopwords:
			if TestA[i][j] in fcount:
				fcount[TestA[i][j]] += 1
			else:
				fcount[TestA[i][j]] = 1
	temp2 = []
	for key in fcount:
		if key in WordClassb:
			temp2.append(log((WordClassb[key] + 1) / (lengthofCb + len(AllFeas))))
		else:
			temp2.append(log(1 / (lengthofCb + len(AllFeas))))
	ClTestMovieb.append((log(len(lstfb) / (len(lstfa) + len(lstfb))) + (fsum(temp2))))

''' Now we are comparing result collected above for both classes '''
compare = []
for i in range(len(ClTestMoviea)):
	if abs(ClTestMoviea[i]) < abs(ClTestMovieb[i]):
		compare.append(1)
	else:
		compare.append(0)

''' Calculate here the correct  and the wrong results'''
correct = 0
wrong = 0
for i in range(len(compare)):
	if compare[i] == 1:
		correct += 1
	else:
		wrong += 1

ClTestMovieA = []
for i in range(len(TestB)):
	fcount = {}
	for j in range(len(TestB[i])):
		if TestB[i][j] not in stopwords:
			if TestB[i][j] in fcount:
				fcount[TestB[i][j]] += 1
			else:
				fcount[TestB[i][j]] = 1
	temp3 = []
	for key in fcount:
		if key in WordClassa:
			temp3.append(log((WordClassa[key] + 1) / (lengthofCa + len(AllFeas))))
		else:
			temp3.append(log((1) / (lengthofCa + len(AllFeas))))  # if f not in the class
	ClTestMovieA.append((log(len(lstfa) / (len(lstfa) + len(lstfb))) + (fsum(temp3))))

ClTestMovieB = []
for i in range(len(TestB)):
	fcount = {}
	for j in range(len(TestB[i])):
		if TestB[i][j] not in stopwords:
			if TestB[i][j] in fcount:
				fcount[TestB[i][j]] += 1
			else:
				fcount[TestB[i][j]] = 1
	temp4 = []
	for key in fcount:
		if key in WordClassb:
			temp4.append(log((WordClassb[key] + 1) / (lengthofCb + len(AllFeas))))
		else:
			temp4.append(log(1 / (lengthofCb + len(AllFeas))))
	ClTestMovieB.append((log(len(lstfb) / (len(lstfa) + len(lstfb))) + (fsum(temp4))))

compare2 = []
for i in range(len(ClTestMovieB)):
	if abs(ClTestMovieB[i]) < abs(ClTestMovieA[i]):
		compare2.append(1)
	else:
		compare2.append(0)

correct2 = 0
wrong2 = 0
for i in range(len(compare2)):
	if compare2[i] == 1:
		correct2 += 1
	else:
		wrong2 += 1

''' The Accuracy of the classfier and the Confusion matrix for both classes '''
accuracy = ((correct + correct2) / (correct + wrong + correct2 + wrong2)) * 100

MxConfusion = [[['\\'], 'RVC', 'RVW'], ['RVC ', correct2, wrong2], ['RVW ', wrong, correct]]

for i in range(len(MxConfusion)):
	print(MxConfusion[i][0], " ", MxConfusion[i][1], " ", MxConfusion[i][2])

print('Accuracy = ', accuracy, " %")
