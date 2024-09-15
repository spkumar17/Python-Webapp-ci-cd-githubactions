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


# Build stage
FROM python:3.9-slim AS build

WORKDIR /app

# Copy the requirements file and install dependencies
COPY src/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY src/ .

# Stage 2: Runtime stage
FROM python:3.9-alpine

WORKDIR /app

# Copy the dependencies and application code from the build stage
COPY --from=build /app /app

EXPOSE 5000

# Command to run the application
CMD ["gunicorn", "-b", "0.0.0.0:5000", "run:app"]