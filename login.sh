DATA="userid=14BCE0607&password=`cat ~/projects/volsbb/Password.txt`&serviceName=ProntoAuthentication&Submit22=Login"

curl -X POST http://phc.prontonetworks.com/cgi-bin/authlogin?URI=http://google.co.in/robots.txt --data $DATA

