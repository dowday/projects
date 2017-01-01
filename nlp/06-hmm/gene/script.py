__author__ = 'mod'
import  sys
import io
import evaltagger.py


gs_iterator = corpus_iterator(open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev"))
pred_iterator = corpus_iterator(open("C:/Users/mod/OneDrive/2015-2016/Uni/AutumnSem2015/iTALN/TALN_TP/TP6-HMM/gene/gene.dev.p1.out"), with_logprob = False)
evaluator = Evaluator()
evaluator.compare(gs_iterator, pred_iterator)
evaluator.print_scores()
