import requests
import hashlib
import base64

def calculate_integrity_hash(content):
    sha256_hash = hashlib.sha256(content).digest()
    base64_hash = base64.b64encode(sha256_hash).decode('utf-8')
    #print(f"sha256-{base64_hash}") # --> Debugger
    return f"sha256-{base64_hash}"

def validate_sri(url, expected_hash):
    response = requests.get(url)
    if response.status_code == 200:
        integrity_hash = calculate_integrity_hash(response.content)
        if integrity_hash == expected_hash:
            print("SRI validation passed!")
        else:
            print("SRI validation failed: Hash mismatch.")
    else:
        print("Error: Unable to fetch the resource.")

url = "https://code.jquery.com/jquery-3.7.1.js" #--> library URL 
expected_hash = "sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" # --> Hash value 
validate_sri(url, expected_hash)
