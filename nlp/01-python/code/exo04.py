__author__ = 'zeroday'
# TP1, Exercice 4 - An index
# The script below take as input a file .txt ( austen.txt ) and
# displays the list of words contained in that file in alphabetical
# order, as well as the lines in which the words appear


# Open the file

f = open('austen.txt', 'r') 
i = 1
# Create dict. to stock as of [word:  nb of occurence in list]
dct = {} 


# A for loop to add the nb of line at the end of the list of the
# selected word
for l in f: 
	for w in l.strip().lower().split(): 
		dct.setdefault(w, []).append(i) 
	i+=1
f.close()

# m return the longest 
# l contains the final result of the index
m = len(max(dct.keys(), key=len))
t = '' 

# A for loop to sort the dict. then to print it in alphabetical order
for k in sorted(dct):
	t += k.ljust(m+1) + " ".join(str(x) for x in dct[k]) + '\n'

print(t)
