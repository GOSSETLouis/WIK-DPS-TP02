FROM node:18-alpine as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci 
COPY tsconfig.json ./
COPY src/ ./src/
RUN npm run build

FROM node:18-alpine as prod-deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit-dev

FROM node:18-alpine as app
COPY --from=build /app/dist/src .
COPY --from=prod-deps /app/node_modules ./node_modules
EXPOSE 8080
CMD node index.js