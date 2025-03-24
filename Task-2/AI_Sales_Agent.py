from openai import OpenAI
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Initialize OpenAI client
api_key = os.getenv("OPENAI_API_KEY")
client = OpenAI(api_key=api_key)

# Initialize conversation history
conversation_history = [
    {"role": "system", "content": "You are a professional AI Sales Agent. "
     "Your goal is to assist customers with product inquiries, recommend products, and handle basic sales interactions. "
     "Use upselling and cross-selling strategies where appropriate."}
]

def sales_agent(user_input):
    """
    Handles customer interactions and keeps conversation history.
    """
    # Add user input to conversation history
    conversation_history.append({"role": "user", "content": user_input})

    # Generate AI response using the latest OpenAI API syntax
    response = client.chat.completions.create(
        model="gpt-3.5-turbo",  # Use "gpt-4" if available
        messages=conversation_history
    )

    # Get AI's reply
    ai_reply = response.choices[0].message.content

    # Add AI response to conversation history
    conversation_history.append({"role": "assistant", "content": ai_reply})

    return ai_reply

# Simulating live user interaction
print("🔹 Welcome to SmartAI Sales Assistant! Type 'exit' to end the chat.\n")

while True:
    user_input = input("🛒 Customer: ")
    
    if user_input.lower() == "exit":
        print("👋 AI Sales Agent: Thank you for visiting! Have a great day! 😊")
        break

    response = sales_agent(user_input)
    print("🤖 AI Sales Agent:", response)