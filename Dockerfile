FROM python:3.11-alpine3.18

WORKDIR /app
COPY . .

# Install dependencies including Bento4 directly from Alpine repo
RUN apk add --no-cache \
      gcc \
      libffi-dev \
      musl-dev \
      ffmpeg \
      aria2 \
      unzip \
      wget \
      ca-certificates \
      bento4

# Now mp4decrypt should be available via Bento4 package

RUN pip3 install --no-cache-dir --upgrade pip \
  && pip3 install --no-cache-dir --upgrade -r sainibots.txt \
  && python3 -m pip install -U yt-dlp

CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]
