#!/bin/bash

# Change to the directory that this script is in
cd `dirname $0`

  # capture the port numbers to use
  HTTP_PORT=$1
  HTTPS_PORT=$2

  echo "HTTP_PORT: $HTTP_PORT, HTTPS_PORT: $HTTPS_PORT";

# echo out the config to the config file - put in the correct port numbers
echo "
Daemon   0
LogLevel 2

ListenHTTPS
    Address 0.0.0.0
    Port    ${HTTPS_PORT}
    Cert    \"server_dev.pem\"

    AddHeader \"X-Secure-Connection: true\"

    Service
        BackEnd
            Address 127.0.0.1
            Port    $HTTP_PORT
        End
    End
End

" > pound_dev.cfg

  # create the certificate if needed
  if test ! -e server_dev.pem; then
  echo " ---- creating the required certificate: server_dev.pem ---- ";

openssl                              \
  req                              \
  -new                             \
  -x509                            \
  -days 365                        \
  -nodes                           \
  -out server_dev.pem              \
  -keyout server_dev.pem

  echo;
echo "---- certificate created ----- ";
echo;
fi;

# start pound
/usr/sbin/pound -v -f pound_dev.cfg -p pound_dev.pid
