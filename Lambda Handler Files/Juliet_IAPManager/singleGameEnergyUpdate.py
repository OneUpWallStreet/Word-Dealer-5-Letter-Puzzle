import boto3
from dataclasses import dataclass
import string
from botocore.exceptions import ClientError


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
            return { "dynamoDBInvocationHttpsStatusCode" : 404}

    else:
        return { "dynamoDBInvocationHttpsStatusCode" : 404, "userEnergy": 0}



