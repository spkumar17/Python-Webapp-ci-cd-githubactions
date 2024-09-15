# FROM python:3.9-slim-buster

# LABEL Name="Python Flask Demo App" Version=1.4.2
# LABEL org.opencontainers.image.source = "https://github.com/jaiswaladi246/Python-Webapp.git"

# ARG srcDir=src
# WORKDIR /app
# COPY $srcDir/requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# COPY $srcDir/run.py .
# COPY $srcDir/app ./app

# EXPOSE 5000

# CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]

#multi stage build:

FROM python:3.9-slim-buster AS build
WORKDIR /app
COPY src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.9-alpine
WORKDIR /app
COPY --from=build /app /app
COPY src/ .
EXPOSE 5000
CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]
