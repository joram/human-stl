FROM python:3.12

# Set the working directory
WORKDIR /app

# Setup the environment
RUN sudo apt-get install freeglut3-dev
ADD requirements.txt /app
RUN pip install -r requirements.txt

# Fetch the model
ADD ./scripts /app/scripts
RUN python scripts/download_trained_model.py

# Copy the source code
ADD . /app

# Run the application
CMD ["python", "app.py"]
