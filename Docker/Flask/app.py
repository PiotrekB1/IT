from flask import Flask, render_template
import random

app = Flask(__name__)

# list of cat images
images = [
    "https://i.gifer.com/3QeI.gif",
    "https://i.gifer.com/JwN.gif",
    "https://gifer.com/en/Xuw0",
    "https://gifer.com/en/59ER",
    "https://gifer.com/en/fyB3"
]

@app.route('/')
def index():
    url = random.choice(images)
    return render_template('index.html', url=url)

if __name__ == "__main__":
    app.run(host="0.0.0.0")