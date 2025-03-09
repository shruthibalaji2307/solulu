from flask import Flask, request, jsonify
from groq import Groq
import base64

app = Flask(__name__)

def verify_image(task_description, image_data):
    client = Groq()
    
    # Remove the data:image/jpeg;base64, prefix if present
    if "base64," in image_data:
        image_data = image_data.split("base64,")[1]
    
    prompt = f"Is this an image of people '{task_description}'? Please answer with just 'yes' or 'no'."
    
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
                                "url": f"data:image/jpeg;base64,{image_data}"
                            }
                        }
                    ]
                }
            ],
            temperature=0.1,  # Lower temperature for more consistent yes/no answers
            max_completion_tokens=10,
            top_p=1,
            stream=False,
            stop=None,
        )
        
        answer = completion.choices[0].message.content.strip().lower()
        return answer == "yes"
    except Exception as e:
        print(f"Error in verification: {e}")
        return False

@app.route('/verify', methods=['POST'])
def verify():
    try:
        data = request.json
        task = data['task']
        image_data = data['image_url']
        
        result = verify_image(task, image_data)
        return jsonify({'result': result})
    except Exception as e:
        return jsonify({'result': False, 'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)