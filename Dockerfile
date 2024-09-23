# syntax=docker/dockerfile:1
FROM golang:1.23 AS builder

# Set the working directory
WORKDIR /src

# Create the main.go file
RUN echo 'package main\n\nimport "fmt"\n\nfunc main() {\n  fmt.Println("hello, world")\n}' > main.go

# Build the Go application
RUN go build -o /bin/hello main.go

# Second stage: create a minimal image
FROM scratch

# Copy the built binary from the builder stage
COPY --from=builder /bin/hello /bin/hello

# Set the command to run the binary
CMD ["/bin/hello"]
