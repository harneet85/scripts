import paramiko
import binascii

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

class conn:

    
    def transfer(self,sfile,dfile):
        sftp = ssh.open_sftp()
        sftp.put(sfile,dfile)
        print("transfer done")
        
    def recieve(self,sfile,dfile):
        sftp = ssh.open_sftp()
        sftp.get(sfile,dfile)
        print("transfer done")
        
    def conexe(self,host,user,passw):
        ssh.connect(hostname=host, username=user, password=passw)
    
    def command(self,com):
        self.com = com
        (stdin, stdout, stderr) = ssh.exec_command(com)
        str1 = ''.join(stdout)
#str2 = ''.join(stderr)
#        for line in stdout.readlines():
#            print(line)
#        ssh.close()
        #print(str1)
        #print(type(str1))
#        for lines in stdout.readlines():
#                print(lines)
        return str1
    
    def hccommand(self,com):
        self.com = com
        (stdin, stdout, stderr) = ssh.exec_command(com)
#        str1 = ''.join(stdout)
#str2 = ''.join(stderr)
#        for line in stdout.readlines():
 #           print(line)
#        ssh.close()
        #print(str1)
        #print(type(str1))
#        for lines in stdout.readlines():
#                print(lines)
        return stdout
        
#a=conn()
#a.conexe("127.0.0.1","harneesi","85@chalan")
#a.command("sudo -l")
#a.transfer("/home/harneesi/me.py","/tmp/me.py")