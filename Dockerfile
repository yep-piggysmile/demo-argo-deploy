FROM golang:1.22-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod tidy
COPY . .
RUN CGO_ENABLED=0 go build -o app

FROM alpine:3.19
WORKDIR /app
COPY --from=build /app/app .
EXPOSE 3000
CMD ["./app"]