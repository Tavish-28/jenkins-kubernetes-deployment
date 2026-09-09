# Stage 1: Build the Vite app
FROM node:20-alpine AS build
WORKDIR /react-app
COPY package.json .
COPY package-lock.json .
RUN npm i
COPY . .
RUN npm run build

# Stage 2: Serve the built static files with nginx
FROM nginx:alpine
COPY --from=build /react-app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]