wordleTextFile = open("wordleText.txt","r+")
stanfordTextFile = open("stanfordText.txt","r+")
finalTextFile = open("finalText.txt","r+")

uniqueWordSet = set()


wordleWords = wordleTextFile.read().splitlines()
stanfordWords = stanfordTextFile.read().splitlines()


for word in wordleWords + stanfordWords:
    uniqueWordSet.add(word) 


for uniqueWord in uniqueWordSet:
    finalTextFile.write(uniqueWord+"\n")
