import base64

import requests

with open('test.jpg', 'rb') as file:
    base64_str = base64.b64encode(file.read()).decode()


response = requests.post(
    'URL_OF_YOUR_ENDPOINT',
    json={
        'image': base64_str
    }
)

print(response.json())
