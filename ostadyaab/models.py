from datetime import datetime

from sqlalchemy import desc

from ostadyaab import db


class Bookmark(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    url = db.Column(db.Text, nullable=False)
    date = db.Column(db.DateTime, default=datetime.utcnow)
    description = db.Column(db.String(300))
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)


    @staticmethod
    def newest(num):
        return Bookmark.query.order_by(desc(Bookmark.date)).limit(num)

    def __repr__(self):
        return "<Bookmark '{}': '{}'>".format(self.description, self.url)

class Teachers:
    def __init__(self):
        self.teachers=[]
    def ad(self,User):
        self.teachers.append(User)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    age = db.Column(db.Integer, nullable=False)
    konkoorRank = db.Column(db.Integer, nullable=False)
    madrak = db.Column(db.String(80),nullable=False)
    reshte = db.Column(db.String(80),nullable=False)
    username = db.Column(db.String(80), unique=True)
    email = db.Column(db.String(120), unique=True)
    bookmarks = db.relationship('Bookmark', backref='user', lazy='dynamic')
    name = db.Column(db.String(20), unique=False)
    surname = db.Column(db.String(20), unique=False)
    password = db.Column(db.String(30), unique=False, nullable=True)
    courses = db.Column(db.String(80), unique=False)
    university = db.Column(db.String(80), unique=False )
    number = db.Column(db.Integer,  nullable=False)
    rank = db.Column(db.String(10), nullable=False)

    def __repr__(self):
        return "<User '{}'>".format(self.username)
