FROM ghcr.io/project-osrm/osrm-backend

WORKDIR /data

EXPOSE 5000

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]