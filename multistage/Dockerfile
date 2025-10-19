# stage 1:
FROM golang:1.24-alpine AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
#RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo \
#    -ldflags "-w -s -extldflags \"-static\"" -o app .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-w -s -extldflags \"-static\"" -o app .

# stage 2: final image (distroless)
#FROM gcr.io/distroless/static-debian12 AS Final
#FROM golang:1.24-alpine AS final
#WORKDIR /app
#COPY --from=builder /build/app .
#USER nonroot:nonroot
#CMD ["./app"]
FROM golang:1.24-alpine AS final
WORKDIR /app
COPY --from=builder /build/app .
USER root
CMD ["./app"]


# bloated single-stage image

FROM golang:1.24
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o app .
EXPOSE 8080
CMD ["./app"]

