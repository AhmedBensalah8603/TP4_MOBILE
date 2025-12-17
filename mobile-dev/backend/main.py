import os
import uuid
from pathlib import Path
from typing import Optional

import requests
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from pydantic import BaseModel
from dotenv import load_dotenv

load_dotenv()

PUBLIC_BASE_URL = os.environ.get('PUBLIC_BASE_URL', 'http://localhost:8000')
AZURE_TTS_KEY = os.environ.get('AZURE_TTS_KEY')
AZURE_TTS_REGION = os.environ.get('AZURE_TTS_REGION')

STORAGE_DIR = Path(__file__).parent / 'static' / 'tts'
STORAGE_DIR.mkdir(parents=True, exist_ok=True)

app = FastAPI(title="Avatar Backend Stub")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


class MessageRequest(BaseModel):
    text: str


class MessageResponse(BaseModel):
    replyText: str
    ttsUrl: Optional[str] = None


@app.post('/avatar/message', response_model=MessageResponse)
def avatar_message(req: MessageRequest):
    """Receive a message and return a replyText and optional ttsUrl.

    This is a stub. Replace the `generate_reply` function with an actual
    call to Azure OpenAI (or your preferred LLM) when ready.
    """
    try:
        reply = generate_reply(req.text)
        tts_url = None
        if AZURE_TTS_KEY and AZURE_TTS_REGION:
            # Attempt to synthesize TTS (best-effort)
            filename = synthesize_tts_to_file(reply)
            tts_url = f"{PUBLIC_BASE_URL}/tts/{filename}"
        return MessageResponse(replyText=reply, ttsUrl=tts_url)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get('/tts/{filename}')
def serve_tts(filename: str):
    file_path = STORAGE_DIR / filename
    if not file_path.exists():
        raise HTTPException(status_code=404, detail="File not found")
    return FileResponse(str(file_path), media_type='audio/mpeg')


@app.get('/health')
def health():
    """Simple health endpoint reporting configured features."""
    azure_tts = bool(os.environ.get('AZURE_TTS_KEY') and os.environ.get('AZURE_TTS_REGION'))
    azure_openai = bool(os.environ.get('AZURE_OPENAI_KEY') and os.environ.get('AZURE_OPENAI_ENDPOINT') and os.environ.get('AZURE_OPENAI_DEPLOYMENT'))
    return {"ok": True, "azure_tts": azure_tts, "azure_openai": azure_openai}


# ----- Helpers (stub implementations) -----

def generate_reply(user_text: str) -> str:
    """Generate a reply for the avatar.

    If Azure OpenAI environment variables are configured (`AZURE_OPENAI_ENDPOINT`,
    `AZURE_OPENAI_KEY`, `AZURE_OPENAI_DEPLOYMENT`) this will call the Azure OpenAI
    Chat Completions endpoint and return the assistant message. On any error or
    if the variables are not present, a deterministic fallback reply is used.
    """
    # Use Azure OpenAI if configured
    AZURE_OPENAI_ENDPOINT = os.environ.get('AZURE_OPENAI_ENDPOINT')
    AZURE_OPENAI_KEY = os.environ.get('AZURE_OPENAI_KEY')
    AZURE_OPENAI_DEPLOYMENT = os.environ.get('AZURE_OPENAI_DEPLOYMENT')

    if AZURE_OPENAI_ENDPOINT and AZURE_OPENAI_KEY and AZURE_OPENAI_DEPLOYMENT:
        try:
            url = f"{AZURE_OPENAI_ENDPOINT}/openai/deployments/{AZURE_OPENAI_DEPLOYMENT}/chat/completions?api-version=2023-10-01-preview"
            payload = {
                "messages": [
                    {"role": "system", "content": "أنت مساعد ذكي اسمه أكورا. أجب باختصار وبالعربية الفصحى، وقدم إجابات ودية ومفيدة."},
                    {"role": "user", "content": user_text},
                ],
                "max_tokens": 512,
                "temperature": 0.6,
            }
            headers = {
                "api-key": AZURE_OPENAI_KEY,
                "Content-Type": "application/json",
            }
            resp = requests.post(url, headers=headers, json=payload, timeout=30)
            resp.raise_for_status()
            data = resp.json()

            # Parse response robustly: prefer chat-style `choices[0].message.content` but support other shapes
            content = None
            if isinstance(data, dict):
                choices = data.get('choices') or []
                if choices and isinstance(choices, list):
                    choice = choices[0]
                    # Chat style
                    message = choice.get('message') if isinstance(choice, dict) else None
                    if message and isinstance(message, dict):
                        content = message.get('content')
                    # Older / different shape
                    if not content:
                        content = choice.get('text')
                # Also check for a top-level 'message' field
                if not content and data.get('message') and isinstance(data['message'], dict):
                    content = data['message'].get('content')

            if content:
                return content.strip()
        except Exception as e:
            # Log error and fall through to stub reply
            print('Azure OpenAI call failed:', e)

    # Fallback reply (deterministic Arabic template)
    return f"أكورا: لقد قلت \"{user_text}\". كيف أقدر نعاونك أكثر؟"


def synthesize_tts_to_file(text: str) -> str:
    """Synthesize speech via Azure Cognitive Services REST TTS API and save locally.

    Requires AZURE_TTS_KEY and AZURE_TTS_REGION to be set.
    """
    if not AZURE_TTS_KEY or not AZURE_TTS_REGION:
        raise RuntimeError('Azure TTS not configured')

    # Build SSML payload (Arabic voice example)
    ssml = f"""
    <speak version='1.0' xml:lang='ar-SA'>
      <voice name='ar-Saudi-BahaaNeural'>{escape_xml(text)}</voice>
    </speak>
    """

    url = f"https://{AZURE_TTS_REGION}.tts.speech.microsoft.com/cognitiveservices/v1"
    headers = {
        'Ocp-Apim-Subscription-Key': AZURE_TTS_KEY,
        'Content-Type': 'application/ssml+xml',
        'X-Microsoft-OutputFormat': 'audio-16khz-32kbitrate-mono-mp3',
        'User-Agent': 'avatar-backend-stub'
    }
    resp = requests.post(url, data=ssml.encode('utf-8'), headers=headers, timeout=30)
    if resp.status_code != 200:
        raise RuntimeError(f'Azure TTS failed: {resp.status_code} {resp.text}')

    filename = f"{uuid.uuid4().hex}.mp3"
    file_path = STORAGE_DIR / filename
    with open(file_path, 'wb') as f:
        f.write(resp.content)

    return filename


def escape_xml(text: str) -> str:
    return (text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;').replace("'", '&apos;'))
