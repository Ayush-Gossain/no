upload file in azure blob storage in flask api


from flask import Flask, request
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

app = Flask(__name__)

# Azure Storage Account credentials
storage_account_name = 'your_storage_account_name'
storage_account_key = 'your_storage_account_key_or_connection_string'
container_name = 'your_container_name'

# Initialize Azure Blob Service Client
blob_service_client = BlobServiceClient.from_connection_string(f"DefaultEndpointsProtocol=https;AccountName={storage_account_name};AccountKey={storage_account_key};EndpointSuffix=core.windows.net")

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return 'No file part'

    file = request.files['file']

    if file.filename == '':
        return 'No selected file'

    # Upload file to Azure Blob Storage
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=file.filename)
    blob_client.upload_blob(file)

    return 'File uploaded successfully'

if __name__ == '__main__':
    app.run(debug=True)



create blob in azure blob storage in flask api

from flask import Flask, request
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

app = Flask(__name__)

# Azure Storage Account credentials
storage_account_name = 'your_storage_account_name'
storage_account_key = 'your_storage_account_key_or_connection_string'
container_name = 'your_container_name'

# Initialize Azure Blob Service Client
blob_service_client = BlobServiceClient.from_connection_string(f"DefaultEndpointsProtocol=https;AccountName={storage_account_name};AccountKey={storage_account_key};EndpointSuffix=core.windows.net")

@app.route('/create_blob', methods=['POST'])
def create_blob():
    data = request.json  # Assuming JSON data with blob_name and blob_content

    if 'blob_name' not in data or 'blob_content' not in data:
        return 'Invalid request'

    blob_name = data['blob_name']
    blob_content = data['blob_content']

    # Create a blob client
    blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

    # Upload blob content
    blob_client.upload_blob(blob_content)

    return f'Blob "{blob_name}" created successfully'

if __name__ == '__main__':
    app.run(debug=True)

