import json
import boto3
import random
import string

# Dataclass can be used like struct you use in swift -> https://stackoverflow.com/a/45426493
from dataclasses import dataclass


@dataclass
class SingleUser:
    vendorID: string
    saltHash: string


def initialUserRegistration(newUser: SingleUser):

    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')
    
    response = table.put_item(
        Item = {
            'userID': newUser.vendorID,
            'saltHash': newUser.saltHash,
            'playedWords': [],
            'energy': 30,
            'hasMadePurchase': False
        }
    )

    return {"dynamoDBInvocationHttpsStatusCode": response["ResponseMetadata"]["HTTPStatusCode"] }


#Why we use a set instead of list for managing word list -> https://stackoverflow.com/a/41466278
#Set add is independant of number of items, as the order is random
def lambda_handler(event, context):

    print("event", event)

    # TODO implement
    requestBody = event
    # requestBody = json.loads(requestBody)

    requestType = requestBody["requestType"]
    


    if requestType == "initialRegistration":  
        saltHash = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(50))
        vendorID = requestBody["vendorID"]
        newUser = SingleUser(vendorID=vendorID,saltHash=saltHash)  
        response = initialUserRegistration(newUser=newUser)

    else:
        response = {
            "message": "did nothing lol"
        }

    return {
        'lambdaInvocationHttpsStatusCode': 200,
        'body': response   
    }
