FROM docker:stable
COPY start-restroom.sh /start-restroom.sh
RUN chmod +x /start-restroom.sh
ADD contracts /contracts
ENTRYPOINT ["/start-restroom.sh"]
