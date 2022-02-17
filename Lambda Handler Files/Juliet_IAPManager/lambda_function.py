import json
from handleEnergyPurchase import handleEnergyPurchase, handleEnergyPurchaseModel
from singleGameEnergyUpdate import *
from updateUserEnergy import *


def lambda_handler(event, context):
    # TODO implement

    requestBody = event
    print("requestBody: ",requestBody)

    requestType = requestBody["requestType"]

    if requestType == "updateUserEnergy":
        print("Update UserEnergy is specifially requeested: ", requestType)
        updateEnergyRequest = UpdateEnergyRequestModel(userID=requestBody["userID"]  ,userEnergy=requestBody["userEnergy"])
        response = updateUserEnergyWithServer(updateEnergyRequest=updateEnergyRequest)
        
    elif requestType == "singleGameEnergyUpdate":
        response = singleGameEnergyUpdate(userID=requestBody["userID"])
    elif requestType == "handleEnergyPurchase":
        purchaseRequest = handleEnergyPurchaseModel(userID=requestBody["userID"],energyPurchaseAmount=requestBody["energyPurchaseAmount"])
        response = handleEnergyPurchase(purchaseRequest=purchaseRequest)
    else:
        response = {"should":"never get this lol"}

    return {
        'lambdaInvocationHttpsStatusCode': 200,
        'body': response   
    }