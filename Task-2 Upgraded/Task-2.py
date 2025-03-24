import openai
import speech_recognition as sr
import pyttsx3
from textblob import TextBlob
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Initialize OpenAI Client with API Key
api_key = os.getenv("OPENAI_API_KEY")
client = openai.OpenAI(api_key=api_key)

# Initialize Text-to-Speech Engine
engine = pyttsx3.init()
engine.setProperty('rate', 150)  # Speed of speech

# Conversation History for Context
conversation_history = [
    {"role": "system", "content": "You are an AI Sales Agent. "
     "Assist customers with product inquiries, recommend alternatives, and handle sales discussions."}
]

# Sample Product Database
products = {
    "smartphone": {"name": "Samsung Galaxy S23 Ultra", "price": 1199, "stock": 5, "category": "smartphone"},
    "laptop": {"name": "MacBook Air M2", "price": 999, "stock": 3, "category": "laptop"},
    "headphones": {"name": "Sony WH-1000XM4", "price": 349, "stock": 10, "category": "headphones"},
    "tablet": {"name": "iPad Pro M2", "price": 1099, "stock": 2, "category": "tablet"}
}

def analyze_sentiment(text):
    """
    Detects customer sentiment to improve responses.
    """
    analysis = TextBlob(text)
    polarity = analysis.sentiment.polarity
    return "positive" if polarity > 0.2 else "negative" if polarity < -0.2 else "neutral"

def get_product_info(product_name):
    """
    Fetch product details from predefined list or use GPT for unknown products.
    """
    product = products.get(product_name.lower())

    if product:
        return f"📌 {product['name']} is available for **${product['price']}**.\n🔹 Stock Left: {product['stock']}"

    # If the product is not in the database, generate a general response using AI
    query = f"Can you provide details about {product_name} in the market?"
    ai_response = generate_ai_response(query)
    return f"🔍 I don't have that product in stock, but here's what I found:\n{ai_response}"

def recommend_product(category):
    """
    Suggests products from the database or uses AI for unknown categories.
    """
    recommendations = [p for p in products.values() if p["category"] == category]

    if recommendations:
        return "Here are some recommendations:\n" + "\n".join(
            [f"🔹 {p['name']} - **${p['price']}**" for p in recommendations])

    # AI-generated recommendations for unknown categories
    query = f"Can you suggest some good {category} options?"
    return generate_ai_response(query)

def generate_ai_response(user_query):
    """
    Uses GPT-3.5 to generate a response for unknown inquiries.
    """
    conversation_history.append({"role": "user", "content": user_query})

    try:
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=conversation_history
        )
        ai_reply = response.choices[0].message.content
        conversation_history.append({"role": "assistant", "content": ai_reply})
        return ai_reply
    except openai.OpenAIError as e:
        return f"⚠️ AI Service Error: {str(e)}"

def sales_agent(user_input):
    """
    Handles product-related inquiries, recommendations, and general AI-generated responses.
    """
    sentiment = analyze_sentiment(user_input)

    # Check for direct product inquiries
    for product_key in products:
        if product_key in user_input.lower():
            return get_product_info(product_key)

    # Check for recommendation requests
    for category in ["smartphone", "laptop", "tablet", "headphones"]:
        if category in user_input.lower():
            return recommend_product(category)

    # If the question is not product-related, use AI to generate an answer
    return generate_ai_response(user_input)

def speak_response(text):
    """
    Converts AI response to speech.
    """
    engine.say(text)
    engine.runAndWait()

def listen_speech():
    """
    Uses microphone to take voice input.
    """
    recognizer = sr.Recognizer()
    with sr.Microphone() as source:
        print("🎤 Say something...")
        recognizer.adjust_for_ambient_noise(source)
        audio = recognizer.listen(source)

    try:
        user_input = recognizer.recognize_google(audio)
        print(f"🛒 Customer (Voice Input): {user_input}")
        return user_input
    except sr.UnknownValueError:
        return "Sorry, I couldn't understand. Could you repeat that?"

# Simulating live user interaction

print("🔹 Welcome to AI Sales Assistant! Type 'voice' for voice mode or 'exit' to quit.\n")

while True:
    user_choice = input("🛒 Type your question or say 'voice' to use voice mode: ")

    if user_choice.lower() == "exit":
        print("👋 AI Sales Agent: Thank you for visiting! Have a great day! 😊")
        break

    if user_choice.lower() == "voice":
        while True:
            user_input = listen_speech()
            if user_input.lower() == "exit":
                print("👋 AI Sales Agent: Thank you for visiting! Have a great day! 😊")
                break
            response = sales_agent(user_input)
            print("🤖 AI Sales Agent:", response)
            speak_response(response)
    else:
        user_input = user_choice
        response = sales_agent(user_input)
        print("🤖 AI Sales Agent:", response)
        speak_response(response)