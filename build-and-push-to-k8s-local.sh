#!/usr/bin/env bash

docker build -t dev/rawfile .

docker save dev/rawfile:latest -o /tmp/rawfile-docker-image.tar

for ip in $(echo -e "192.168.56.101\n192.168.56.111\n192.168.56.112") ; do
  echo "${ip}" ;
  scp -i ~/.ssh/id_rsa /tmp/rawfile-docker-image.tar "vagrant@${ip}:~" ;
  ssh -i ~/.ssh/id_rsa -t "vagrant@${ip}" "sudo ctr -n=k8s.io images import rawfile-docker-image.tar ; sudo crictl images | grep rawfile" ;
done
