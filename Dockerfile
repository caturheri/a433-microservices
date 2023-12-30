# Menggunakan image node versi 18 Alpine sebagai dasar untuk stage "base"
FROM node:18-alpine as base
# Menetapkan direktori kerja ke "/src" di dalam container.
WORKDIR /src
# Menyalin semua file dari direktori lokal ke direktori kerja di dalam container
COPY . .
 
# Memulai stage "production" dari stage "base" 
FROM base as production
# Mengatur variabel lingkungan NODE_ENV ke "production"
ENV NODE_ENV=production
# Menjalankan perintah untuk menginstal dependensi menggunakan "npm ci
RUN npm ci
# Menyalin semua file dengan ekstensi ".js" ke dalam direktori kerja
COPY ./*.js ./
# Menambahkan instruksi EXPOSE untuk mengekspos port 3000 untuk lingkungan production
EXPOSE 3000
# Menentukan perintah default yang akan dijalankan ketika container dimulai
CMD ["node", "index.js"]
 
# Memulai stage "dev" dari stage "base" 
FROM base as dev
# Menambahkan paket bash ke dalam image Alpine.
RUN apk add --no-cache bash
# Mengunduh skrip "wait-for-it.sh" ke dalam direktori "/bin/" dan memberikan izin eksekusi.
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh
  
# Mengatur variabel lingkungan NODE_ENV ke "development"
ENV NODE_ENV=development
# Menjalankan perintah untuk menginstal dependensi menggunakan "npm install".
RUN npm install
# Menyalin semua file ke dalam direktori kerja.
COPY . .
# Menambahkan instruksi EXPOSE untuk mengekspos port 3000 untuk lingkungan development
EXPOSE 3000
# Menentukan perintah default yang akan dijalankan ketika container dimulai.
CMD ["node", "index.js"]
