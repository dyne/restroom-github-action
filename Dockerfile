FROM docker:stable
RUN apk add busybox-extras
COPY start-restroom.sh /start-restroom.sh
RUN chmod +x /start-restroom.sh
ADD contracts /contracts
ENTRYPOINT ["/start-restroom.sh"]
