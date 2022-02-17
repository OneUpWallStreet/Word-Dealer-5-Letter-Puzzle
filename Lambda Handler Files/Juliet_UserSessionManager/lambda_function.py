import json
import string
from fetchUserWins import *
from updateUserWins import *
from startNewGameSession import *


#Why we use a set instead of list for managing word list -> https://stackoverflow.com/a/41466278
#Set add is independant of number of items, as the order is random
def lambda_handler(event, context):

    requestBody = event
    requestType = requestBody["requestType"]

    if requestType == "fetchUserWins":
        userID = requestBody["userID"]
        response = fetchUserWins(userID=userID)
    elif requestType == "updateUserWins":
        userID = requestBody["userID"]
        response = updateUserWins(userID=userID)
    elif requestType == "statNewGameSession":
        userID = requestBody["userID"]
        response = statNewGameSession(userID=userID)
    else:
        response = {"this": "should not be called"}

    return {
        'lambdaInvocationHttpsStatusCode': 200,
        'body': response
    }