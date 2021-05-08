import numpy as np
from flask import Flask, request, jsonify, render_template
import pickle
import json
import requests
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

# read saved trined model
model = pickle.load(open('model.pkl', 'rb'))



@app.route('/predictAPI', methods =['POST', 'GET'])
# @cross_origin()
# @app.route('/predictAPI')

def predictAPI():
    '''
    To return the preduction as jdon
    '''
    # read the json file the sent from client 
    values = json.loads(request.data.decode('utf-8'))

    # values =[31, 99.95, 0, 1,0, 0,1,1,1,0, 1,0,0,1,1,0,0,0, 1,0]

    # convert the values sent to float and save it in an array
    int_features = [float(x) for x in values]

    final_features = [np.array(int_features)]

    # use the model to predict
    prediction = model.predict(final_features)
    print(prediction)

    # the format of return value
    # ['will churn or not']
    # return the response as json formate
    return jsonify(str(prediction[0])), 200



if __name__ == "__main__":
    app.run(debug=True)
