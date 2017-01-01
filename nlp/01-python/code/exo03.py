__author__ = 'zeroday'
# TP1, Exercce 3 - Word frequencies
# The script below counts the frequence of each work in the text


# Assign the text to a variable
txt = '''Le poids politique de Lorient s’affirme à partir de la Révolution française et la ville gagne un rôle
administratif à partir du premier Empire Les activités commerciales restent alors en retrait dans la
première moitié du 19e siècle en raison des conflits fréquents mais les activités militaires gagnent
en importance'''

# transform into lower case characters
txt = txt.lower() 

# convert text to a list
txtlst = txt.split() 


# Create dictionary dictionary where the keys are the words 
# and the values are the frequencies
dct = {}
for w in txtlst:
        if w in dct:
                dct[w] += 1
        else:
                dct[w] = 1

# print the words and their frequencies in alphabetical order
for w in sorted(dct): #sort keys of dct 
	print (w, dct[w]) # print it
