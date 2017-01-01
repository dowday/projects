import random
import statistics
# This is the machine on which programs are executed
# The output is the value on top of the pile. 
class CPU:
	def __init__(self):
		self.pile = []

	def reset(self):
		while len(self.pile) > 0: self.pile.pop()


# These are the instructions
def AND(cpu, data):
	return cpu.pile.pop() and cpu.pile.pop()


def OR(cpu, data):
	return cpu.pile.pop() or cpu.pile.pop()


def XOR(cpu, data):
	return (cpu.pile.pop() + cpu.pile.pop()) % 2


# if bool(cpu) == bool(data):
# 	return False
# else:
# 	return cpu or data


def NOT(cpu, data):
	return not cpu.pile.pop()


# Push values of variables on the stack.
def X1(cpu, data):
	cpu.pile.append(data[0])


def X2(cpu, data):
	cpu.pile.append(data[1])


def X3(cpu, data):
	cpu.pile.append(data[2])


def X4(cpu, data):
	cpu.pile.append(data[3])


# Execute a program
def execute(program, cpu, data):
	# print(data)
	for instruction in program:
		if instruction == "X1":
			X1(cpu, data)
		elif instruction == "X2":
			X2(cpu, data)
		elif instruction == "X3":
			X3(cpu, data)
		elif instruction == "X4":
			X4(cpu, data)

		elif instruction == "NOT" and len(cpu.pile) > 0:
			cpu.pile.append(NOT(cpu, data))
		elif instruction == "AND" and len(cpu.pile) > 1:
			cpu.pile.append(AND(cpu, data))
		elif instruction == "OR" and len(cpu.pile) > 1:
			cpu.pile.append(OR(cpu, data))
		elif instruction == "XOR" and len(cpu.pile) > 1:
			cpu.pile.append(XOR(cpu, data))
	""" If there are no instruction then return no var"""
	if len(cpu.pile) == 0:
		return "Exception no var"

	outp = cpu.pile.pop()
	cpu.reset()
	return outp


# Generate a random program
def randomProg(length, functionSet, terminalSet):
	return [random.choice(terminalSet + functionSet) for i in range(length)]


# Computes the fitness of a program.
# The fitness counts how many instances of data in dataSet are correctly computed by the program
# computeFitness(['X3', 'X2', 'XOR', 'NOT', 'X4', 'AND'],cpu,dataSet)=> 1
def computeFitness(prog, cpu, dataSet):
	BestCost = 0
	for data in dataSet:
		if data[-1] != execute(prog, cpu, data):
			BestCost += 1
	return BestCost


# Selection using 2-tournament.
def selection(Population, cpu, dataSet):
	listOfFitness = []
	for i in range(len(Population)):
		prog = Population[i]
		f = computeFitness(prog, cpu, dataSet)
		listOfFitness.append((i, f))

	newPopulation = []
	n = len(Population)
	for i in range(n):
		i1 = random.randint(0, n - 1)
		i2 = random.randint(0, n - 1)
		if listOfFitness[i1][1] > listOfFitness[i2][1]:
			newPopulation.append(Population[i1])
		else:
			newPopulation.append(Population[i2])
	return newPopulation


def crossover(Population, p_c):
	newPopulation = []
	n = len(Population)
	i = 0
	while (i < n):
		p1 = Population[i]
		p2 = Population[(i + 1) % n]
		m = len(p1)
		if random.random() < p_c:  # crossover
			k = random.randint(1, m - 1)
			newP1 = p1[0:k] + p2[k:m]
			newP2 = p2[0:k] + p1[k:m]
			p1 = newP1
			p2 = newP2
		newPopulation.append(p1)
		newPopulation.append(p2)
		i += 2
	return newPopulation


