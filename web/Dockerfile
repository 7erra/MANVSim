FROM node:16-alpine

WORKDIR /app

ARG VITE_API_URL=http://localhost:5002/web/

COPY package.json package-lock.json ./
RUN npm install

COPY . .

RUN npm run build
RUN npm install -g serve

EXPOSE 5003
CMD ["serve", "-s", "dist", "-l", "5003"]