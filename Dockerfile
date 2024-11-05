FROM ubuntu:latest

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y texlive-base texlive-science build-essential
RUN apt-get install -y texlive-lang-french 
