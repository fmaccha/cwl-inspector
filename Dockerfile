FROM alpine:3.13

LABEL maintainer="Tomoya Tanjo <ttanjo@gmail.com>"

RUN apk --no-cache add ruby ruby-etc ruby-json nodejs curl file 

COPY cwl /usr/bin/cwl

RUN if [ "$(uname -m)" = "aarch64" ]; then \
    ls &&  \
    ls; \
    elif [ "$(uname -m)" = "x86_64" ]; then \
    ls; \
    fi

WORKDIR /tmp
RUN if [ "$(uname -m)" = "x86_64" ]; then \
    curl -Lo docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-27.1.1.tgz && \
    tar -xzf docker.tgz && \
    mv docker/docker /usr/bin/docker && \
    rm -rf docker docker.tgz; \
    elif [ "$(uname -m)" = "aarch64" ]; then \
    curl -Lo docker.tgz https://download.docker.com/linux/static/stable/aarch64/docker-27.1.1.tgz && \
    tar -xzf docker.tgz && \
    mv docker/docker /usr/bin/docker && \
    rm -rf docker docker.tgz; \
    fi



ENTRYPOINT ["/usr/bin/cwl/inspector.rb"]
