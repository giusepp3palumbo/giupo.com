# Build frontend
FROM node:23-bookworm AS frontend-builder
WORKDIR /app

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY ./ /app
RUN echo $(ls)

# Installa le dipendenze e crea la build di produzione
RUN npm install
RUN npm run build

# Fase finale: runtime
FROM nginx:bookworm AS runtime

RUN echo $(ls app/)

# Copia la build del frontend
COPY --from=frontend-builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Esponi la porta e avvia il server
EXPOSE 80
# Start Nginx to serve the application
CMD ["nginx", "-g", "daemon off;"]