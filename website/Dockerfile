FROM oven/bun:alpine

WORKDIR /app/express

COPY package*.json ./

RUN bun install

COPY . .

EXPOSE 3000

CMD [ "bun", "start" ]