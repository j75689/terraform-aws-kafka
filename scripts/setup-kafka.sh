#!/bin/bash

broker_id=$1
az=$2

# add directories that support kafka
mkdir -p /opt/kafka
mkdir -p /var/run/kafka
mkdir -p /var/log/kafka

# download kafka
base_name=kafka_${scala_version}-${version}
cd /tmp
curl ${repo}/${version}/$base_name.tgz -o $base_name.tgz

# unpack the tarball
cd /opt/kafka
tar xzf /tmp/$base_name.tgz
rm /tmp/$base_name.tgz
cd $base_name

# configure the server
cat config/server.properties \
    | sed "s|broker.id=0|broker.id=$broker_id|" \
    | sed 's|log.dirs=/tmp/kafka-logs|log.dirs=/kafkadata/kafka-logs|' \
    | sed 's|num.partitions=1|num.partitions=${num_partitions}|' \
    | sed 's|log.retention.hours=168|log.retention.hours=${log_retention}|' \
    | sed 's|zookeeper.connect=localhost:2181|zookeeper.connect=${zookeeper_connect}|' \
    > /tmp/server.properties

sed -i.bak 's/KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"/KAFKA_HEAP_OPTS="-Xmx256M -Xms128M"/g' bin/kafka-server-start.sh

echo >> /tmp/server.properties
echo "# rack ID" >> /tmp/server.properties
echo "broker.rack=$az" >> /tmp/server.properties
echo " " >> /tmp/server.properties
echo "# replication factor" >> /tmp/server.properties
echo "default.replication.factor=${repl_factor}" >> /tmp/server.properties
mv /tmp/server.properties config/server.properties