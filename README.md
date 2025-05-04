# 🗂️ FileUpper (Drag&Drop uploader for 0x0.st)

A drag-and-drop `.bat` script that uploads files or folders to [0x0.st](https://0x0.st), a minimalist file hosting service. Automatically zips folders, checks size limits, generates a QR code for the URL, and copies it to your clipboard — all from a simple Windows batch file.

## ✨ Features

- 🖱️ Drag & Drop support (files, folders, or multiple items)
- 📦 Automatically zips folders
- 📏 Checks file size limit (512 MiB max per 0x0.st)
- ⌛ Shows upload progress with `curl` bar
- 🔗 Prints the resulting URL and copies it to clipboard
- 📱 Generates a terminal-displayed QR code via [qrcd.to](https://qrcd.to)
- 📝 Logs all uploads with timestamps to `upload_history.txt`

## 🧰 Requirements

- Windows 10/11
- `curl` (pre-installed on most modern Windows versions)
- `powershell` (for zipping)

## 📦 Installation

1. Download or clone this repository.
3. Run the script by dragging and dropping a file or folders onto the `.bat` file.

## 🚀 Usage

- **Single File**: Drag it onto the script to upload directly.
- **Folder**: It will be zipped and uploaded if under the 512 MiB limit.

Upon success:
- The URL is printed and copied to your clipboard.
- A QR code is rendered directly in the terminal.
- The upload is logged in `upload_history.txt`.

## ❗ Notes

- 0x0.st enforces a strict **512.0 MiB** file size limit.
- Folders are zipped first — size is checked before zipping to avoid wasting time.
- If you see errors like `curl: (26) Failed to open/read local data`, it likely means the file path was incorrect or too large.
- You can customize the console window size using NirCmd (recommended for aesthetic output).

## 🛠 Customization

- Modify the `title` at the top of the script.
- Replace the QR code generator with another if preferred.
- Customize the log format in `upload_history.txt`.

## 📃 License

MIT License — do whatever you want, no warranties. Credit is appreciated.

---

**Enjoy fast, shareable uploads with just a drag-and-drop!**
