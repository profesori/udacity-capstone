#!/usr/bin/env bash

docker build --tag=udacity-capstone .
docker run -p 80:80 udacity-capstone
