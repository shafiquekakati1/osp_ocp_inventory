
import sys
sys.path.append("/home/cloud-user/.local/lib/python3.9/site-packages")
import subprocess


def login_ocp_prod():
    servername="https://api.rhocp.prod-cloud1.itcloud.local.vodafone.om:6443"
    commands = [ "oc login -u kshitij.tyagi -p '\''RBJLFG@u4Z'\'' --server=https://api.rhocp.prod-cloud1.itcloud.local.vodafone.om:6443" ]
    for x in range(len(commands)):
        r = subprocess.Popen(commands[x], shell=True, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
        print(r)

if __name__ == '__main__':
    login_ocp_prod()

