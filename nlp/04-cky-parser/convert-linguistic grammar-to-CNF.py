__author__ = 'zeroday'
# Convert a linguistic grammar to Chomsky Normal Form
import json

g = {
    "I": "S",
    "NTR": [
        ["S", "NP", "VP"],
        ["NP", "DET", "N"],
        ["NP", "DET", "NPP"],
        ["VP", "V", "NP"],
        ["VP", "V", "NPPP"],
        ["NPPP", "NP", "PP"],
        ["NPP", "N", "PP"],
        ["PP", "P", "NP"]
    ],
    "TR": [
        ["DET", "the"],
        ["N", "girl"],
        ["N", "man"],
        ["N", "telescope"],
        ["V", "sees"],
        ["P", "with"]
    ]
}
with open("grammar3.json", "w") as grammar3:
    json.dump(g, grammar3)
