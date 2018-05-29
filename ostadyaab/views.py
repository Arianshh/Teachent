from flask import render_template, flash, redirect, url_for, abort
from ostadyaab import *
from ostadyaab.forms import BookmarkForm
from ostadyaab.models import User, Bookmark, Teachers

teachers=Teachers().teachers
# Fake login
def logged_in_user():
    return User.query.filter_by(username='sharifi').first()


@app.route('/add', methods=['GET', 'POST'])
def add():
    form = BookmarkForm()
    if form.validate_on_submit():
        url = form.url.data
        description = form.description.data
        bm = Bookmark(user=logged_in_user(), url=url, description=description)
        db.session.add(bm)
        db.session.commit()
        flash("Stored '{}'".format(description))
        return redirect(url_for('index'))
    return render_template('add.html', form=form)
@app.route('/')
@app.route('/search', methods=['GET', 'POST'])
def search():
    users=User.query.all()
    return render_template('index.html', teachers=users)

@app.route('/login')
def login():
    return render_template('login.html')


@app.route('/teacher/<username>')
def user(username):

    user = User.query.filter_by(username=username).first_or_404()
    return render_template('profile.html', user=user)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404


@app.errorhandler(500)
def page_not_found(e):
    return render_template('500.html'), 500

app.run()