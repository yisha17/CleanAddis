import requests

<<<<<<< HEAD
endpoint = 'http://localhost:8000/api/waste/buyer/7'
=======
endpoint = 'http://localhost:8000/api/waste/seller/5'
>>>>>>> 0af00e03975b441d49b1cd0dfc00386f98d3dd77


data = {
    "waste_name": "plastic bottle",
    "buyer": 7,
    "seller": 5,
    "waste_type": "Plastic",
    "for_waste": 'Sell',
    "quantity": 1244,
    "metric": 'KG',
    "price_per_unit": 31

}

get_response = requests.get(endpoint)

print(get_response.json())
