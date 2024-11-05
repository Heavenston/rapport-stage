FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y texlive texlive-base texlive-full texlive-science build-essential
