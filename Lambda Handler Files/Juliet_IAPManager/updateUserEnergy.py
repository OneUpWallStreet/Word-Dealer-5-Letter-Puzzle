import boto3
from dataclasses import dataclass
import string
from botocore.exceptions import ClientError


@dataclass
class UpdateEnergyRequestModel:
    userID: string
    userEnergy: int


def updateUserEnergyWithServer(updateEnergyRequest: UpdateEnergyRequestModel):

    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')

    try:
        response = table.update_item(
            Key = {
                "userID": updateEnergyRequest.userID
            },
            UpdateExpression = "SET energy = :a",
            ExpressionAttributeValues = {
                ":a": updateEnergyRequest.userEnergy
            },
            ReturnValues = "UPDATED_NEW"
        )
        print("Return Response For updateUserEnergy: ", response)
        return { "dynamoDBInvocationHttpsStatusCode" : 200}
        

    except ClientError as e:
        print(e.response['Error']['Message'])
        return { "dynamoDBInvocationHttpsStatusCode" : 404}
    else:
        return {"dynamoDBInvocationHttpsStatusCode": 404}
