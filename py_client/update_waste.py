import requests

endpoint = 'http://localhost:8000/api/waste/2/update'



data = {

    "waste_name": "Glass bottle",
    "waste_type": "Glass",
    "for_waste": 'Donate',
    

}

get_response = requests.patch(endpoint, json=data)

print(get_response.json())
