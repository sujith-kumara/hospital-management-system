from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask.helpers import url_for
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,LoginManager,login_manager
from flask_login import login_required,current_user
from flask_mail import Mail
from sqlalchemy import text
import json

with open('config.json','r') as c:
    params = json.load(c)["params"]
# for database connection
local_server = True
app = Flask(__name__)
app.secret_key = 'sujith'


#this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'

#SMTP server settings
app.config.update(

    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail=Mail(app)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

#app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/database_table_name'
#app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hms'
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql://root:root@localhost/hms"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
import pymysql

pymysql.install_as_MySQLdb()

db = SQLAlchemy(app)

# here we create db models that is tables
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(100))
    email = db.Column(db.String(100))


class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Patients(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    disease=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    dept=db.Column(db.String(50))
    number=db.Column(db.String(50))

class Doctors(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    doctorname=db.Column(db.String(50))
    dept=db.Column(db.String(50))
class Triggr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))

# here we will pass the end points and pass the functions
@app.route("/")
def index():
    
    return render_template('index.html')


@app.route("/doctors",methods=['POST','GET'])
def doctors():
    if request.method=="POST":
        email=request.form.get('email')
        doctorname=request.form.get('doctorname')
        dept=request.form.get('dept')
        

        query=db.session.execute(text("INSERT INTO `doctors` (`email`,`doctorname`,`dept`) VALUES ('{email}','{doctorname}','{dept}')"))
        flash("Information is Stored","primary")
    return render_template('doctor.html')

@app.route("/patients",methods=['POST','GET'])
@login_required
def patients():
    doct=db.session.execute(text("SELECT * FROM `doctors`"))
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')
        subject='HOSPITAL MANAGEMENT SYSTEM'

        query=db.session.execute(text("INSERT INTO `patients` (`email`,`name`,`gender`,`slot`,`disease`,`time`,`date`,`dept`,`number`) VALUES ('{email}','{name}','{gender}','{slot}','{disease}','{time}','{date}','{dept}','{number}')"))
        mail.send_message(subject,sender=params['gmail-user'],recipients=[email],body="YOUR BOOKING IS CONFIRMED THANKS FOR CHOOSING US")
        
        
        flash("Booking is confirmed","info")




    return render_template('patient.html',doct=doct)
    # a=Test.query.all()
    # print(a)
    # return render_template('index.html')
@app.route("/bookings")
@login_required
def bookings():
    email=current_user.email
    query=db.session.execute(text("SELECT * FROM `patients` WHERE email='{email}'"))
    return render_template('bookings.html',query=query)

@app.route("/edit/<string:pid>",methods=['POST','GET'])
@login_required
def edit(pid):
    posts=Patients.query.filter_by(pid=pid).first()
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        dept=request.form.get('dept')
        number=request.form.get('number')
        db.session.execute(text("UPDATE `patients` SET `email` = '{email}', `name` = '{name}', `gender` = '{gender}', `slot` = '{slot}', `disease` = '{disease}', `time` = '{time}', `date` = '{date}', `dept` = '{dept}', `number` = '{number}' WHERE `patients`.`pid` = {pid}"))
        flash("Data update is successful","success")
        return redirect('/bookings')


    return render_template('edit.html',posts=posts)

@app.route("/delete/<string:pid>",methods=['POST','GET'])
@login_required
def delete(pid):
    db.session.execute(text("DELETE FROM `patients` WHERE `patients`.`pid`={pid}"))
    flash("Slot Deleted Successfully","danger")
    return redirect('/bookings')

    
@app.route("/signup",methods=['POST','GET'])
def signup():
    if request.method == "POST":
         username=request.form.get('username')
         email=request.form.get('email')
         password=request.form.get('password')
         user=User.query.filter_by(email=email).first()
         if user:
             flash("The email is already exists in the database","warning")
             return render_template("/signup.html")
         encpassword=generate_password_hash(password)
        #this is the first method to save the data into the database
        # new_user=db.session.execute(text("INSERT INTO `user`(`username`,`email`,`password`)VALUES ('{username}','{email}','{encpassword}' );" ))
         newuser=User(username=username,email=email,password=encpassword)
         db.session.add(newuser)
         db.session.commit()
         flash("Sign up successful please log in","success")
         return render_template('/login.html')
    return render_template('/signup.html')

@app.route("/login", methods=['POST','GET'])
def login():
    if request.method == "POST":
         
         email=request.form.get('email')
         password=request.form.get('password')
         user=User.query.filter_by(email=email).first()
         if user and check_password_hash(user.password,password):
             login_user(user)
             flash("Log in success","primary")
             return redirect(url_for('index'))
         else:
             flash("Invalid credentials","danger")
             return render_template('login.html')

    return render_template('login.html')

@app.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Log out successful","warning")
    return redirect(url_for('login'))

    #return render_template('index.html')

@app.route("/test")
def test():
    try:
       Test.query.all()
       return 'My database is connected'
    except:
       return 'My db is not connected'
@app.route("/search",methods=['POST','GET'])
@login_required
def search():
    if request.method=='POST':
        query=request.form.get('search')
        dept=Doctors.query.filter_by(dept=query).first()
        if dept:            
            flash("This department is available","info")
        else:
            flash("Department is not available","danger")
    return render_template('index.html')

@app.route("/details")
@login_required
def details():
    posts=Triggr.query.all()
    return render_template('triggers.html',posts=posts)

app.run(debug=True)



#,username=current_user.username