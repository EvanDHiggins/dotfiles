import random
import subprocess as s

sentences = [
        "Hey when you have a sec could you give me a hand?",
        "I have a few questions when you have a minute.",
        "Would you mind helping me out with something?"
            ]

q = sentences[random.randint(0, len(sentences) - 1)]

s.call(['rocketChatMessage', '#ehigginstest', q])
