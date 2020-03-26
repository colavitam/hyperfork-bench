FROM alpine:3.7
RUN apk add build-base
RUN apk add git
RUN rm /sbin/init
RUN git clone https://github.com/colavitam/sampling.git /prog
COPY images/gcc/gcc.sh /sbin/init
COPY out/fork /fork
COPY out/reset /reset
COPY out/done /done

