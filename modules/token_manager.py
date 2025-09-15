import json
import os

TOKEN_FILE = "token_store.json"

def load_tokens():
    if not os.path.exists(TOKEN_FILE):
        return {}
    with open(TOKEN_FILE, "r") as f:
        return json.load(f)

def save_tokens(tokens):
    with open(TOKEN_FILE, "w") as f:
        json.dump(tokens, f, indent=2)

def add_token(service, token):
    tokens = load_tokens()
    if service not in tokens:
        tokens[service] = []
    tokens[service].append(token)
    save_tokens(tokens)

def get_next_valid_token(service, expired_token=None):
    tokens = load_tokens().get(service, [])
    if expired_token and expired_token in tokens:
        idx = tokens.index(expired_token)
        if idx + 1 < len(tokens):
            return tokens[idx + 1]
    return tokens[0] if tokens else None
