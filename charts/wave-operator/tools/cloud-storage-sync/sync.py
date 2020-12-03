#!/usr/bin/env python3

import sys
import os
import pyinotify
import requests
import time

sourceDir = sys.argv[1]
targetDir = sys.argv[2]

frequency = "forever"
if len(sys.argv) > 3:
    frequency = sys.argv[3]

print("running sync on {} -> {} {}\n".format(sourceDir, targetDir, frequency), flush=True)


class CredentialProvider:
    # use python requests to get credentials from the v1 IMDS, because rclone
    # uses the aws-sdk-go, and has very slow responses
    # see https://github.com/aws/aws-sdk-go/issues/2972

    def __init__(self):
        self.cred_url = "http://169.254.169.254/latest/meta-data/iam/security-credentials/"
        r = requests.get(self.cred_url)
        self.instance_role = r.text

    def load(self):
        r = requests.get(self.cred_url + self.instance_role)
        return r.json()


regionArg = ""
region = os.getenv("S3_REGION")
if region is not None:
    regionArg = """--s3-region {}""".format(region)

provider = CredentialProvider()


# use "copy", not "sync": don't delete files in target directory
def sync(ev):
    c = provider.load()
    credentialArg = """--s3-access-key-id {} --s3-secret-access-key {} --s3-session-token {}""".format(c["AccessKeyId"], c["SecretAccessKey"], c["Token"])
    print("""rclone {} copy {} {} """.format(regionArg, sourceDir, targetDir), flush=True)
    os.system("""rclone {} {} copy {} {} """.format(regionArg, credentialArg, sourceDir, targetDir))


if frequency == "forever":
    manager = pyinotify.WatchManager()
    mask = pyinotify.IN_DELETE | pyinotify.IN_MODIFY | pyinotify.IN_CREATE
    manager.add_watch(sourceDir, rec=True, mask=mask)
    notifier = pyinotify.Notifier(manager, sync)
    notifier.loop()
else:
    time.sleep(1)
    sync(None)
