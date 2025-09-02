# Use a lightweight and stable Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    aria2 \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Bento4 precompiled binary (mp4decrypt)
RUN wget -q https://github.com/axiomatic-systems/Bento4/releases/download/v1.6.0-639/Bento4-SDK-1-6-0-639.x86_64-unknown-linux.zip \
    && unzip Bento4-SDK-1-6-0-639.x86_64-unknown-linux.zip \
    && cp Bento4-SDK-1-6-0-639.x86_64-unknown-linux/bin/mp4decrypt /usr/local/bin/ \
    && rm -rf Bento4-SDK*

# Copy project files into the container
COPY . .

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && pip3 install -U yt-dlp

# Start the bot
CMD ["python3", "main.py"]
