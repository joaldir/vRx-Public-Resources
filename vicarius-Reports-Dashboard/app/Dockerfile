FROM python:3.12.2-bookworm

WORKDIR /usr/src/app

# Instale dependências do sistema e cron em uma única camada
RUN apt-get update && apt-get install -y --no-install-recommends \
    cron \
    lsb-release \
    curl \
    gnupg \
    && curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/postgresql-archive-keyring.gpg] http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update && apt-get install -y --no-install-recommends postgresql-client-16 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copiar apenas o arquivo requirements.txt para aproveitar o cache de camadas
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o restante dos arquivos
COPY . /usr/src/app/

# Configurar o entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Definir o entrypoint padrão
CMD ["/entrypoint.sh"]