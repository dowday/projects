# coding=utf-8
# ! /usr/bin/python3.5
# -*- coding: utf-8 -*-

import os
import math
# import cmath

import string

# Function to clean the text and convert it in a list of wods
def purge(txt):
    # On supprime la ponctuation
    punct = string.punctuation

    for c in string.punctuation:
        txt = txt.replace(c, ' ')
    txt = txt.split()

    return txt


# To update the frequency of each word in the dictionnary

def frequpdate(acceptedocc, fileName):
    pass


def frequpdate(acceptedocc, fileName):
    fn = open(fileName, 'r')
    txt = fn.read()
    fn.close()
    txt = purge(txt)

# Increase 1 value of it's corresponding in the dictionnary
    for word in txt:
        if not word in acceptedocc:
            acceptedocc[word] = 1
        else:
            acceptedocc[word] += 1


# Function to do the "apprentissage" Naive Bayes
# it start by extracting the files pos neg
# then computing the priors
# then computing the likelihoods
# the the freq of words
def train(trainingfile):
    listPos = os.listdir(trainingfile + "/pos")
    listNeg = os.listdir(trainingfile + "/neg")

    priorPos = len(listPos) / (len(listPos) + len(listNeg))
    priorNeg = len(listNeg) / (len(listPos) + len(listNeg))

    listfreqPos = {}
    listfreqNeg = {}

    for fileName in listPos:
        frequpdate(listfreqPos, trainingfile + "/pos/" + fileName)
    for fileName in listNeg:
        frequpdate(listfreqNeg, trainingfile + "/neg/" + fileName)

    likelihoodsPos = listfreqPos
    likelihoodsNeg = listfreqNeg

    for key in listfreqPos.keys():
        if not key in listfreqNeg:
            likelihoodsNeg[key] = 0
    for key in listfreqNeg.keys():
        if not key in listfreqPos:
            likelihoodsPos[key] = 0
# Smoothing

    for key in likelihoodsPos.keys():
        likelihoodsPos[key] += 1
    for key in likelihoodsNeg.keys():
        likelihoodsNeg[key] += 1

# Total nb of words
    nWordPos = sum(likelihoodsPos.values())
    nWordNeg = sum(likelihoodsNeg.values())

    for key in likelihoodsPos.keys():
        likelihoodsPos[key] /= nWordPos
    for key in likelihoodsNeg.keys():
        likelihoodsNeg[key] /= nWordNeg

    result = [likelihoodsPos, likelihoodsNeg, priorPos, priorNeg]
    return result

# classifierData
def test(testingfile, classifierData):
    Mxconfusion = [[0, 0], [0, 0]]

    posterioriPos = 0
    posterioriNeg = 0

    listPos = os.listdir(testingfile + "/pos")
    listNeg = os.listdir(testingfile + "/neg")

    listfreq = {}

    for key in listfreq.keys():
        listfreq[key] = 0

    for fileName in listPos:
        frequpdate(listfreq, testingfile + "/pos/" + fileName)

        for key in listfreq.keys():
            if key in classifierData[0]:
                posterioriPos += math.log(classifierData[0][key])
                posterioriNeg += math.log(classifierData[1][key])

        # Increase the confusion matrix for the winner
        if posterioriPos > posterioriNeg:
            Mxconfusion[0][0] += 1
        else:
            Mxconfusion[0][1] += 1

        posterioriPos = 0
        posterioriNeg = 0
        listfreq = {}

    # same process as above
    for fileName in listNeg:
        frequpdate(listfreq, testingfile + "/neg/" + fileName)
        for key in listfreq.keys():
            if key in classifierData[0]:
                posterioriPos += math.log(classifierData[0][key])
                posterioriNeg += math.log(classifierData[1][key])

        if posterioriPos > posterioriNeg:
            Mxconfusion[1][0] += 1
        else:
            Mxconfusion[1][1] += 1

        posterioriPos = 0
        posterioriNeg = 0
        listfreq = {}

    return Mxconfusion

def main(trainingfile, testingfile):
    classifierData = train(trainingfile)
    Mxconfusion = test(testingfile, classifierData)
    print("The confusion matrix is :")
    print(Mxconfusion[0])
    print(Mxconfusion[1])
    print("\n")
    accuracy = (Mxconfusion[0][0] + Mxconfusion[1][1]) / (
    Mxconfusion[0][0] + Mxconfusion[0][1] + Mxconfusion[1][0] + Mxconfusion[1][1])
    precision = Mxconfusion[0][0] / (Mxconfusion[0][0] + Mxconfusion[1][0])
    PosRecall = Mxconfusion[0][0] / (Mxconfusion[0][0] + Mxconfusion[0][1])
    NegRecall = Mxconfusion[1][1] / (Mxconfusion[1][0] + Mxconfusion[1][1])
    print("The accuracy rate is : ")
    print(accuracy)
    print("\n")
    print("The precision is :")
    print(precision)
    print("\n")
    print("The recall of the positive class : ")
    print(PosRecall)
    print("\n")
    print("The recall of the negative class: ")
    print(NegRecall)


if __name__ == '__main__':
    # for En reviews
    # main("movie-reviews-en/train", "movie-reviews-en/test")

    # for FR reviews
    main("movie-reviews-fr/train", "movie-reviews-fr/test")
    # main("train", "test")
