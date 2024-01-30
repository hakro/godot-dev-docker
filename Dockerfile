FROM ubuntu

ARG MOLD_URL="https://github.com/rui314/mold/releases/download/v1.10.1/mold-1.10.1-x86_64-linux.tar.gz"
ARG PYSTON_URL="https://github.com/pyston/pyston/releases/download/pyston_2.3.5/pyston_2.3.5_portable_amd64.tar.gz"

WORKDIR /root

# Install necessary dependencies
RUN apt update && apt install -y build-essential scons pkg-config \
                            libx11-dev libxcursor-dev libxinerama-dev \
                            libgl1-mesa-dev libglu-dev libasound2-dev \
                            libpulse-dev libudev-dev libxi-dev libxrandr-dev libwayland-bin \
                            wget git clang

# Download and configure Mold
RUN wget -O mold.tgz $MOLD_URL && tar -xzf mold.tgz \
    && rm mold.tgz && mv mold-* mold && ln -s /root/mold/bin/mold /usr/local/bin/mold
ENV PATH="${PATH}:/root/mold/bin"

# Donwload and configure Pyston
RUN wget -O pyston.tgz $PYSTON_URL && tar -xzf pyston.tgz \
    && rm pyston.tgz && mv pyston_* pyston
ENV PATH="${PATH}:/root/pyston/bin"
RUN pyston -m pip install scons \
    && ln -s /root/pyston/bin/scons /root/pyston/bin/pyston-scons
    

COPY gdbuild /usr/local/bin
RUN chmod a+x /usr/local/bin/gdbuild

WORKDIR /godot
