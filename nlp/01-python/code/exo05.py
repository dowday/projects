__author__ = 'zeroday'
# TP1, Exercice 5 - A concordancer
# The script below, using oop, we create a class concordancer, an 
# initialization method that takes as a parameter the file name and
# loads it, and a method display() that takes as param. a word and
# displays its concordances.
# We test our program with the file austen.txt


# the Concordancer class
class concordancer:
	# This function is to open the file and read it
	def __init__(self, filename):
		f = open(filename, 'r')
		self.txtbd = " " + f.read().strip().lower().replace('\n', ' ') + " "
		f.close()

	# Find exact words and also the index of the -- beginning and end -- of a word
	def display(self, word):
		var = 0
		lc = len(self.txtbd)

		word = " " + word.strip().lower() + " "

		# A lopp to find the occ of the word
		while(1):
			# Find subseq in the body of the text from the postion of its last finded occurence
			var = self.txtbd.find(word, var)
			if(var == -1):
				break

			# To not print out of bound (max width)
			Lbound = max(0, var-20)
			Rbound = min(var+len(word)+20, lc)

			# Define the context of the word
			pre = self.txtbd[Lbound:var]
			post = self.txtbd[var+len(word):Rbound]

			# The start and the end of dots [...]
			if Lbound != 0:
				pre = '...' + pre
			if Rbound != lc:
				post += '...'

			# Print the left context, the right context and on the middle the word (chosen in display)
			print(pre.strip().ljust(25) + word.strip() + post.strip().rjust(25))
			var += len(word)

c = concordancer('austen.txt')
c.display("a")
