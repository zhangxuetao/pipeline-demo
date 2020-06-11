FROM openjdk:8-jdk-alpine

#构建参数
ARG JAR_FILE
ARG WORK_PATH="/opt/demo"
# 环境变量
ENV JAVA_OPTS="" \
    JAR_FILE=${JAR_FILE}

#设置时区
RUN apk update && apk add ca-certificates && \
    apk add tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    mkdir -p /data/wanshun/config/apollo/wsShunFengChe && \
    echo -e 'env=dev\ndev.meta=http://172.18.6.1:6000\n' > /data/wanshun/config/apollo/wsShunFengChe/apollo-env.properties

COPY target/$JAR_FILE $WORK_PATH/

WORKDIR $WORK_PATH

ENTRYPOINT exec java $JAVA_OPTS -jar $JAR_FILE
