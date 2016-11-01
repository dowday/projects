__author__ = 'zeroday'
import json
# from nltk.tree import *

# CKY parser 
def CKY(file, sentence):
    f = open(file, 'r')
    grammar = json.load(f)
    w = sentence.split()
    n = len(w) + 1
    """     we create a none list """
    tab = [None] * n
    for i in range(n - 1):
        tab[i + 1] = [None] * (n - i)
    """     we fill the empty array by TR """
    tr = grammar['TR']
    for i in range(n - 1):
        for x in range(len(tr)):
            if w[i] in tr[x]:
                tab[1][i + 1] = tr[x][0]
    """ the algo cyk concern 3 loops and that's what it's done below  """
    ntr = grammar['NTR']
# three loops to apply CYK
    for j in range(2, n):  
        for i in range(1, n - j + 1):
            for k in range(1, j):
                for x in range(len(ntr)):
                    if tab[k][i] == ntr[x][1] and tab[j - k][i + k] == ntr[x][2]:
                        tab[j][i] = ntr[x][0]
    """ respecting the condition we see if the sentence accepted or not and we print the result """
    if tab[n - 1][1] == 'S':
        print('The grammar ', '"' + file + '"', 'accept [', sentence + ' ],', "and")
        # print(tab)
        #  print(len(tab))
    else:
        print('reject [', sentence + ' ].')
        # print(tab)
        # print(len(tab))
        return tab
    """ function to display the tree """
    # def display_rec(self, trees, tab, i, j, depth):
    #     depth = 0
    #     lines = []
    #     j=i
    #     c = tab.pop() if len(tab) > 0 else []
    #     for key in tab[j][i]:
    #         children = tab[j][i][key]
    #         tr.append(c + [[depth, "N", key]])
    #         for child in children:
    #             if len(child) != 4:
    #                 tr = tr[len(tab) - 1].append([depth + 1, "T",child[0]])
    #                 print(tab)
CKY('grammaire1CNF.json', 'a a b c')
CKY('grammaire1CNF.json', 'a b c')

CKY('grammaire2CNF.json', 'le chien joue')
CKY('grammaire2CNF.json', 'le joue chien')

CKY("grammar3.json", 'the girl sees the man with the telescope')
CKY('grammar3.json', 'the girl with the telescoe')
