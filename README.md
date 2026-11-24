# Sun Logistic: WMS Microservices

Sistem gudang (WMS) yang dipecah menjadi beberapa service, dengan asisten AI yang memakai izin pengguna yang sama.
Rancangan lengkap ada di [ARCHITECTURE.md](ARCHITECTURE.md).

## Isi repo ini

Repo ini hanya berisi infrastruktur: `docker-compose.yml`, konfigurasi gateway (`gateway/`), skrip database awal (`docker/`), dan skrip pembuat key (`scripts/`).
Tiap service punya repo sendiri dan harus berada di folder ini, sejajar dengan `docker-compose.yml`:

| Folder | Isi | Port langsung |
|---|---|---|
| `auth-ep` | login, users, roles, permissions, penerbit JWT | 8001 |
| `wms-ep` | gudang, rak, barang, stok, pemindahan | 8002 |
| `assistant-ep` | asisten AI (tool dengan izin per user) | 8006 |
| `wms-web` | frontend React | 3000 |
| `assistant-web` | klien chat terpisah | dev server |

Semua API diakses lewat gateway nginx di `http://localhost:8000` (`/api/auth`, `/api/wms`, `/api/assistant`).

## Menjalankan

Prasyarat: Docker Desktop, PHP dan Composer (untuk membuat `APP_KEY`), Git Bash atau terminal dengan `openssl`.

1. Kloning kelima repo service ke folder ini.
2. Buat key JWT: `bash scripts/generate-keys.sh`
3. Di tiap `*-ep`: salin `.env.example` menjadi `.env`, lalu `php artisan key:generate`. Isi API key LLM di `assistant-ep/.env`.
4. `docker compose up --build`
5. Buka `http://localhost:8000`.

Akun demo (data contoh): `admin`, `supervisor`, `operator`, kata sandi `admin123`.

Setelah volume database baru, migrate dan seed berjalan otomatis. Reset penuh: `docker compose down -v`.

## Yang tidak ada di repo

- Private key JWT dan semua file `.env` (dibuat lokal, lihat langkah di atas).
- Kode service (ada di repo masing-masing).
