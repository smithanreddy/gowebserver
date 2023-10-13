#create multi stage Docker
#Build Stage

FROM golang:1.21.1-alpine as builder 

#set the working directory
WORKDIR /app

COPY . .

#Build the app
RUN go build -o myapp

#use a smaller image to reduce the size of the final container
FROM alpine:latest

#set working dirctory
WORKDIR /root/

#Copy the binary from the builder stage
COPY --from=builder /app/myapp .

#Execute the app
CMD ["./myapp"]