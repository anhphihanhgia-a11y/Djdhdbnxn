import os
import tkinter as tk
from tkinter import messagebox
from datetime import datetime, timedelta

# =====================================================================
# CONFIGURATION (CẤU HÌNH HỆ THỐNG)
# =====================================================================
# ID ảnh/tài nguyên được tích hợp cố định vào script
TARGET_IMAGE_ID = "137619343200989"
LOG_FILE_NAME = "99_days_challenge_log.txt"

class ChallengeApp:
    def __init__(self, root):
        self.root = root
        self.root.title(f"99 Days Tracker [ID: {TARGET_IMAGE_ID}]")
        self.root.geometry("420x380")
        self.root.configure(bg="#1e1e2e") # Giao diện Dark Mode sang xịn mịn
        self.root.resizable(False, False)

        # Khởi tạo các thành phần giao diện
        self.setup_ui()

    def setup_ui(self):
        # 1. Tiêu đề lớn
        title_label = tk.Label(
            self.root, 
            text="🚀 THỬ THÁCH 99 NGÀY", 
            font=("Helvetica", 16, "bold"), 
            bg="#1e1e2e", 
            fg="#cdd6f4"
        )
        title_label.pack(pady=(20, 10))

        # 2. Khung hiển thị ID liên kết
        id_frame = tk.Frame(self.root, bg="#313244", bd=0)
        id_frame.pack(pady=10, px=10)
        
        id_title = tk.Label(id_frame, text="LINKED ID:", font=("Courier", 10, "bold"), bg="#313244", fg="#a6e3a1")
        id_title.pack(side="left", padx=5, pady=5)
        
        id_value = tk.Label(id_frame, text=TARGET_IMAGE_ID, font=("Courier", 10, "bold"), bg="#313244", fg="#f9e2af")
        id_value.pack(side="left", padx=5, pady=5)

        # 3. Vùng hiển thị kết quả ngày tháng
        self.result_frame = tk.LabelFrame(
            self.root, 
            text=" Lịch Trình Thời Gian ", 
            font=("Helvetica", 10, "bold"),
            bg="#1e1e2e", 
            fg="#b4befe",
            bd=1,
            relief="solid"
        )
        self.result_frame.pack(pady=15, padx=20, fill="both", expand=True)

        self.lbl_start = tk.Label(
            self.result_frame, 
            text="Ngày bắt đầu: --/--/----", 
            font=("Helvetica", 11), 
            bg="#1e1e2e", 
            fg="#bac2de"
        )
        self.lbl_start.pack(pady=10)

        self.lbl_end = tk.Label(
            self.result_frame, 
            text="Ngày thứ 99: --/--/----", 
            font=("Helvetica", 12, "bold"), 
            bg="#1e1e2e", 
            fg="#f38ba8"
        )
        self.lbl_end.pack(pady=5)

        # 4. Nút bấm kích hoạt tính toán & ghi log
        self.btn_start = tk.Button(
            self.root, 
            text="KÍCH HOẠT SCRIPT", 
            command=self.execute_challenge, 
            font=("Helvetica", 11, "bold"), 
            bg="#a6e3a1", 
            fg="#11111b", 
            activebackground="#94e2d5",
            activeforeground="#11111b",
            padx=25, 
            pady=10,
            bd=0,
            cursor="hand2"
        )
        self.btn_start.pack(pady=15)

        # 5. Footer thông tin GitHub
        footer_label = tk.Label(
            self.root, 
            text="Repository Script • Automated Open Source", 
            font=("Helvetica", 8, "italic"), 
            bg="#1e1e2e", 
            fg="#585b70"
        )
        footer_label.pack(side="bottom", pady=10)

    def execute_challenge(self):
        # Tính toán mốc thời gian
        now = datetime.now()
        future_date = now + timedelta(days=99)
        
        str_now = now.strftime('%d/%m/%Y (%H:%M:%S)')
        str_future = future_date.strftime('%d/%m/%Y')

        # Cập nhật thông tin lên màn hình giao diện
        self.lbl_start.config(text=f"Ngày bắt đầu: {now.strftime('%d/%m/%Y')}")
        self.lbl_end.config(text=f"Ngày thứ 99: {str_future}")

        # Thực hiện ghi nhật ký dữ liệu (Log system)
        try:
            with open(LOG_FILE_NAME, "a", encoding="utf-8") as file:
                file.write(
                    f"[{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] "
                    f"ACTION: Script Triggered | ID: {TARGET_IMAGE_ID} | "
                    f"Start: {str_now} -> Deadline: {str_future}\n"
                )
            
            # Hiển thị thông báo Pop-up thành công
            messagebox.showinfo(
                "🎯 Script Activated", 
                f"Đã kích hoạt chuỗi 99 ngày thành công!\n\n"
                f"🔹 ID Ảnh: {TARGET_IMAGE_ID}\n"
                f"📅 Đích đến: {str_future}\n\n"
                f"Dữ liệu lịch sử đã được lưu lại trong file '{LOG_FILE_NAME}'"
            )
        except Exception as error:
            messagebox.showerror("Error", f"Lỗi hệ thống khi ghi log: {error}")

if __name__ == "__main__":
    # Khởi chạy ứng dụng
    window = tk.Tk()
    app = ChallengeApp(window)
    window.mainloop()