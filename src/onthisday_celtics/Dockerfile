FROM python:3.11-slim-buster

COPY src/onthisday_celtics/requirements.txt ./requirements.txt

COPY src/onthisday_celtics/script.py ./script.py

RUN pip install -r requirements.txt

CMD ["python", "script.py"]