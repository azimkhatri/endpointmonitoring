#!/usr/bin/python3

import socket
import time

def isOpen(host, port, timeout):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(timeout)
        try:
                s.connect((host, int(port)))
                s.shutdown(socket.SHUT_RDWR)
                return True
        except:
                return False
        finally:
                s.close()

def checkHost(host,port,retry,delay,timeout):
        ipup = False
        for i in range(retry):
                if isOpen(host, port, timeout):
                        ipup = True
                        break
                else:
                        time.sleep(delay)
        return ipup

try:
    file1 = open('connection.txt','r')
    lines = file1.readlines()
finally:
    file1.close()

for line in lines:
    host,port,retry,delay,timeout = line.strip().split(",")
    print (host, "||" , port , "||" , retry, "||" , delay, "||" , timeout)
    if checkHost(host, int(port), int(retry), int(delay), int(timeout)):
        print(host + " is UP")
    else:
        print(host + " not reachable" )
