import hashlib
import os
passwd = os.getenv("INITAL_PASS")
encrypted = hashlib.new('md4', passwd.encode('utf-16le')).hexdigest()
print (encrypted)


