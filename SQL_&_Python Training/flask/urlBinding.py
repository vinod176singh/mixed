from flask import Flask
app = Flask(__name__)

@app.route('/')
def welcome():
    return 'Welcome to flask web portal'

@app.route('/hello')
def hello():
    return 'Hello page'

@app.route('/hello/<name>')
def hello_name(name):
    return 'Hello %s!' % name

if __name__ == '__main__':
    app.run()
