# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# Want to help us make this template better? Share your feedback here: https://forms.gle/ybq9Krt8jtBL3iCk7

FROM ubuntu:24.04

# Default setting for number of CPUs to be used. May be overwritten with CLI 
ARG NUM_OF_CPUS=4

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

# Install tool-chain
FROM ubuntu
RUN apt-get update && apt-get upgrade && apt-get install -y \
    make \
    wget \
    gcc \
	gdb\
	g++\
    git \
	python3 \
	python3-pip \
	python3-venv \
	pipx

RUN apt install python3-packaging

RUN apt install python3-psutil

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/appuser" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
	

# Create the home directory
RUN mkdir -p /home/appuser && chown appuser:appuser /home/appuser

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
#RUN --mount=type=cache,target=/root/.cache/pip \
#    --mount=type=bind,source=requirements.txt,target=requirements.txt \
#    python -m pip install -r requirements.txt

WORKDIR /app

# Switch to the non-privileged user to run the application.
USER appuser

# Copy the source code into the container.
COPY . .

# Run the application.
ENTRYPOINT ["sh", "-c", "python3 ./tools/donate-cpu.py -j${NUM_OF_CPUS}"]
