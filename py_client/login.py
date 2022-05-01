import requests

endpoint = 'http://localhost:8000/api/auth/'


data = {
    "username": "dibaba",
    "password": "dibaba"
}

get_response = requests.post(endpoint, json=data)

print(get_response.json())
print(get_response.headers)
