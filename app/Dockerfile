# Imagen base optimizada
FROM python:3.11-slim

# Configuración de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establece la carpeta de trabajo
WORKDIR /app

# ─── dependencias de sistema ───────────────────────────────────────────
RUN apt-get update \
    && apt-get install -y git curl gcc libpq-dev \
    # instala Node 20 LTS desde NodeSource
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*


# ─── python requirements ───────────────────────────────────────────────
COPY app/requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
# ahora django-tailwind (rama main) ya está instalado

# ─── copia del código y entrypoint, como antes ─────────────────────────
# mejor evitar este copy, así controlas exactamente qué entra en la imagen.
#COPY . .
COPY app/ app/
COPY static/ static/
#COPY ../tailwind.config.js .
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# (por si django-tailwind lo necesita)
#ENV NPM_BIN_PATH=/usr/bin/npm

#ENTRYPOINT ["/entrypoint.sh"]

# Si quieres hot-reload en desarrollo cambia CMD por
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# CMD ["gunicorn", "core.wsgi:application", "--bind", "0.0.0.0:8000"]

# ---------- Compilar Tailwind CSS ----------
#RUN curl -sSL https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64 \
#      -o /usr/local/bin/tailwindcss \
# && chmod +x /usr/local/bin/tailwindcss \
# && /usr/local/bin/tailwindcss \
#        -i static/src/input.css \
#        -o static/css/styles.css \
#        --minify \
# && rm /usr/local/bin/tailwindcss
# ← limpia binario si deseas aún menos tamaño

# Puerto por defecto (opcional, solo informativo)
EXPOSE 8000