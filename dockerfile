FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    binutils \
    qemu-system-x86 \
    build-essential

# Set the working directory
WORKDIR /usr/src/app

# Create the obj/ and bin/ directories
RUN mkdir -p obj/
RUN mkdir -p bin/

# Copy your makefile and src directory
COPY makefile .
COPY src/ ./src/

# Build the project
RUN make

# Run QEMU in text mode with -nographic option
CMD ["qemu-system-x86_64", "-nographic", "-drive", "format=raw,file=bin/main.bin"]

