__author__ = 'zeroday'
# TP1, Exercice 1 - Interactive interpreter
# The script below do some simple task to get familiar with the
# python interpreter


# define list of wrods
words = ['how', 'why', 'however', 'where', 'never']

# display for each element of the list,
# a star, then the two irst characters of the element, and then the # whole element
for w in words :
	print("*" + w[:2] + ' ' + w)

# display for each element of the list, a star, then the two first 
# characters of the elements, then the whole element
for w in words :
	if w[:2] == ('wh'):
		print("* " + w[:2] + ' ' + w)
	else:
		print("- " + w[:2] + ' ' + w)
