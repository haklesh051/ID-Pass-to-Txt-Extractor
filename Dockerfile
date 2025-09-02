# Use a Python 3.11 Alpine base image
FROM python:3.11-alpine3.18

# Set the working directory
WORKDIR /app

# Copy all files from the current directory to the container's /app directory
COPY . .

# Install necessary dependencies
RUN apk add --no-cache \
    gcc \
    libffi-dev \
    musl-dev \
    ffmpeg \
    aria2 \
    unzip \
    wget \
    ca-certificates \
 && wget -O /tmp/bento4.zip https://www.bento4.com/downloads/Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip \
 && unzip /tmp/bento4.zip -d /tmp \
 && cp /tmp/Bento4-SDK-*/bin/mp4decrypt /usr/local/bin/ \
 && chmod +x /usr/local/bin/mp4decrypt \
 && rm -rf /tmp/Bento4-SDK* /tmp/bento4.zip

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r sainibots.txt \
    && python3 -m pip install -U yt-dlp

# Set the command to run the application
CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]
