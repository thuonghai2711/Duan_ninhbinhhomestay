# 🏠 Ninh Bình HomeStay — Hệ thống quản lý & cho thuê nhà trọ

Hệ thống web toàn diện cho phép **đăng ký, xác minh chủ trọ, đăng phòng, đặt lịch xem phòng, hợp đồng điện tử, thanh toán hóa đơn** và **quản trị** trên một nền tảng duy nhất.

---

## 🧱 Công nghệ (Tech Stack)

| Tầng | Công nghệ |
|------|-----------|
| Backend | **Laravel 10** (PHP ≥ 8.1) |
| Frontend | **Vue 3** (Composition API) + **Inertia.js** |
| CSS | **Tailwind CSS** |
| Build tool | **Vite** (+ `vite-plugin-pwa` cho PWA) |
| DB | MySQL / MariaDB |
| Xác thực | Laravel Sanctum, Socialite (Google), Hashids |
| Khác | Ziggy (routes), DomPDF, AWS S3, Pusher, mews/captcha |

---

## 🏗️ Kiến trúc

Dự án dùng mô hình **MVC mở rộng** để tách bạch nghiệp vụ:

```
Request → Controller → Service → Repository → Model → Database
              │            │           │
         (nhận yêu cầu) (logic nghiệp vụ) (truy vấn DB)
```

- **Controller** — nhận request, trả response, không chứa logic nặng.
- **Service** — xử lý nghiệp vụ (thay cho Controller để tránh "fat controller").
- **Repository** — tương tác Database, cô lập truy vấn Eloquent.

### Phân quyền (3 nhóm người dùng)
- **Client** — khách thuê: tìm phòng, đặt lịch xem, hợp đồng, thanh toán.
- **Landlord / Owner** — chủ trọ: đăng trọ/phòng, quản lý tình trạng phòng, xác minh CCCD.
- **Admin** — quản trị: duyệt xác minh, điều phối, audit log, báo cáo.

---

## ✨ Tính năng chính

- 🔐 Đăng nhập / đăng ký + xác minh Google (Socialite)
- 🪪 Xác minh chủ trọ bằng **CCCD** (đọc EXIF toạ độ, ảnh `.heic`)
- 🏘️ Quản lý nhà trọ — phòng — tầng — tiện ích — khu vực
- 📅 Đặt lịch hẹn xem phòng + quản lý thời gian trống của chủ trọ
- 📄 Hợp đồng điện tử (soạn thảo Quill, scan, lưu draft)
- 💰 Hóa đơn / thanh toán (OCR công tơ, bulk nhập)
- ⭐ Đánh giá, báo cáo vi phạm, yêu cầu ở ghép (roommate)
- 🤖 Trợ lý AI chat + parse tìm kiếm phòng (`/api/ai/*`)
- 🗺️ Bản đồ & chỉ đường Google Maps (vị trí trọ, lịch hẹn)
- 📱 PWA — cài đặt như ứng dụng

---

## 🚀 Cài đặt & Chạy dự án

### 1. Yêu cầu
- PHP ≥ 8.1 (bật extension `exif` nếu dùng xác minh toạ độ)
- Composer, Node.js ≥ 18, MySQL/MariaDB

### 2. Các bước

```bash
# Clone repo
git clone https://github.com/thuonghai2711/Duan_ninhbinhhomestay.git
cd Duan_ninhbinhhomestay

# Cài dependencies PHP
composer install

# Cấu hình môi trường
cp .env.example .env
php artisan key:generate
# → sửa DB_CONNECTION, DB_DATABASE, DB_USERNAME, DB_PASSWORD trong .env

# Tạo & seed database
php artisan migrate --seed

# Sinh file routes cho Ziggy (BẮT BUỘC)
php artisan ziggy:generate

# Cài dependencies JS
npm install

# Build assets
npm run build        # production
# hoặc
npm run dev          # dev server (nhanh, không chờ PWA)

# Chạy app
php artisan serve
```

Mở trình duyệt: **http://localhost:8000**

### 3. Chạy bằng Docker (tuỳ chọn)
```bash
docker compose up -d
```

---

## 📦 Các package JS cần thêm (nếu thiếu)

| Lệnh | Mục đích |
|------|----------|
| `npm install face-api.js` | Xác minh khuôn mặt |
| `npm install heic2any` | Chuyển ảnh `.heic` → `.jpg` |
| `npm install exifr` | Đọc EXIF (toạ độ) từ ảnh |
| `npm install @vueup/vue-quill@latest --save` | Soạn thảo văn bản hợp đồng |
| `npm install vite-plugin-pwa --save-dev` | PWA |

> ⚠️ **Lỗi face-api.js với Vite:** nếu cài bị lỗi do phiên bản Vite, sửa trong `package.json`: đổi `"laravel-vite-plugin": "^0.7.2"` → `"^1.0.0"`, rồi chạy lại `npm install` và `npm install face-api.js`.

> ⚠️ **Xác minh admin không hiện toạ độ:** bật extension `exif` của PHP (Laragon: chuột phải → PHP → Extensions).

---

## 🔄 Trạng thái phòng (Quản lý trọ)

Luật chuyển trạng thái & khả năng khoá phòng:

| Trạng thái hiện tại | Có thể chuyển sang | Khoá phòng? |
|---------------------|--------------------|:-----------:|
| Còn trống | Đã đặt cọc, Bảo trì | ✅ Y |
| Đã đặt cọc | Đã thuê, Còn trống | ❌ N |
| Đã thuê | Sắp hết HĐ, Bảo trì | ❌ N |
| Sắp hết HĐ | Chờ gia hạn, Còn trống | ❌ N |
| Chờ gia hạn | Đã thuê, Còn trống | ❌ N |
| Bảo trì | Còn trống | ✅ Y |
| Đang xây dựng | Còn trống | ✅ Y |

---

## 📁 Cấu trúc thư mục chính

```
app/
├── Http/Controllers/     # Admin, Client, Landlord, Owner, Auth, Api
├── Models/               # Room, BoardingHouse, Contract, Invoice, User...
├── Services/             # Logic nghiệp vụ
└── Repositories/         # Truy vấn Database
resources/js/Pages/       # Vue pages: Admin, Client, Landlord, Profile, Auth
routes/web.php            # Định nghĩa route
database/                 # Migrations + Seeders + dump mẫu
```

---

## 🗺️ Tài liệu bảo vệ đồ án — Bản đồ & Chỉ đường Google Maps

Tích hợp bản đồ vị trí thực tế của nhà trọ + tự động vẽ đường đi từ vị trí khách đến phòng trọ.

- **Vị trí áp dụng:** trang *Lịch Hẹn Xem Phòng* (`lichhen.vue`) và *Chi Tiết Trọ* (`chitiettro.vue`).
- **Công nghệ:** Vue 3, HTML5 Geolocation API, Google Maps Embed Iframe.
- **Luồng:** Laravel lấy `address_detail` của `BoardingHouse` (qua quan hệ `Room → BoardingHouse`) → gửi qua Inertia Props → Vue gọi Geolocation + vẽ iframe chỉ đường.

---

## 📄 License

MIT