def mutation(Population, p_m, terminalSet, functionSet):
	newPopulation = []
	nT = len(terminalSet) - 1
	nF = len(functionSet) - 1
	for p in Population:
		for i in range(len(p)):
			if random.random() > p_m: continue
			if random.random() < 0.5:
				p[i] = terminalSet[random.randint(0, nT)]
			else:
				p[i] = functionSet[random.randint(0, nF)]
		newPopulation.append(p)
	return newPopulation

# -------------------------------------

# LOOK-UO TABLE YOU HAVE TO REPRODUCE.
nbVar = 4
dataSet = [[0, 0, 0, 0, 0], [0, 0, 0, 1, 1], [0, 0, 1, 0, 0], [0, 0, 1, 1, 0], [0, 1, 0, 0, 0], [0, 1, 0, 1, 0],
		   [0, 1, 1, 0, 0], [0, 1, 1, 1, 1], [1, 0, 0, 0, 0], [1, 0, 0, 1, 1], [1, 0, 1, 0, 0], [1, 0, 1, 1, 0],
		   [1, 1, 0, 0, 0], [1, 1, 0, 1, 0], [1, 1, 1, 0, 0], [1, 1, 1, 1, 0]]
#print("dataSet", dataSet)

cpu = CPU()

# Function and terminal sets.
functionSet = ["AND", "OR", "NOT", "XOR"]
terminalSet = ["X1", "X2", "X3", "X4"]

# Example of program.
# prog = ["OR", "NOT", "X2", "OR", "X0"]
#prog = ['OR', 'NOT', 'X2', 'OR', 'X0']
# prog = ["X1", "X2", "AND", "X3", "OR"]
"""
["OR", "NOT", "X2", "OR", "X0"] fitness= 5
["X1", "X2", "OR", "X0", "OR"] fitness= 2
["OR", "X2", "OR", "X0", "X0"] fitness= 5
["OR", "X2", "X2", "X1", "X1"] fitness= 2
["X2", "X0", "X0", "OR", "X0"] fitness= 5
["OR", "OR", "AND", "X1", "X0"] fitness= 5
["X0", "X0", "X1", "X2", "X0"] fitness= 1
["X0", "OR", "X2", "X0", "OR"] fitness= 3
["AND", "X2", "NOT", "OR", "X0"] fitness= 5
["OR", "AND", "X2", "X1", "AND"] fitness= 7
["X0", "AND", "AND", "X0", "NOT"] fitness= 3
["X2", "X2", "X2", "X0", "X0"] fitness= 5
"""
progLength = 6
prog = randomProg(progLength, functionSet, terminalSet)
print("prog :", prog)


# Execute a program on one row of the data set.
data = dataSet[0]
output = execute(prog, cpu, data)
print("output of execute(prog, cpu, data) : ", output)
print("-------------")

# Parameters
popSize = 12
p_c = 0.6 #0.01 0.1 0.2 0.4 0.5
p_m = 0.4

# Generate the initial population
population = []
for i in range(popSize):
	population.append(randomProg(progLength, functionSet, terminalSet))
	#print(population)
#print("this is pop:", population)
# Evolution. Loop on the creation of population at generation i+1 from population at generation i.
# I remove the worst and replace it by the last best one
tbf = []
for i in range(50):
	Bf = min(list(map(lambda x: (x, computeFitness(x, cpu, dataSet)), population)), key=lambda x: x[1])
	population = selection(population, cpu, dataSet)
	population = crossover(population, p_c)
	population = mutation(population, p_m, terminalSet, functionSet)
	worst = max(list(map(lambda x: (x, computeFitness(x, cpu, dataSet)), population)), key=lambda x: x[1])
	population[population.index(worst[0])] = Bf[0]
	#print(min(list(map(lambda x: (x, computeFitness(x, cpu, dataSet)), population)), key=lambda x: x[1]))
	tbf.append(Bf[1])
print("'Min =", min(list(map(lambda x: (x, computeFitness(x, cpu, dataSet)), population)), key=lambda x: x[1]))
print(tbf)
std = statistics.stdev(tbf)
mean = statistics.mean(tbf)
print("\n Mean ", mean, "\n STD", std)