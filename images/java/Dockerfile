FROM openjdk:8
ADD images/java/spark-2.4.5-bin-hadoop2.7.tgz /spark
COPY images/java/hosts /etc/hostsc
COPY images/java/java.sh /sbin/init
COPY images/java/pi.py /pi.py
COPY out/fork /fork
COPY out/reset /reset
COPY out/done /done
