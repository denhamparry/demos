from kubernetes import client, config

config.load_kube_config()

v1=client.CoreV1Api()
print("Listing endpoints in the namespace development:")
api_response = v1.list_namespaced_endpoints(namespace="development", watch=False)
print(api_response)