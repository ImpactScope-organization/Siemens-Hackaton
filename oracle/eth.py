from web3 import Web3
import json

global contract, PRIVATE_KEY, PUBLIC_KEY, abi, nonce



# Initialize endpoint URL
node_url = "node_url"

# Create the node connection
web3 = Web3(Web3.HTTPProvider(node_url))

PRIVATE_KEY = "priv_key"
PUBLIC_KEY = "public_address"


# read abi
with open('abi.json') as f:
    abi = json.load(f)

# make contract instance
contract = web3.eth.contract(address=Web3.toChecksumAddress('contract_address'), abi=abi)

#print(contract.functions.getNFT(2).call())

def createNFT(image, proof, sensedDate, totalEnergyConsumption, totalEnergyConsumption2, shareOfRenewables, shareOfRenewables2):
    # get nonce
    nonce = web3.eth.getTransactionCount(PUBLIC_KEY)
    # build transaction
    tx = contract.functions.mint(image, proof, sensedDate, totalEnergyConsumption, totalEnergyConsumption2, shareOfRenewables, shareOfRenewables2).build_transaction({'nonce': nonce,'from': PUBLIC_KEY, 'value': 10000,'gas': 250000,'gasPrice': 1000000})
    # sign transaction
    signed_tx = web3.eth.account.sign_transaction(tx, PRIVATE_KEY)
    # send transaction
    tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)

def updateNFT(id, proof, image, sendsedDate, totalEnergyConsumption, totalEnergyConsumption2, shareOfRenewables, shareOfRenewables2):
    # get nonce
    nonce = web3.eth.getTransactionCount(PUBLIC_KEY)
    # build transaction
    tx = contract.functions.updateNFT(id, proof, image, sendsedDate, totalEnergyConsumption, totalEnergyConsumption2, shareOfRenewables, shareOfRenewables2).build_transaction({'nonce': nonce,'from': PUBLIC_KEY, 'gas': 250000,'gasPrice': 1000000})
    # sign transaction
    signed_tx = web3.eth.account.sign_transaction(tx, PRIVATE_KEY)
    # send transaction
    tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)