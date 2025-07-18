FROM python:3.9
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
FROM docker:latest

# Install buildx
RUN mkdir -p ~/.docker/cli-plugins/ && \
    wget -qO ~/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/latest/download/buildx-v0.12.1.linux-amd64 && \
    chmod +x ~/.docker/cli-plugins/docker-buildx && \
    docker buildx version

# Install trivy
RUN apk add --no-cache curl git bash \
    && curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
#Testing github-webhook ..........
