FROM myactivemq:v0.2
MAINTAINER jack <abc@abc.com>

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh && \
chown -R blue:blue /home/blue/*

ENTRYPOINT ["/entrypoint.sh"]
