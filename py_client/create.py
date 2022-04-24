import requests

endpoint = 'http://localhost:8000/api/users/'


data = {
    "username" : "colombia",
    "email":"abe@gmail.com",
    "password":"dibaba"
}

get_response = requests.post(endpoint,json=data)

print(get_response.json())
print(get_response.headers)