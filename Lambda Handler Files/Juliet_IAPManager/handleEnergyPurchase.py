import boto3
from dataclasses import dataclass
import string
from botocore.exceptions import ClientError
import enum

class purchaseType(enum.Enum):
    singleEnergyPurchase = 5
    bundleEnergyPurchase = 30
    

@dataclass
class handleEnergyPurchaseModel:
    userID: string
    energyPurchaseAmount: int



def handleEnergyPurchase(purchaseRequest: handleEnergyPurchaseModel):
    

    if purchaseRequest.energyPurchaseAmount == 5:
        energyPurchaseType = purchaseType.singleEnergyPurchase
    elif purchaseRequest.energyPurchaseAmount == 30:
        energyPurchaseType = purchaseType.bundleEnergyPurchase
    else:
        return { "dynamoDBInvocationHttpsStatusCode" : 404}

    
    
    client = boto3.resource('dynamodb')
    table = client.Table('JulietUsers')



    try:
        response = table.update_item(
            Key = {
                "userID": purchaseRequest.userID
            },
            UpdateExpression = "SET energy = energy + :value",
            ExpressionAttributeValues = {
                ":value": energyPurchaseType.value
            },
            ReturnValues = "UPDATED_NEW"
        )
        #Maybe you can also try this return statement
        #return { "dynamoDBInvocationHttpsStatusCode": response["ResponseMetadata"]["HTTPStatusCode"] }
        print("handleEnergyPurchase Response: ",response)

        energy = response["Attributes"]["energy"]

        return { "dynamoDBInvocationHttpsStatusCode" : 200, "userEnergy": energy}
    except ClientError as e:
        print(e.response['Error']['Message'])
        return { "dynamoDBInvocationHttpsStatusCode" : 404, "userEnergy": 0}
    else:
        return {"dynamoDBInvocationHttpsStatusCode": 404}