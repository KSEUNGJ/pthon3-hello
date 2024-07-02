FROM   ubuntu:20.04
LABEL  maintainer="wangamy"
RUN    apt-get update \
		   && apt-get install -y python3
COPY   hello.py /
EXPOSE 80
CMD    ["python3", "/hello.py"]