FROM python:3.9-alpine
# apk stands for Alpine Linux package keeper (manager)
# --no-cache is an option that tells apk not to cache the index locally after installing the package  This helps save disk space on the system.
# shadow package that contains the system user and group management utilities, which are required for managing users and groups on the system.
ENV USER=appuser
RUN apk add --no-cache shadow
#  creates a new system group called $USER with the -r option, which tells the system to create a system group. System groups are used for system processes and daemons that require specific privileges and permissions
RUN groupadd -r $USER && useradd -r -g $USER $USER
WORKDIR /app
#    This env var is used by Python to control the generation of bytecode files (.pyc). it instructs Python not to write bytecode files (prevents Python from generating them). This can be useful in containerized environments where you don't want to clutter the file system with bytecode files.
ENV PYTHONDONTWRITEBYTECODE=1
COPY . .
#RUN pip install --upgrade pip
# chown -R $USER:$USER /app changes the ownership of the directory /app to the $USER user and $USER group recursively
RUN chown -R $USER:$USER /app
RUN pip install -r requirements.txt
USER $USER
EXPOSE 5000
CMD [ "gunicorn", "--bind", "0.0.0.0:5000","wsgi:app" ]
