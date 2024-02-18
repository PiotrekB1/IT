ARG IMG_VERSION="3.11-slim"


FROM python:${IMG_VERSION} as REQ
    WORKDIR /code
    RUN pip install pipenv
    COPY ./Pipfile ./
    COPY ./Pipfile.lock ./
    RUN pipenv requirements > /code/requirements.txt

FROM python:${IMG_VERSION} as APP
    # Setup env
    ENV LANG C.UTF-8
    ENV LC_ALL C.UTF-8
    ENV PYTHONDONTWRITEBYTECODE 1
    ENV PYTHONFAULTHANDLER 1
    # Create new user
    RUN useradd --create-home --home-dir /usr/src/app appuser
    WORKDIR /usr/src/app

    # Install deps
    COPY --from=REQ  /code/requirements.txt /code/requirements.txt
    RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

    USER appuser
    COPY --chown=1000:1000 ./ /usr/src/app
    EXPOSE 8080
    ARG RESPONSE=META
    RUN echo $RESPONSE > /usr/src/app/response
    VOLUME [ "/usr/src/app" ]
    CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]
    ENV RESPONSE "Hello"

FROM scratch as squash
    COPY --from=APP / /
    CMD ["uvicorn", "main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "8080"]

