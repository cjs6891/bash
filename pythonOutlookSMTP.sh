import smtplib
import datetime
from email.mime.multipart import MIMEMultipart
from email.MIMEText import MIMEText

now = datetime.datetime.now()
date = now.strftime("%Y-%m-%d %H:%M")

# creates SMTP session
s = smtplib.SMTP('smtp.office365.com', 587)

# start TLS for security
s.starttls()

# Authentication
s.login("heinonline.org@outlook.com", "PASSWORD")

msg = MIMEMultipart()
msg['From'] = 'heinonline.org@outlook.com'
msg['To'] = 'cjs@wshein.com'
msg['Subject'] = 'Incoming Outlook.com: '+date+''

Body = 'Incoming Outlook.com: '+date+''
msg.attach(MIMEText(Body, 'plain'))

# sending the mail
s.sendmail("heinonline.org@outlook.com", "cjs@wshein.com", msg.as_string())

# terminating the session
s.quit()
