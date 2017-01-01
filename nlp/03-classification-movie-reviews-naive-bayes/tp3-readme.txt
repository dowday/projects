# Below, 7 point that describe 
	# what is about ? go to (1, 2, 3, 4, 5)
	# how to deal with it ? go to (6, 7)
	# how to run the script ? go to (8)

# 1- In this TP, we want to create a Naive Bayes classi ier that 
# learns to classify movie reviews into positive and 
# negative ones, using a bag-of-words model.

# 2- two datasets are provided : movies-reviews-fr.zip containes
# french movie reviews from the allocine.com website
# and movies-reviews-en.zip contains english movie reviews.

# 3- The reviews have been classified as positive or negative reviews
# based on numerical and star ratings associated with them.

# 4- Both archives contain a train folder with the pos. and neg.
# reviews to be used for training the classifier, and test folder
# with the messages to be used for evaluating it.

# 5- We follow the basic formula of the naive bayes algorithm 
# based on the slides given by the prof. (google also)

# 6- How we deal with this exercices in exp1 ?
	# 6.1 Create a simple model with the following params.
	# 6.2 Develop two distinguishable parts ( two procedures ),
	# a training part and a testing part.
	# 6.3 We report 
		# - the results of this exp. in the form of a
		# confusion matrix
		# - accuracy
		# - precision
		# - recall
# 7- How we deal with this exercices in exp2 ?
	# 7.1 we improve the preprocessing by tokenizing
	# 7.2 Eliminate the words and other signs that are not
	# useful (create STOPWORDS list).
	# 7.3 Instead of throwing away unseen words, use smoothing

# 8- Type in the interpreter :
	# ! For FR reviwes go into tp03.py and in main
	# comment (and uncomment the EN line):
	# main("movie-reviews-en/train", "movie-reviews-en/test")
    	main("movie-reviews-fr/train", "movie-reviews-fr/test") 
	# Then type in the interpreter (or F5)
	> python3.5 tp03.py
	
	# ! For EN reviwes go into tp03.py and in main
	# comment (and uncomment the FR line):
	main("movie-reviews-en/train", "movie-reviews-en/test")
    	#main("movie-reviews-fr/train", "movie-reviews-fr/test")
 
	# Then type in the interpreter (or F5)
	> python3.5 tp03.py
	

