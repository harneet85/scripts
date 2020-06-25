# Using future print to avoid printing parenthesis of python2 print
from __future__ import print_function
# importing standard modules/libraries
import sys,os
# appending path to include custom libraries
sys.path.append(os.path.join(os.path.dirname(os.path.realpath(__file__)),'lib'))
# IMPORT modules
import connect
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException


global hostt

hostn=len(sys.argv)
if hostn <= 2:
    print("""
    --------Error-----------
    Usage : 
        python main.py <hostIP1> ...<hostIP n> <COMMAND>

    """)
    exit()

hostl=sys.argv
ccommand=sys.argv[hostn-1]

def connec(host,user,passw):
            global hostt
            hostt=host
            user=user
            passw=passw
            global ab
            ab=connect.conn()
            ab.conexe(host,user,passw)

hostl.pop(0)
hostl.pop(-1)
for i in hostl:
    try:
        connec(i,"hardcoded_username","hardcoded_password")
        print(i, ab.command(ccommand))
    except(AuthenticationException):
        print("Authentication error ", hostt)
