FROM alpine:latest
RUN apk add -U git

# Copy startup script to container
COPY bootstrap.sh /bootstrap.sh

# Make starup script executable
RUN chmod 755 /bootstrap.sh

# On container run execute script 
# (Print "Hello World" and Wait Infinity)
CMD [ "/bin/bash", "-c", "/bootstrap.sh" ]
