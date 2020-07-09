from kubernetes import client, config

config.load_incluster_config()

v1=client.CoreV1Api()
print("Listing endpoints in the namespace development:")
api_response = v1.list_namespaced_endpoints(namespace="development", watch=False)
for i in api_response.items:
    for s in i.subsets:
        for a in s.addresses:
            print(a.ip)