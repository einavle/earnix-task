from flask import Flask, jsonify, render_template, request
import json
import boto3
import logging
import conf.credentials as conf

# create lambda client
client = boto3.client('lambda',
                      region_name= conf.region,
                      aws_access_key_id=conf.aws_access_key_id,
                      aws_secret_access_key=conf.aws_secret_access_key)

app = Flask(__name__)
app.logger.setLevel(logging.ERROR)

@app.route("/", methods=['GET'])
def getTime():
    result = client.invoke(FunctionName=conf.lambda_function_name,
                           InvocationType='RequestResponse',
                           Payload=json.dumps(payload))
    range = result['Payload'].read()
    api_response = json.loads(range)
    return jsonify(api_response)

    #---START OF SCRIPT(We only need this for local run)
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=6464, debug= True)
