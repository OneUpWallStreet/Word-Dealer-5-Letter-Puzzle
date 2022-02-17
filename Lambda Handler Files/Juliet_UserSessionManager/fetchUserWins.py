import string
import boto3
from botocore.exceptions import ClientError


def fetchUserWins(userID: string):

    print("Fetch User Wins Is Called!")

    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')
    try: 
        response = table.get_item(Key = {'userID': userID})
        userWins = response["Item"]["userWins"]
        print("UserWins Response: ",userWins)
        return {"dynamoDBInvocationHttpsStatusCode": 200,"userWins": userWins}
    except ClientError as e:
        print(e.response['Error']['Message'])
        return {"dynamoDBInvocationHttpsStatusCode": 404,"userWins": 0}
