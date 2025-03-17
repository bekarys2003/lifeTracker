from celery import shared_task
from twilio.rest import Client
from decouple import config

@shared_task
def send_schedule_notification(phone_number, message):
    account_sid = config("TWILIO_ACCOUNT_SID")
    auth_token = config("TWILIO_AUTH_TOKEN")
    client = Client(account_sid, auth_token)

    message = client.messages.create(
        body=message,
        from_="+17655488427",  # Your Twilio number
        to=phone_number,
    )
    return message.sid