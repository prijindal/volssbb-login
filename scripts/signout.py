from urllib import request, parse
from bs4 import BeautifulSoup
import re

HOST = 'http://phc.prontonetworks.com/cgi-bin/authlogout'

def trySignOut():
    req = request.Request(HOST)
    print("Sending Request...")
    response = request.urlopen(req)
    soup = BeautifulSoup(response, "html.parser")
    body = soup.find("body")
    print(body.get_text().strip())

trySignOut()
