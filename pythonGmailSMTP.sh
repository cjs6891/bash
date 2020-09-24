import smtplib
import datetime
from email.mime.multipart import MIMEMultipart
from email.MIMEText import MIMEText

now = datetime.datetime.now()
date = now.strftime("%Y-%m-%d %H:%M")

# creates SMTP session
s = smtplib.SMTP('smtp.gmail.com', 587)

# start TLS for security
s.starttls()

# Authentication
s.login("heinonline.org@gmail.com", "PASSWORD")

msg = MIMEMultipart()
msg['From'] = 'heinonline.org@gmail.com'
msg['To'] = 'cjs@wshein.com'
msg['Subject'] = 'Incoming Gmail: '+date+''

Body = 'Incoming Gmail: '+date+''
msg.attach(MIMEText(Body, 'plain'))

# sending the mail
s.sendmail("heinonline.org@gmail.com", "cjs@wshein.com", msg.as_string())

# terminating the session
s.quit()
