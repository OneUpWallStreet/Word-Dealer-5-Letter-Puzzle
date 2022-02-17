import string
import boto3
from botocore.exceptions import ClientError

def extractWordFromFileIgnoringDuplicates(playedWords: list):

    wordListFile = open("wordList.txt","r")
    wordleWords = set(wordListFile.read().splitlines())

    while True:
        randomWord = wordleWords.pop()
        if randomWord not in playedWords:
            return randomWord
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
    return "drunk"



###########################################################################################

def fetchCurrentUserEnergy(userID: string):
    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')

    try: 
        response = table.get_item(Key = {'userID': userID})
        userEnergy: int = response["Item"]["energy"]
        return userEnergy

    except ClientError as e:
        return 0
    else:
        return 0
    
def singleGameEnergyUpdate(userID: string):

    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')

    currentEnergy = fetchCurrentUserEnergy(userID=userID)
    print("currentEnergy: ",currentEnergy)

    if currentEnergy > 0:
        try:
            response = table.update_item(
                Key = {
                    "userID": userID
                },
                UpdateExpression = "SET energy = energy - :value",
                ExpressionAttributeValues = {
                    ":value": 5
                },
                ReturnValues = "UPDATED_NEW"
            )
            energy = response["Attributes"]["energy"]

            return { "dynamoDBInvocationHttpsStatusCode" : 200, "userEnergy": energy}
        except ClientError as e:
            print(e.response['Error']['Message'])
            return { "dynamoDBInvocationHttpsStatusCode" : 404, "userEnergy": 0}
    else:
        return { "dynamoDBInvocationHttpsStatusCode" : 404, "userEnergy": 0}


##########################################################################################


def statNewGameSession(userID: string):

    secretWord = fetchNewSecretWord(userID=userID)
    secretWordArray = convertWordToArray(secretWord)
    energyUpdateResponse = singleGameEnergyUpdate(userID=userID)

    response = {
        "dynamoDBInvocationHttpsStatusCode": 200,
        "userEnergy": energyUpdateResponse["userEnergy"],
        "secretWord": secretWordArray
    }

    return response