FROM earthly/dind:ubuntu-24.04-docker-27.3.1-1
ADD . /bottlerocket
RUN chmod 755 /bottlerocket/builder.sh
WORKDIR /root
RUN apt update && apt install -y libssl-dev \
    libudev-dev \
    pkg-config \
    libelf-dev \
    libdw-dev \
    libcap-dev \
    libseccomp-dev \
    libbpfcc-dev \
    clang \
    llvm git build-essential openssl libssl-dev pkg-config liblz4-tool curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN systemctl enable docker
RUN cargo install cargo-make

WORKDIR /bottlerocket

CMD ["./builder.sh", ""]
