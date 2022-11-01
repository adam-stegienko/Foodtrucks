FROM alpine:3.15 AS builder
COPY . /src/app
WORKDIR /src/app/flask-app/
RUN apk add --no-cache curl
RUN apk add --no-cache python2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
RUN python2 get-pip.py
RUN pip2 install -r ./requirements.txt
RUN python -m ensurepip
RUN curl -sL https://deb.nodesource.com/setup_14.x
RUN apk add --no-cache nodejs
RUN apk add --no-cache npm
RUN npm install
RUN npm run build .
CMD [ "npm", "run", "start" ]

FROM alpine:3.15
RUN apk add curl
RUN apk add --no-cache python2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
RUN python2 get-pip.py
COPY --from=builder /src/app/flask-app/app.py /src/app/flask-app/requirements.txt /src/app/
WORKDIR /src/app/
RUN pip2 install -r ./requirements.txt
RUN python -m ensurepip
CMD ["python", "./app.py"]
