def handler(event, context):
    print("Hello from updated Lambda!")
    return {"statusCode": 200, "body": "Updated!"}

