# ---------- Base Image ----------
FROM python:3.10-slim

# ---------- System Dependencies ----------
RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

# ---------- Working Directory ----------
WORKDIR /app

# ---------- Copy Poetry ----------
RUN pip install poetry
COPY pyproject.toml poetry.lock* ./

# ---------- Install Dependencies ----------
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

# ---------- Copy Source Code ----------
COPY . .

# ---------- Expose Port ----------
EXPOSE 8000

# ---------- Run App ----------
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
