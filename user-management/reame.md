# 🚀 User Management System (Shell Scripting)

A **production-ready user management system** built using **Bash (Shell Scripting)**.
This project allows system administrators to **create, delete, and update Linux users** with proper validation, logging, and automation.

---

## 📌 Features

* ✅ Create users with auto-generated secure passwords
* ✅ Delete users along with home directory
* ✅ Update username and group
* ✅ Auto-create group if it does not exist
* ✅ Username validation (Linux standards)
* ✅ Logging system for audit & debugging
* ✅ Password expiry enforcement (force reset on first login)
* ✅ Modular and production-ready structure

---
## ⚙️ Prerequisites

* Linux OS (Ubuntu, CentOS, etc.)
* Root or sudo access
* Bash shell

---

## 🔐 Important Note

> ⚠️ This script must be run as **root user** because it performs system-level operations like `useradd`, `userdel`, etc.

---

## ▶️ How to Run

```bash
chmod +x main.sh user.sh validation.sh log.sh
sudo ./main.sh
```

---

## 📋 Menu Options

```
========= User Management =========
1. Create User
2. Delete User
3. Update User
4. Exit
```

---

## 🧠 Functionality Breakdown

### 🔹 Create User

* Validates username format
* Checks if user already exists
* Creates group (if not present)
* Generates secure password
* Forces password reset on first login
* Create User

---

### 🔹 Delete User

* Verifies user existence
* Deletes user along with home directory

---

### 🔹 Update User

* Rename existing user
* Change group
* Move home directory automatically

---


## 🔑 Password Generation

Passwords are generated using:

```bash
date +%s%N | sha256sum | head -c 12
```

✔ Unique
✔ Random
✔ Secure for temporary use

---

## 📄 Logging

Logs are stored in:

```
logs/user-mgmt.log
* 🔹 [user-mgmt.log](./logs/user-mgmt.log)
```

Example:

```
2026-04-21 10:30:45 [INFO] User created: devuser
2026-04-21 10:32:10 [ERROR] User already exists: devuser
```

---

## 🛡️ Error Handling

* Empty input validation
* Existing user checks
* Group validation
* Command execution status checks
* Logging for all failures

---


## 👨‍💻 Author

**Akash Kayande** *DevOps | AWS | Terraform | Kubernetes*
---

## ⭐ If you like this project

Give it a ⭐ on GitHub and use it in your DevOps portfolio!
---