import sys
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


def main(dict):
    email = "email@gmail.com"
    password = "password"
    send_to_email = "************@sms.mts.by"
    subject = f"The official rate of the {dict['Cur_Name']}"
    message = f"{dict['Cur_Scale']} {dict['Cur_Abbreviation']} = {dict['Cur_OfficialRate']} BYN\nSincerely, Dmitry"
    
    context = ssl.create_default_context()
    
    msg = MIMEMultipart('alternative')
    msg['From'] = email
    msg['To'] = send_to_email
    msg['Subject'] = subject
    msg.attach(MIMEText(message, 'plain'))
    
    try:
        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.ehlo()
        server.starttls(context=context)
        server.login(email, password)
        server.sendmail(email, send_to_email, msg.as_string())
    except Exception as e:
        print(e)
    finally:
        server.quit()
    
    return {"Status": "Comlete"}
