FROM python:3.11-slim

WORKDIR /app

# Install dependencies first for better caching
COPY ./app/requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY ./app .

EXPOSE 80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80", "--reload"]
