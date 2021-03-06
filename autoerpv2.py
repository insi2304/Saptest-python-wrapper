from subprocess import *
import shlex
import argparse
import sys
import os

try:
	parser = argparse.ArgumentParser(description='SAP and Peoplesoft Auditor.')
	parser.add_argument('-s','--sap',help='for sap application',action='store_true')
	parser.add_argument('-p','--peoplesoft',help='for peoplesoft application',action='store_true')
	parser.add_argument('-H','--host',help='hostname or IP',required=True)
	parser.add_argument('-P','--port',help='port',required=True)
	parser.add_argument('-S','--ssl', help='1 for ssl, 0 for cleartext',required=True)
	parser.add_argument('-u','--user',help='sap username',default='SAP*')
	parser.add_argument('-C','--password',help='sap password',default='PASS')
	parser.add_argument('-c','--client',help='client/mandat (SAP only)',default='000')
	parser.add_argument('-d','--debug',help='Show Debug Information',action='store_true')
	parser.add_argument('-w','--site',help='a name of portal site (PeopleSoft only)')
	parser.add_argument('-D','--dos',help='include DOS attacks',required=True,type=int)
	#parser.add_argument('-m',help='module id')
	args = parser.parse_args()
except SystemExit:
    exc = sys.exc_info()[1]
    print(exc)
	
	
if args.sap and args.dos == 0:
	j = 50
	for i in range(1,j):
		filename = os.getcwd() + '\\' + args.host + '\\SAP_' + args.host + str(i) + '.txt'
		if not os.path.exists(os.path.dirname(filename)):
			try:
				os.makedirs(os.path.dirname(filename))
			except OSError as exc: # Guard against race condition
				if exc.errno != errno.EEXIST:
					raise
		with open(filename,'w') as fd:
			command_line = 'perl black.pl -sap -H ' + args.host + ' -P ' + args.port + ' -ssl ' + args.ssl + ' -u ' + args.user + ' -p ' + args.password +' -c 000 -d -m '+str(i)
			print 'Running ' + command_line
			spltargs = shlex.split(command_line)
			if(Popen(spltargs,stdout=fd,stderr=fd).poll()):
				continue

elif args.sap and args.dos == 1:
	j = 56
	for i in range(1,j):
		filename = os.getcwd() + '\\' + args.host + '\\SAP_' + args.host + str(i) + '.txt'
		if not os.path.exists(os.path.dirname(filename)):
			try:
				os.makedirs(os.path.dirname(filename))
			except OSError as exc: # Guard against race condition
				if exc.errno != errno.EEXIST:
					raise
		with open(filename,'w') as fd:
			command_line = 'perl black.pl -sap -H ' + args.host + ' -P ' + args.port + ' -ssl ' + args.ssl + ' -u ' + args.user + ' -p ' + args.password +' -c 000 -d -m '+str(i)
			print 'Running ' + command_line
			spltargs = shlex.split(command_line)
			if(Popen(spltargs,stdout=fd,stderr=fd).poll()):
				continue
				
elif args.peoplesoft and args.dos == 0:
	j = 13
	for i in range(1,j):
		filename = os.getcwd() + '\\' + args.host + '\\PeopleSoft_' + args.host + str(i) + '.txt'
		if not os.path.exists(os.path.dirname(filename)):
			try:
				os.makedirs(os.path.dirname(filename))
			except OSError as exc: # Guard against race condition
				if exc.errno != errno.EEXIST:
					raise
		with open(filename,'w') as fd:
			command_line = 'perl black.pl -ps -H ' + args.host + ' -P ' + args.port +' -ssl ' + args.ssl + ' -s ' + args.site + ' -m ' + str(i)
			print 'Running ' + command_line
			spltargs = shlex.split(command_line)
			if(Popen(spltargs,stdout=fd,stderr=fd).poll()):
				continue

elif args.peoplesoft and args.dos == 1:
	j = 15
	for i in range(1,j):
		filename = os.getcwd() + '\\' + args.host + '\\PeopleSoft_' + args.host + str(i) + '.txt'
		if not os.path.exists(os.path.dirname(filename)):
			try:
				os.makedirs(os.path.dirname(filename))
			except OSError as exc: # Guard against race condition
				if exc.errno != errno.EEXIST:
					raise
		with open(filename,'w') as fd:
			command_line = 'perl black.pl -ps -H ' + args.host + ' -P ' + args.port +' -ssl ' + args.ssl + ' -s ' + args.site + ' -m ' + str(i)
			print 'Running ' + command_line
			spltargs = shlex.split(command_line)
			if(Popen(spltargs,stdout=fd,stderr=fd).poll()):
				continue
				
else:
	print "you provided an invalid option"
	command_line = 'perl black.pl -h'
	args = shlex.split(command_line)
	Popen(args).poll()
	
