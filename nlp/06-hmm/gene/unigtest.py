__author__ = 'mod'
import tokenize
tagged_text_str = open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.test").read()
train_toks = TaggedTokenizer().tokenize(tagged_text_str)
tagger = UnigramTagger()
tagger.train(train_toks)
# Once a UnigramTagger has been trained, the tag can be used to tag untagged corpera:
tokens = WSTokenizer().tokenize(text_str)
tagger.tag(tokens)
