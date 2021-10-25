#!/usr/bin/env python

from flask import Flask, request, send_file, jsonify, Response, render_template
#from healthstatus import check_log
#import panda as pd


app = Flask(__name__)

@app.route("/")
def api():
    return "This is a demo\n"


#@app.route('/logcheck/<raw_input>', methods=['GET'])
#def checklog(raw_input):
#        healthy = request.form ['health']
 #       unhealthy = request.form ['unhealthy']

  #  if not healthy or not unhealthy:
#       return jsonify({"Only word of healthy or unhealthy. Please try again"})
#    else result = checklog(status)
#       result = checklog(raw_input)


#@api.representation('text/csv')
#def data_csv(data, code, headers):
#    '''Get result in csv '''
#    resp = make_response(convert_data(data), code)
#    resp.headers.extend(headers)
#    return resp


#@app.route("/logs/")
#def logs():
#  with open('/home/logs/containerlogs.csv') as csv_file:
#    data = csv.reader(csv_file, delimiter=',')
#    header = next(data)
#    print (header)
#    rows = []
#    for row in data:
#      row.append (row)
# return render_template("logs.html", logs=logs)


if __name__=='__main__':
    app.run(host='0.0.0.0',port=8080)

# from flask import Flask,json, render_template, request

# @app.route("/logs",methods=['GET'])
# def read_logs(logs):
#     json_url = os.path.join("/home/logs","resource.json")
#     if request.method == 'GET':
#         data_json = json.load(open(json_url))
#         data = data_json['events']
#         year = request.view_args['year']
#         output_data = [x for x in data if x['year']==year]
        
#         #render template is always looking in tempate folder
#         return render_template('events.html',html_page_text=output_data)
#     elif request.method == 'POST':
#         year = request.form['year']

#         #case sensitive, so be careful!
#         id = request.form['ID']
#         category = request.form['category']
#         event = request.form['event']
#         event_yr= { "year":year,
#                     "id":id,
#                     "event_category":category,
#                     "event":event
#                     }

#         with open(json_url,"r+") as file:
#             data_json = json.load(file)
#             data_json["events"].append(event_yr)
#             json.dump(data_json, file)
        
#         #Adding text
#         text_success = "Data successfully added: " + str(event_yr)
#         return render_template('index.html', html_page_text=text_success
