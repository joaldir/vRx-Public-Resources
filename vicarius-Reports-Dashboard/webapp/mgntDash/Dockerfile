# Use the official Python image from the Docker Hub
FROM python:3.12.2-bookworm

# Set the working directory
WORKDIR /usr/src/app

# Copy the requirements file
ADD ./requirements.txt /usr/src/app/requirements.txt
#COPY requirements.txt /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update
RUN apt-get install lsb-release
RUN apt-get update && apt-get install -y curl gnupg
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc -o /tmp/ACCC4CF8.asc
RUN gpg --dearmor -o /usr/share/keyrings/postgresql-archive-keyring.gpg /tmp/ACCC4CF8.asc
RUN echo "deb [signed-by=/usr/share/keyrings/postgresql-archive-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
RUN apt-get update

RUN apt-get -y install postgresql-client-16
# Copy the entire project
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
