FROM ubuntu:22.04
RUN apt-get update \
 && </dev/null DEBIAN_FRONTEND=noninteractive \
    apt-get --yes install curl wget python3.9 python3-pip nodejs build-essential npm && npm install -g n && n latest \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN pip3 install robotframework-browser && rfbrowser init &&  pip install rpaframework && npx playwright install-deps
RUN pip3 install serial paramiko
# volumes move the tests and return the zip with results
# https://robotframework-browser.org/
# r"robot -d /home/anastasiia/robot/tests/Results /home/anastasiia/robot/tests/Tests/check.robot")
