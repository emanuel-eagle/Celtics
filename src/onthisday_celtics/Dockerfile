FROM python:3.11-slim-buster

COPY requirements.txt ./requirements.txt

COPY script.py ./script.py

RUN pip install -r requirements.txt

CMD ["python", "script.py"]