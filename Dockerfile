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


FROM python:3.9-slim

WORKDIR /app

# Copy the requirements file and install dependencies
COPY src/requirements.txt ./

RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY src/ .

EXPOSE 5000

# Command to run the application
CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]