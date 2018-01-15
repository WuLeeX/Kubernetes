#!/bin/bash
set -o errexit


QUAY_URL=quay.io/prometheus
COREOS_URL=quay.io/coreos
GRAFANA_URL=grafana
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/inspur_research


image_list=(alertmanager:latest
grafana:latest
node-exporter:latest
prometheus:latest
kube-state-metrics:latest)

for imageName in ${image_list[@]};
do
  docker pull ${ALIYUN_URL}/$imageName
  if [[ ${imageName} =~ "grafana" ]]; then
    docker tag ${ALIYUN_URL}/$imageName ${GRAFANA_URL}/$imageName
  elif [[ ${imageName} =~ "kube" ]]; then
    docker tag ${ALIYUN_URL}/$imageName ${COREOS_URL}/$imageName
  else
    docker tag ${ALIYUN_URL}/$imageName ${QUAY_URL}/$imageName
  fi
  docker rmi ${ALIYUN_URL}/$imageName
done
