# syntax=docker/dockerfile:1

FROM python:3.9.7-bullseye

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

EXPOSE 5050

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=5050"]