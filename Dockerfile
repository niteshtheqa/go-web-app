FROM golang:1.22.5 AS base

WORKDIR /app

COPY go.mod ./

RUN go mod tidy && go mod vendor

COPY . .

RUN go build -o /app/main .

########################
#Reduce images size by using multistage dockerfile
#########################
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]


