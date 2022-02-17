import boto3
from botocore.exceptions import ClientError


# {
# 'Attributes': {'playedWords': ['drunk']}, 
# 'ResponseMetadata': 
#     {
#     'RequestId': 'JTLA4JA7VHLUJVVC8HADR6QJ2RVV4KQNSO5AEMVJF66Q9ASUAAJG',
#     'HTTPStatusCode': 200,
#     'RetryAttempts': 0
#     }
# }

def updateUserPlayedWordsList(userID,playedWord):
    
    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')

    try:
        response = table.update_item(
            Key = {
                "userID": userID
            },
            UpdateExpression = "SET playedWords = list_append(playedWords, :my_value)",
            ExpressionAttributeValues = {
                ":my_value": [playedWord]
            },
            ReturnValues = "UPDATED_NEW"
        )
        print("Return Response: ",response)
        return { "dynamoDBInvocationHttpsStatusCode": response["ResponseMetadata"]["HTTPStatusCode"] }

    except ClientError as e:
        print(e.response['Error']['Message'])
        return { "dynamoDBInvocationHttpsStatusCode" : 404}
    else:
        return {"dynamoDBInvocationHttpsStatusCode": 404}


