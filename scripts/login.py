import urllib2
from bs4 import BeautifulSoup
import re

HOST = "http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://google.co.in/robots.txt"

def tryLogin(regno, password):
	data = 'userid=%s&password=%s&serviceName=ProntoAuthentication&Submit22=Login' % (regno, password)
	req = urllib2.Request(HOST, data)
	print("Sending Request...")
	response = urllib2.urlopen(req)
	soup = BeautifulSoup(response, "html.parser")
	body = soup.find("body")
	if not body:
		print("Already Logged In")
		return
	form = body.find("form")
	response = form.table.find_all("tr")[2].find("td").get_text().strip()
	if not response:
		print("Logged In")
	else:
		print(response)

password = open('/home/prijindal/projects/volsbb/Password.txt', 'r').read().strip()
tryLogin("14BCE0607", password)
