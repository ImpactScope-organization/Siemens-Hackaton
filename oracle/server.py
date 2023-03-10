from flask import Flask, request
import json
from eth import updateNFT
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route("/update_nft", methods=["POST"])
def update_nft():
    data = request.get_json()
    #get updateNFT function parameters from data
    id = data["id"]
    proof = data["proof"]
    image = data["image"]
    sendsedDate = data["sendsedDate"]
    totalEnergyConsumption = data["totalEnergyConsumption"]
    totalEnergyConsumption2 = data["totalEnergyConsumption2"]
    shareOfRenewables = data["shareOfRenewables"]
    shareOfRenewables2 = data["shareOfRenewables2"]
    
    #calculate emissions
    co2emission = 0.89375 * float(totalEnergyConsumption)
    co2emission2 = 0.89375 * float(totalEnergyConsumption2)
    proof = str(co2emission)
    image = str(co2emission2)


    #write all variables to a json file for caching purposes   
    with open('latest_data.json', 'w') as f:
        json.dump({"id": id, "proof": proof, "image": image, "sendsedDate": sendsedDate, "totalEnergyConsumption": totalEnergyConsumption, "totalEnergyConsumption2": totalEnergyConsumption2, "shareOfRenewables": shareOfRenewables, "shareOfRenewables2": shareOfRenewables2}, f)
    #call updateNFT function
    try :
        updateNFT(id, proof, image, sendsedDate, totalEnergyConsumption, totalEnergyConsumption2, shareOfRenewables, shareOfRenewables2)
        return {"message": "NFT updated successfully"}
    except Exception as e :
        print(str(e))
        return {"message": "NFT update failed"}

@app.route("/nft-data", methods=["GET"])
def get_nft_data():
    with open('latest_data.json', 'r') as f:
        data = json.load(f)
    return data

app.run()