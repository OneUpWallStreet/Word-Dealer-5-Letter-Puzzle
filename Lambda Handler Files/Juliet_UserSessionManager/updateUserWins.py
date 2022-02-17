from ast import Return
import string
import boto3
from botocore.exceptions import ClientError


def updateUserWins(userID: string):

    print("Update User Wins Called")

    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')
    
    try:
        response = table.update_item(
            Key = {
                "userID": userID
            },
            UpdateExpression = "SET userWins = userWins + :myValue",
            ExpressionAttributeValues = {
                ":myValue": 1
            },
            ReturnValues = "UPDATED_NEW"
        )
        userWins = response["Attributes"]["userWins"]
        print("UserWinsUpdate Respones:", userWins)
        return { "dynamoDBInvocationHttpsStatusCode": response["ResponseMetadata"]["HTTPStatusCode"], "userWins": userWins  } 
    except ClientError as e:
        print("error:")
        return {"dynamoDBInvocationHttpsStatusCode": 404, "userWins": 0}


