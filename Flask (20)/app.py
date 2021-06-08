from flask import Flask, render_template

app = Flask(__name__)

files_main = [
    ["test1", "332kb", "2021-06-04"],
    ["test2", "132kb", "2021-06-01"],
    ["test3", "32kb", "2021-06-02"]
]

@app.route('/')
@app.route('/home')
def index():
    return render_template("index.html", files=files_main)


@app.route('/about')
def about():
    return render_template("about.html")


if __name__ == "__main__":
    app.run(debug=True)
