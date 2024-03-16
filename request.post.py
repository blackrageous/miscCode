import requests

# Define the authentication endpoint
url = 'https://example.com/login'

# Define the credentials
payload = {
    'username': 'your_username',
    'password': 'your_password'
}

try:
    # Make a POST request with the credentials
    response = requests.post(url, data=payload)
    
    # Check if the request was successful (status code 200)
    if response.status_code == 200:
        print("Authentication successful!")
        # Parse the JSON response
        response_json = response.json()
        
        # Print all name-value pairs in the response
        print("Returned data:")
        for key, value in response_json.items():
            print(f"{key}: {value}")
    else:
        print("Authentication failed. Status code:", response.status_code)
        # Print the response content if needed
        # print(response.text)
except requests.exceptions.RequestException as e:
    # Handle any connection errors
    print("Error:", e)
