#! /usr/bin/env python

from ostadyaab import app, db
from ostadyaab.models import User
from flask_script import Manager, prompt_bool
from ostadyaab.models import Teachers

manager = Manager(app)
teachers = Teachers()
@manager.command
def initdb():
    db.create_all()
    db.session.add(User(age="20", konkoorRank="636", madrak="فوق دیپلم", reshte="مهندسی کامپیوتر" , \
                        username="shariat", email="arian@yahoo.com", name="آرین" ,surname="شریعت", \
                   courses="ریاضی", university="علم و صنعت ایران", \
                   number='09128219726', rank='10,10'))
   # teachers.ad("shariat")

    db.session.add(User(age="60", konkoorRank="200", madrak="دکترا", reshte="مهندسی شیمی" , \
                        username="sharifi", email="sharifi@yahoo.com", name="دکتر" ,surname="شریفی", \
                   courses="شیمی", university="تهران", \
                   number='09121234567', rank='5,10'))

    db.session.add(User(age="21", konkoorRank="736", madrak="فوق دیپلم", reshte="مهندسی کامپیوتر" , \
                        username="ali", email="alierfanian@yahoo.com", name="علی" ,surname="عرفانیان", \
                   courses="ریاضی-فیزیک", university="تهران", \
                   number='09384665912', rank='10,10'))

    db.session.add(User(age="19", konkoorRank="676", madrak="فوق دیپلم", reshte="مهندسی کامپیوتر" , \
                        username="qazale", email="qazale@yahoo.com", name="غزاله" ,surname="بختیاری", \
                   courses="شیمی", university="علم و صنعت ایران", \
                   number='09128212226', rank='10,10'))

    db.session.add(User(age="19", konkoorRank="716", madrak="فوق دیپلم", reshte="مهندسی کامپیوتر" , \
                        username="Mahsa", email="mahsa@yahoo.com", name="مهسا" ,surname="انوریان", \
                   courses="عربی", university="علم و صنعت ایران", \
                   number='09128349726', rank='10,10'))
    db.session.add(User(age="60", konkoorRank="100016", madrak="فوق دیپلم", reshte="مهندسی کامپیوتر" , \
                        username="Zahra", email="zahra@yahoo.com", name="زهرا" ,surname="بشیر", \
                   courses="هیچی", university="علم و صنعت ایران", \
                   number='09121349726', rank='10,10'))

   # teachers.ad("sharifi")
    db.session.commit()
    print ('Initialized the database')

@manager.command
def update():
    teachers.ad(User.query.filter_by(username='shariat').first())
    print('Teacher Added')
    teachers.ad(User.query.filter_by(username='sharifi').first())
    print('Teacher Added')


@manager.command
def dropdb():
    if prompt_bool(
        "Are you sure you want to lose all your data"):
        db.drop_all()
        print ('Dropped the database')

if __name__ == '__main__':
    manager.run()
