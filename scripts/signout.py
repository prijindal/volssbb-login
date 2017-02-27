import urllib2
from bs4 import BeautifulSoup
import re

HOST = 'http://phc.prontonetworks.com/cgi-bin/authlogout'

def trySignOut():
    req = urllib2.Request(HOST)
    print("Sending Request...")
    response = urllib2.urlopen(req)
    soup = BeautifulSoup(response, "html.parser")
    body = soup.find("body")
    print(body.get_text().strip())

trySignOut()
