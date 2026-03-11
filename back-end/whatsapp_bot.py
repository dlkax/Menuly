from twilio.rest import Client
import os
from dotenv import load_dotenv

# Carregar variáveis de ambiente
load_dotenv()

# Pegar credenciais do .env
account_sid = os.getenv("TWILIO_ACCOUNT_SID")
auth_token = os.getenv("TWILIO_AUTH_TOKEN")

client = Client(account_sid, auth_token)

def process_message(data):
    """Processa mensagem do WhatsApp"""
    message = client.messages.create(
        from_=os.getenv("WHATSAPP_FROM"),
        body="Menuly funcionando 🍴",
        to=os.getenv("WHATSAPP_TO")
    )
    print(message.sid)
    return message.sid