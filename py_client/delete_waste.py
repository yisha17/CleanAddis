import requests
endpoint = 'http://localhost:8000/api/waste/delete/2'


get_response = requests.delete(endpoint)

print(get_response.json())
