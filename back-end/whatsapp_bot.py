from twilio.rest import Client

account_sid = "ACfc6a188da79f2eee1bc809717450dda4"
auth_token = "69a93ed70d86916e10b7194725d2b948"

client = Client(account_sid, auth_token)

message = client.messages.create(
    from_="whatsapp:+14155238886",
    body="Menuly funcionando 🚀",
    to="whatsapp:+5511948378344"
)

print(message.sid)