from debian:latest

# Copy the same script to the container which is executed as KRM
COPY exec-krm/demo.sh /demo.sh

ENTRYPOINT ["/demo.sh"]
