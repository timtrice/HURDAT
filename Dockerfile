FROM rocker/tidyverse:3.4.4

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
    vim

# Git configs
RUN git config --global user.email "tim.trice@gmail.com"
RUN git config --global user.name "Tim Trice"
