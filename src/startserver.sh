#!/bin/sh

set -euxo pipefail

HOSTNAME=${1:?The first argument to this script should be the local hostname.}

# Read the root pass out
root_pass=$(</wehe/ssh/root_pass.txt)

# First, generate the certificates from certificate authority.
python certGenerator.py \
   --destination=/wehe/ssl/ \
   --domain_name=${HOSTNAME} \
   --root_key=/wehe/ssl/ca.key \
   --root_cert=/wehe/ssl/ca.crt \
   --root_pass=$root_pass

# The replay server
python replay_server.py \
  --ConfigFile=configs.cfg \
  --original_ports=True \
  --certs-folders=/wehe/ssl/ \
  &

# Wait for both servers to terminate.
wait
