FROM golang:1.14 AS builder
RUN go get github.com/prometheus/client_golang/prometheus
RUN go get github.com/prometheus/client_golang/prometheus/promauto
RUN go get github.com/prometheus/client_golang/prometheus/promhttp
WORKDIR /app
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a
CMD [ "./app" ]