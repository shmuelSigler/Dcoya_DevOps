FROM python:3.9-alpine
ENV USER=appuser
RUN apk add --no-cache shadow
RUN groupadd -r $USER && useradd -r -g $USER $USER
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE=1
COPY . .
RUN chown -R $USER:$USER /app
RUN pip install -r requirements.txt
USER $USER
EXPOSE 5000
CMD [ "gunicorn", "--bind", "0.0.0.0:5000","wsgi:app" ]
