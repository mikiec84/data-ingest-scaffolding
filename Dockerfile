# The first instruction is what image we want to base our container on
# We Use an official Python runtime as a parent image
FROM python:3.6

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

# Set Python Path
ENV PYTHONPATH=/usr/local/bin

# Install pipenv and get pipfile
RUN pip install --upgrade pip
RUN pip install pipenv

# Move into a container directory
RUN mkdir /code
WORKDIR /code
ADD . /code/
RUN wget https://raw.githubusercontent.com/18F/18f-django-project-template/master/Pipfile -O /code/Pipfile

# Generate requirements.txt from Pipfile
RUN pipenv lock -r >requirements.txt
RUN pip install -r requirements.txt


RUN django-admin.py startproject --template=https://github.com/18F/18f-django-project-template/archive/master.zip starter_project