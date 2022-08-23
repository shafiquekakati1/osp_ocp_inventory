#!/bin/sh
export PATH="/home/cloud-user/.local/bin:/home/cloud-user/bin:/bin:/home/cloud-user/.local/bin:/home/cloud-user/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
ROOT="/home/cloud-user/ENRICHMENT/INVENTORY/"
rm $ROOT/INPUT/*

source $ROOT/script/.openstacknonprodrc.sh
openstack host list -f csv > $ROOT/INPUT/hostnonprod.csv

for i in `cat $ROOT/INPUT/hostnonprod.csv|grep -v Service |awk -F',' '{print $1}'|sed s/\"//g`
do
openstack server list --all-projects -f csv --host ${i} > $ROOT/INPUT/server_nonprod_${i}
done

source $ROOT/script/.openstackprodrc.sh
openstack host list -f csv > $ROOT/INPUT/hostprod.csv

for i in `cat $ROOT/INPUT/hostprod.csv|grep -v Service |awk -F',' '{print $1}'|sed s/\"//g`
do
openstack server list --all-projects -f csv --host ${i} > $ROOT/INPUT/server_prod_${i}
done


oc login -u kshitij.tyagi -p 'RBJLFG@u4Z' --server=https://api.rhocp.non-prod-cloud1.itcloud.local.vodafone.om:6443
oc describe node -A > $ROOT/INPUT/OC_NONPROD

oc login -u kshitij.tyagi -p 'RBJLFG@u4Z' --server=https://api.rhocp.prod-cloud1.itcloud.local.vodafone.om:6443
oc describe node -A > $ROOT/INPUT/OC_PROD

$ROOT/script/Format.py
dt=`date +'%d%m%Y-%H%M%S'`
cp $ROOT/OUTPUT/inventory.xlsx $ROOT/OUTPUT/inventory_$dt.xlsx

