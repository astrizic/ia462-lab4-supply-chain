# IA 462 Lab 4 - digest-pinned base image (Week 8 slide: pin, don't float)
FROM python:3.11-slim@sha256:61e01f72680f86a5279ad510818ab7b2ee9f049822589d4e34e33e044360356c

LABEL maintainer="student@emich.edu"
LABEL description="IA 462 Lab 4 - Supply-Chain-Hardened App"

RUN groupadd --system appgroup && \
    useradd  --system --gid appgroup --home /app --shell /usr/sbin/nologin appuser

WORKDIR /app
COPY --chown=appuser:appgroup requirements.lock ./requirements.txt
RUN pip install --no-cache-dir --require-hashes -r requirements.txt
COPY --chown=appuser:appgroup app/ ./app/

USER appuser
EXPOSE 5000
CMD ["python3", "app/app.py"]