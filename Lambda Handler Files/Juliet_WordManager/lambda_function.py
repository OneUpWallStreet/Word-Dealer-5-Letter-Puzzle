import json
import string
from fetchNewSecretWord import *
from updateUserPlayedWordsList import *

#Why we use a set instead of list for managing word list -> https://stackoverflow.com/a/41466278
#Set add is independant of number of items, as the order is random
def lambda_handler(event, context):

    requestBody = event
    requestType = requestBody["requestType"]

    if requestType == "fetchNewSecretWord":
        userID = requestBody["userID"]
        randomWord = fetchNewSecretWord(userID=userID)
        secretWord = convertWordToArray(randomWord=randomWord)

        response = {
            "secretWord": secretWord
        }
        
    elif requestType == "updateUserPlayedWordsList":
        userID = requestBody["userID"]
        playedWord = requestBody["playedWord"]
        response = updateUserPlayedWordsList(userID=userID,playedWord=playedWord)

    else:
        response = {
            "hello": "i like coffee"
        }

    return {
        'lambdaInvocationHttpsStatusCode': 200,
        'body': response
    }
