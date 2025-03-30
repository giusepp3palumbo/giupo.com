# Build frontend
FROM --platform=$BUILDPLATFORM node:23-bookworm AS frontend-builder
WORKDIR /app

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .
RUN echo $(ls)

# Installa le dipendenze e crea la build di produzione
RUN npm install
RUN npm run build 

# Fase finale: runtime
FROM --platform=$TARGETPLATFORM nginx:bookworm AS runtime

# Copia la build del frontend
COPY --from=frontend-builder /app/web/static/dist /usr/share/nginx/html

# Esponi la porta e avvia il server
EXPOSE 80
# Start Nginx to serve the application
CMD ["nginx", "-g", "daemon off;"]