# version
FROM python:3.9.15

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app


# Install the application dependencies
RUN pip install --no-cache-dir -r requirements.txt


# port fowarding to container  
EXPOSE 5000


# Run app.py when the container launches
CMD ["python", "main.py"]