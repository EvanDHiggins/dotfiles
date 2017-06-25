import requests
import getpass
import sys
import pickle
import os
import random

API_URL = 'https://rocket.belvederetrading.com/api/v1'
PICKLE_PATH = 'auth_token.pk'

def login_and_send(channel, msg):
    if not os.path.isfile(PICKLE_PATH) or not valid_auth(*get_cached_token()):
        cache_token(*login())
    token, uid = get_cached_token()

    resp = send_message(channel, msg, token=token, uid=uid)

def valid_auth(token, uid):
    resp = requests.get(API_URL+'/me',
                        headers=make_auth_header(token, uid))
    js = resp.json()
    return 'success' in js and js['success']
    
def make_auth_header(token, uid):
    return { "X-Auth-Token" : token, "X-User-Id" : uid }


def send_message(channel, msg, *, token, uid):
    js = { "channel" : channel, "text" : msg }
    return requests.post(API_URL+'/chat.postMessage', 
                         headers=make_auth_header(token, uid),
                         json=js)

def cache_token(token, uid):
    with open(PICKLE_PATH, 'wb') as fi:
        pickle.dump((token, uid), fi)

def get_cached_token():
    with open(PICKLE_PATH, 'rb') as fi:
        return pickle.load(fi)


# Returns auth_token, id_token
def login():
    passwd = getpass.getpass("Password: ")
    args = { "username" : "ehiggins", "password" : passwd }
    resp = requests.post(API_URL + '/login', data=args)
    json = resp.json()
    if json['status'] != 'success':
        print("Something went wrong.")
        print(resp.url)
        print(json)
        sys.exit(1)
    return json['data']['authToken'], json['data']['userId']

if __name__ == "__main__":
    sentences = [
                "Hey when you have a sec could you give me a hand?",
                "I have a few questions when you have a minute.",
                "Would you mind helping me out with something?"
                ]
    if len(sys.argv) != 1:
        print("Call with 'python3 %'")
        sys.exit(1)
    q = sentences[random.randint(0, len(sentences) - 1)]
    login_and_send('#ehigginstest', q)

