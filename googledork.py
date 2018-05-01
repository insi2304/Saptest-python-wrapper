import requests ,re
from bs4 import BeautifulSoup
#url
url = 'https://www.google.com/search'

q = 'apache'
#Parameters in payload
#payload = { 'q' : '/irj/portal', 'start' : '0' }
payload = '{ \'q\' : \''+ q +'\', \'start\' : \'0\' }'
print payload

#Setting User-Agent
my_headers = { 'User-Agent' : 'Mozilla/11.0' }

#Getting the response in an Object r
r = requests.get( url, params = payload, headers = my_headers )
#print r.text.encode('utf-8')

#Read the reponse with utf-8 encoding
soup = BeautifulSoup(r.text, 'html.parser')

#Getting all h3 tags with class 'r'
h3tags = soup.find_all( 'h3', class_='r' )
print h3tags
 
#Finding URL inside each h3 tag using regex.
#If found : Print, else : Ignore the exception
for h3 in h3tags:
    try:
        print( re.search('url\?q=(.+?)\&sa', h3.a['href']).group(1) )
    except:
        continue