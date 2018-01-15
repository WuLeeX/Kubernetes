#!/bin/bash
set -o errexit


QUAY_URL=quay.io/coreos
GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-hangzhou.aliyuncs.com/inspur_research


image_list=(quay.io/prometheus/prometheus:v2.0.0
quay.io/prometheus/node_exporter:v0.15.2
quay.io/prometheus/alertmanager:v0.12.0
grafana/grafana:4.6.3
quay.io/coreos/kube-state-metrics:v1.1.0)

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
git commit -m "fix grafana version from v4.6.3 to 4.6.3 ..."
git push origin master
