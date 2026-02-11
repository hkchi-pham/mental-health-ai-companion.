from openai import OpenAI

client = OpenAI(api_key="secret key")

def get_chatbot_response(role, user_input):
    
    personas = {
        "listener": "Bạn là một người lắng nghe, luôn đồng cảm, không phán xét, chỉ phản hồi nhẹ nhàng để người dùng cảm thấy được chia sẻ.",
        "peer": "Bạn là một người bạn cùng tuổi, nói chuyện gần gũi, thoải mái, dùng từ ngữ thân thiện như bạn bè.",
        "mentor": "Bạn là một mentor, luôn cho lời khuyên, hướng dẫn có ích và khích lệ người dùng phát triển bản thân."
    }

    system_prompt = personas.get(role, "Bạn là một trợ lý AI thân thiện.")

    response = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_input}
        ]
    )

    return response.choices[0].message.content

print("🤖 Chatbot đa nhân cách (listener, peer, mentor). Gõ 'exit' để thoát.")

while True:
    persona = input("Chọn nhân cách (listener/peer/mentor): ")
    if persona == "exit":
        break

    user_message = input("Bạn: ")
    if user_message == "exit":
        break

    reply = get_chatbot_response(persona, user_message)
    print(f"{persona.capitalize()} AI:", reply)