import boto3
from botocore.exceptions import ClientError
import json
import string

def extractWordFromFileIgnoringDuplicates(playedWords: list):

    wordListFile = open("wordList.txt","r")
    wordleWords = set(wordListFile.read().splitlines())

    while True:
        randomWord = wordleWords.pop()
        if randomWord not in playedWords:
            return randomWord
            break
        else:
            continue

    return "drunk"

def convertWordToArray(randomWord: string):
    secretWord = []
    for alphabet in randomWord:
        secretWord.append(alphabet.capitalize())
    return secretWord

def fetchNewSecretWord(userID):
    
    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')

    try: 
        response = table.get_item(Key = {'userID': userID})
        randomWord = extractWordFromFileIgnoringDuplicates(response["Item"]["playedWords"])
        return randomWord

    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("in else")
    
    return "drunk"

