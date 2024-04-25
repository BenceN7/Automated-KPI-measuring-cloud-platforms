import json
from datetime import datetime

def handler(event, context):
    n = int(event['number'])

    start = datetime.now() # kezdet

    def fibonacci(n):
        if n <= 0:
            return 0
        elif n == 1:
            return 1
        else:
            return fibonacci(n - 1) + fibonacci(n - 2)

    result = fibonacci(n)

    end = datetime.now() # vege
    execution = f"{(end - start).total_seconds() * 1000:.0f}ms" # milisec

    response = {
        'statusCode': 200,
        'body': json.dumps({'result': result, 'execution': execution})
    }

    return response

