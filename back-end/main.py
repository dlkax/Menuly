from flask import Flask, request
from twilio.twiml.messaging_response import MessagingResponse

app = Flask(__name__)

@app.route("/webhook", methods=["POST"])
def webhook():

    incoming_msg = request.form.get("Body").lower()

    resp = MessagingResponse()
    msg = resp.message()

    if "menu" in incoming_msg:

        resposta = """
🍔 *Menu*

1 - X Burger
2 - Pizza
3 - Batata

Digite o número do pedido.
"""

    elif incoming_msg == "1":
        resposta = "🍔 Pedido de X Burger recebido!"

    elif incoming_msg == "2":
        resposta = "🍕 Pedido de Pizza recebido!"

    else:
        resposta = "Digite *menu* para ver o cardápio."

    msg.body(resposta)

    return str(resp)

if __name__ == "__main__":
    app.run(port=5000)