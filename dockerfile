FROM ubuntu:20.04
MAINTAINER Qiguang Song <songqiguang@gmail.com>

RUN apt-get update -y && \
    apt-get -y install daemon \
                       git \
                       python3-dev \
                       python3-distutils \
                       python3-pip \
                       python3-venv \
                       wget \
                       curl
RUN pip3 install --upgrade pip
RUN pip3 install robotframework
RUN pip3 install robotframework-extendedrequestslibrary
RUN python3 -m pip install requests
WORKDIR ./Assignment_Robot
COPY / /
RUN pip3 install -r /requirements.txt
RUN python3 /app.py &
RUN robot /Tests/