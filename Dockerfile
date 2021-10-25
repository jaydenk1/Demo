FROM nginx
# WORKDIR /code
# ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
EXPOSE 80
RUN apt-get update
HEALTHCHECK --interval=10s --timeout=3s --start-period=1m\
  CMD curl --fail http://localhost/containerlogs.html || exit 1