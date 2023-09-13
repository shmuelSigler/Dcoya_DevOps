import os
from datetime import datetime
from pytz import timezone
from flask import Flask, render_template

app = Flask(__name__)


@app.route("/", methods=['GET'])
def form_page():
    return render_template("index.html", key=os.getenv("HOST_NAME"), datetime=datetime.now(timezone('Asia/Jerusalem')).strftime("%Y-%m-%d %H:%M"))


if __name__ == "__main__":
    app.run(host="0.0.0.0")

