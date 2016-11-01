__author__ = 'zeroday'


def gettag(tgrl, alltg, direction, Cone):
    if direction == 'D':
        tgrl = list(reversed(tgrl))
    if Cone == 0:
        for trigger in alltg:
            for elt in tgrl:
                if isinstance(elt, list) and trigger in elt[0]:
                    tag = elt[0].split("_>")
                    if len(tag) > 1:
                        return tag[1]
    else:
        for trigger in alltg:
            for index, elt in enumerate(tgrl):
                if isinstance(elt, list) and trigger in elt[0]:
                    if index < len(tgrl) - 3 and 'CC' in tgrl[index+1][0]:
                        tag = elt[0].split("_>")
                        if len(tag) > 1:
                            return tag[1]
                    elif index > 3 and 'CC' in tgrl[index-1][0]:
                        tag = tgrl[index-2][0].split("_>")
                        if len(tag) > 1:
                            return tag[1]
                    else:
                        tag = elt[0].split("_>")
                        if len(tag) > 1:
                            return tag[1]

def rltg(tgrl, tag):
    ruleTagged = tgrl[0] + "_>" + tag
    ruleNew = tgrl[:]
    ruleNew[0] = ruleTagged
    return ruleNew

def isCCinRulesToTag(tgrl):
    for elt in tgrl:
        if isinstance(elt, list) and 'CC' in elt[0]:
            return True
    return False

""" NP RULE """
def getNPtag(tgrl, isCC):
    if 'POS_' in tgrl[-1][0]:
        tag = tgrl[-1][0].split("_>")
        return tag[1]
    triggers = ['NN', 'NNP', 'NNPS', 'NNS', 'NX', 'POS', 'JJR']
    tag = gettag(tgrl, triggers, 'D', isCC)
    if tag == None:
        triggers = ['NP']
        tag = gettag(tgrl, triggers, 'left', isCC)
    if tag == None:
        triggers = ['$', 'ADJP', 'PRN']
        tag = gettag(tgrl, triggers, 'D', isCC)
    if tag == None:
        triggers = ['CD']
        tag = gettag(tgrl, triggers, 'D', isCC)
    if tag == None:
        triggers = ['JJ', 'JJS', 'RB', 'QP']
        tag = gettag(tgrl, triggers, 'left', isCC)
    if tag == None:
        tag = tgrl[-1][0].split("_>")
        return tag[1]
    return tag

def NP(tgrl):
    isCC = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        isCC = 1
    if '_>' not in tgrl[0]:
        tag = getNPtag(tgrl, isCC)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" ADJP RULE"""
def ADJP(tgrl):
    isCC = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        isCC = 1
    if '_>' not in tgrl[0]:
        triggers = ['NNS', 'QP', 'NN', '$', 'ADVP', 'JJ', 'VBN', 'VBG', 'ADJP', 'JJR', 'NP', 'JJS', 'DT', 'FW', 'RBR', 'RBS', 'SBAR', 'RB']
        tag = gettag(tgrl, triggers, 'left', isCC)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" PP RULE"""
def PP(tgrl):
    isCC = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        isCC = 1
    if '_>' not in tgrl[0]:
        triggers = ['IN', 'TO', 'VBG', 'VBN', 'RP', 'FW']
        tag = gettag(tgrl, triggers, 'D', isCC)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" S RULE"""
def S(tgrl):
    isCC = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        isCC = 1
    if '_>' not in tgrl[0]:
        triggers = ['TO', 'IN', 'VP', 'S', 'SBAR', 'ADJP', 'UCP', 'NP']
        tag = gettag(tgrl, triggers, 'left', isCC)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" SBAR RULE"""
def SBAR(tgrl):
    isCC = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        isCC = 1
    if '_>' not in tgrl[0]:
        triggers = ['WHNP', 'WHPP', 'WHADVP', 'WHADJP', 'IN', 'DT', 'S', 'SQ', 'SINV', 'SBAR', 'FRAG']
        tag = gettag(tgrl, triggers, 'left', isCC)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" VP RULE"""
def VP(tgrl):
    target = 0
    if len(tgrl) > 1 and isCCinRulesToTag(tgrl):
        target = 1
    if '_>' not in tgrl[0]:
        triggers = ['TO', 'VBD', 'VBN', 'MD', 'VBZ', 'VB', 'VBG', 'VBP', 'VP', 'ADJP', 'NN', 'NNS', 'NP']
        tag = gettag(tgrl, triggers, 'left', target)
        if tag != None:
            return rltg(tgrl, tag)
    return tgrl

""" DEFAULT RULE"""
def default(tgrl):
    if "_>" not in tgrl[0]:
        tag = tgrl[1][0].split("_>")
        if tag != None:
            return rltg(tgrl, tag[1])
    return tgrl
