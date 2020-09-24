import smtplib
import datetime
from email.mime.multipart import MIMEMultipart
from email.MIMEText import MIMEText

now = datetime.datetime.now()
date = now.strftime("%Y-%m-%d %H:%M")

# Creates SMTP Session
s = smtplib.SMTP('smtp.mail.yahoo.com', 587)

# Start TLS for Security
s.starttls()

# Authentication
s.login("heinonline.org@yahoo.com", "PASSWORD")

msg = MIMEMultipart()
msg['From'] = 'heinonline.org@yahoo.com'
msg['To'] = 'cjs@wshein.com'
msg['Subject'] = 'Incoming Yahoo: '+date+''

Body = 'Incoming Yahoo: '+date+''
msg.attach(MIMEText(Body, 'plain'))

# Sending The Mail
s.sendmail("heinonline.org@yahoo.com", "cjs@wshein.com", msg.as_string())

# Terminating The Session
s.quit()
