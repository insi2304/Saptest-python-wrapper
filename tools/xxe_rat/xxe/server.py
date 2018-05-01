#!/usr/bin/env python
# -*- encoding: utf-8 -*-
#
# author: @090h
from threading import Thread
import socket
from datetime import datetime


class XXEServer(Thread):

    def __init__(self, host='0.0.0.0', port=9090,):
        Thread.__init__(self)
        self.sa = (host, port)

    def run(self):
        print("Starting file recive server @ %s:%i" % self.sa)
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.sock.bind(self.sa)
        self.sock.listen(5)

        while True:
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


if __name__ == '__main__':
    xxe = XXEServer()
    xxe.start()
    raw_input("Press any key to exit")
    #may be add better thead closing ?
    exit()