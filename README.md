# Install Microsoft Store 

This PowerShell script automatically installs the **Microsoft Store** on **Windows 10** (Evaluation and Full versions) Servers. It downloads and installs the required dependencies without any manual intervention.

## 📜 Features
✅ Fully automated installation  
✅ Fetches the latest Microsoft Store packages  
✅ Tested on Windows 10 LTSC 2021

## 🚀 How to Use

1. **Run PowerShell as Administrator**  
   - Press `Win + X`, then select **Windows Terminal (Admin)** or **PowerShell (Admin)**

2. **Download and execute the script**  
   Copy and paste the following command into PowerShell:

   ```powershell
   iwr -useb https://raw.githubusercontent.com/kavaliersdelikt/microsoft-store-installer/main/install.ps1 | iex
