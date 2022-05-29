import requests

endpoint = 'http://192.168.1.7:8000/api/report/'


data = {
    "reportTitle" : "colombia",
    "reportDescription":"sdfs sudfh sdufs dfusd f",
    "latitude": 8.9950565,
    "longitude":38.686775,
    "reportedBy": 2
}

get_response = requests.post(endpoint,json=data)

print(get_response.json())
print(get_response.headers)