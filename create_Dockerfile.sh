#!/bin/bash
set -o errexit


QUAY_URL=quay.io/coreos
GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/inspur_research


image_list=(quay.io/prometheus/alertmanager:latest
grafana/grafana:latest
quay.io/prometheus/node-exporter:latest
quay.io/prometheus/prometheus:latest
quay.io/coreos/kube-state-metrics:latest)

for imageName in ${image_list[@]};
do
  dir=`echo ${imageName} | awk -F ":" '{print $1}'|awk -F "/" '{print $NF}'`
  mkdir -p ${dir}
  cat <<EOF > ${dir}/Dockerfile
  FROM ${imageName}
  MAINTAINER wulixuan <wulixuan@inspur.com>
EOF
done

git add .
git commit -m "add k8s prometheus images..."
git push origin master
