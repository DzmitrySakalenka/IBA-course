FROM cluster-base

# -- Layer Apache Spark

ARG spark_version=3.1.1
ARG hadoop_version=3.2

RUN apt-get update -y
RUN apt-get install -y curl
RUN curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz
RUN tar -xf spark.tgz
RUN mv spark-${spark_version}-bin-hadoop${hadoop_version} /usr/bin/
RUN mkdir /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}/logs
RUN rm spark.tgz

ENV SPARK_HOME /usr/bin/spark-${spark_version}-bin-hadoop${hadoop_version}
ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

# -- Runtime

WORKDIR ${SPARK_HOME}