#!/usr/bin/env bash

docker build -t dev/rawfile .

docker save dev/rawfile:latest -o rawfile-docker-image.tar

while read -u9 l ; do
  ip=$(echo "${l}" | tr -d '"' | awk '{print $2}') ;
  echo "${ip}" ;
  scp rawfile-docker-image.tar "ubuntu@${ip}:~" ;
  ssh -t "ubuntu@${ip}" "sudo ctr -n=k8s.io images import rawfile-docker-image.tar ; sudo crictl images | grep rawfile" ;
done 9< <(multipass list --format json | jq '.list[] | "\(.name): \(.ipv4[0])"')
