import requests


endpoint = 'http://localhost:8000/api/waste/'




data = {
    "waste_name": "plastic bottle",
    "seller": 19,
    "waste_type": "Plastic",
    "for_waste": 'Sell',
    "quantity": 1244,
    "metric": 'KG',
    "price_per_unit": 31,
    "description":"refined bottle",
    "location" : "Piassa around Commercial bank",   

}

get_response = requests.get(endpoint)

print(get_response.json())
