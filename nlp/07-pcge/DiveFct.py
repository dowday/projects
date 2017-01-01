__author__ = 'zeroday'
import json
import headfindingrl


def parse(RL):
	ALLRL, RL1, RL2 = ([] for i in range(3))
	for elt in RL:
		if isinstance(elt, list):
			RL2 += parse(elt)
			RL1.append(elt[0])
		else:
			RL1.append(elt)
	ALLRL.append(RL1)
	if RL2:
		ALLRL += RL2
	return ALLRL


def gmr(treefd):
	ALLRL = []
	for i, j in treefd.items():
		# [parse(j) if ALLRL else parse(i)]
		if ALLRL:
			ALLRL += parse(j)
		else:
			ALLRL = parse(j)
	gmr = {}
	for RL1 in ALLRL:
		if tuple(RL1) in gmr:
			gmr[tuple(RL1)]['eff'] += 1
		else:
			gmr[tuple(RL1)] = {}
			gmr[tuple(RL1)]['eff'] = 1
	LGHRLs = {}
	for i, j in gmr.items():
		if i[0] in LGHRLs:
			LGHRLs[i[0]] += 1
		else:
			LGHRLs[i[0]] = 1
	for i, j in gmr.items():
		j['P'] = j['eff'] / LGHRLs[i[0]]
	return gmr


def FLexSent(senrl, snrlt):
	if all(isinstance(elt, str) for elt in snrlt):
		word = snrlt[0] + "_>" + snrlt[1]
		snrlt[0] = word
		return snrlt
	else:
		length = len(snrlt)
		for index in range(length):
			if isinstance(snrlt[index], list):
				lexelt = FLexSent(senrl, snrlt[index])
				if lexelt[0] == 'NP':
					newElemTagged = headfindingrl.NP(lexelt)
					snrlt[index] = newElemTagged
				elif lexelt[0] == 'ADJP':
					newElemTagged = headfindingrl.ADJP(lexelt)
					snrlt[index] = newElemTagged
				elif lexelt[0] == 'PP':
					newElemTagged = headfindingrl.PP(lexelt)
					snrlt[index] = newElemTagged
				elif lexelt[0] == 'S':
					newElemTagged = headfindingrl.S(lexelt)
					snrlt[index] = newElemTagged
				elif lexelt[0] == 'SBAR':
					newElemTagged = headfindingrl.SBAR(lexelt)
					snrlt[index] = newElemTagged
				elif lexelt[0] == 'VP':
					newElemTagged = headfindingrl.VP(lexelt)
					snrlt[index] = newElemTagged
				else:
					newElemTagged = headfindingrl.default(lexelt)
					snrlt[index] = newElemTagged
	if senrl == snrlt:
		if snrlt[0] == 'NP':
			newSublistTagged = headfindingrl.NP(snrlt)
			snrlt[index] = newSublistTagged
		elif snrlt[0] == 'ADJP':
			newSublistTagged = headfindingrl.ADJP(snrlt)
			snrlt[index] = newSublistTagged
		elif snrlt[0] == 'PP':
			newSublistTagged = headfindingrl.PP(snrlt)
			snrlt[index] = newSublistTagged
		elif snrlt[0] == 'S':
			newSublistTagged = headfindingrl.S(snrlt)
			snrlt[index] = newSublistTagged
		elif snrlt[0] == 'SBAR':
			newSublistTagged = headfindingrl.SBAR(snrlt)
			snrlt[index] = newSublistTagged
		elif snrlt[0] == 'VP':
			newSublistTagged = headfindingrl.VP(snrlt)
			snrlt[index] = newSublistTagged
		else:
			newSublistTagged = headfindingrl.default(snrlt)
			snrlt[index] = newSublistTagged
	return snrlt


def FLexalizethetreeB(dicttB):
	rules = {}
	for i, j in dicttB.items():
		lexelt = FLexSent(j, j)
		rules[i] = lexelt
	with open("output.json", 'w') as f:
		json.dump(rules, f)
