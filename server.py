from flask import Flask, request, jsonify
from groq import Groq
import base64
import os
from difflib import SequenceMatcher

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # Set max size to 16MB

def similar(a, b):
    # Calculate similarity ratio between two strings
    return SequenceMatcher(None, a.lower(), b.lower()).ratio()

def verify_image(task_description, image_data):
    # Get API key from environment variable
    api_key = os.getenv('GROQ_API_KEY')
    if not api_key:
        raise Exception("GROQ_API_KEY environment variable not set")
        
    client = Groq(api_key=api_key)
    
    # Convert binary image data to base64
    image_base64 = base64.b64encode(image_data).decode('utf-8')
    
    print(f"Task description: {task_description}")
    print(f"Base64 length: {len(image_base64)}")
    
    # prompt = f"Is this an image of '{task_description}'? Please answer with just 'yes' or 'no'."
    prompt = f"Describe this image"
    
    try:
        completion = client.chat.completions.create(
            model="llama-3.2-11b-vision-preview",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": prompt
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": f"data:image/jpeg;base64,{image_base64}"
                            }
                        }
                    ]
                }
            ],
            temperature=0.1,
            max_completion_tokens=10,
            top_p=1,
            stream=False,
            stop=None,
        )
        
        answer = completion.choices[0].message.content.strip().lower()
        print(f"Groq response: {answer}")
        # if answer matches task description to 50% or more, return true

        similarity = similar(answer, task_description)
        print(f"Similarity score: {similarity}")
        
        # Return true if similarity is 50% or more
        return similarity >= 0.2
    except Exception as e:
        print(f"Error in verification: {str(e)}")
        return False

@app.route('/verify', methods=['POST'])
def verify():
    try:
        task = request.headers.get('Task')
        image_data = request.get_data()
        print(f"Task: {task}")
        print(f"Image data size: {len(image_data)} bytes")
        
        result = verify_image(task, image_data)
        return jsonify({'result': result})
    except Exception as e:
        print(f"Error in /verify endpoint: {str(e)}")
        return jsonify({'result': False, 'error': str(e)}), 500

if __name__ == '__main__':
    if not os.getenv('GROQ_API_KEY'):
        print("Warning: GROQ_API_KEY environment variable not set!")
    app.run(debug=True)