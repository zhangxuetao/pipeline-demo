FROM adoptopenjdk/openjdk8-openj9

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
    echo "Asia/Shanghai" > /etc/timezone

#添加Apollo配置文件
ADD data.zip /data.zip

RUN unzip /data.zip -d / \
    && rm -rf /data.zip


COPY target/$JAR_FILE $WORK_PATH/

WORKDIR $WORK_PATH

ENTRYPOINT exec java $JAVA_OPTS -jar $JAR_FILE
