#!/usr/bin/python
# author: Pavel Studenik <pstudeni@redhat.com>

import xmlrpclib
import sys


class Spacewalk:

    def __init__(self, login, password, server):
        self.client = xmlrpclib.Server("http://%s/rpc/api" % server, verbose=0)
        self.key = self.client.auth.login(login, password)
        self.exitcode = 0

    def get_system_list(self):
        list = self.client.system.listSystems(self.key)
        return [it["id"] for it in list]

    def __del__(self):
        self.client.auth.logout(self.key)

    def set_entitlement(self, system_id):
        if not int(system_id) in self.get_system_list():
            self.exitcode = 2
            return
        labels = ['enterprise_entitled', 'provisioning_entitled']
        self.client.system.addEntitlements(self.key, system_id, labels)

    def get_exitcode(self):
        return self.exitcode

if __name__ == "__main__":
    SATELLITE_LOGIN = sys.argv[1]
    SATELLITE_PASSWORD = sys.argv[2]
    SATELLITE_URL = sys.argv[3]
    SYSTEM_ID = int(sys.argv[4])

    sw = Spacewalk(SATELLITE_LOGIN, SATELLITE_PASSWORD, SATELLITE_URL)
    sw.set_entitlement(SYSTEM_ID)
    exitcode = sw.get_exitcode()

    del sw
    sys.exit(exitcode)
