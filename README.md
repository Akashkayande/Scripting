<div align="center">

# 🚀 Scripting Projects

### Practical Bash automation for Linux system administration and DevOps

<p>
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/Platform-Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
  <img src="https://img.shields.io/badge/Focus-DevOps-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="DevOps">
</p>

<p>
  A collection of independent shell scripting projects for user management,
  server monitoring, and cloud-native application deployment.
</p>

</div>

---

## 📖 About This Repository

This repository brings together practical Bash projects that automate
frequent system administration and DevOps tasks.

### 🎯 What You Can Learn

| Area | Skills Demonstrated |
| --- | --- |
| 👤 **Linux Administration** | User creation, deletion, group management, validation, and audit logging |
| 📊 **Monitoring & Alerting** | CPU, memory, disk, service checks, email alerts, and log rotation |
| ☁️ **Cloud Deployment** | AWS EKS provisioning, Amazon ECR, Docker image publishing, and Kubernetes deployment |
| ⚙️ **Shell Automation** | Modular scripts, configuration files, error handling, and repeatable workflows |

> **💡 Tip:** Each project is self-contained. Open a project directory and
> read its local documentation before running any script.


## 📁 Repository Structure

```text
.
├── 👤 user-management/
│   ├── main.sh              # Interactive user-management menu
│   ├── user.sh              # User and group operations
│   ├── validation.sh        # Input validation and password generation
│   ├── log.sh               # Logging helpers
│   └── logs/                # User-management logs
│
├── ☁️ deployment/
│   ├── config/
│   │   └── config.sh        # AWS, EKS, ECR, and application settings
│   ├── scripts/             # Deployment and cleanup workflow scripts
│   ├── architecture.png     # Deployment architecture diagram
│   └── readme.md            # Deployment documentation
│
├── 📊 Monitoring/
│   ├── config.sh            # Monitoring thresholds and settings
│   ├── monitor.sh           # Health checks and alerting
│   ├── logs/                # Monitoring logs
│   ├── email.png            # Alerting illustration
│   └── readme.md            # Monitoring documentation
│
└── README.md                # Repository overview
```

---

## 🗂️ Project Directory

### 1. 👤 [User Management](./user-management/)

| Details | Description |
| --- | --- |
| **Purpose** | Manage Linux users and groups through an interactive Bash menu |
| **Main entry point** | [`main.sh`](./user-management/main.sh) |
| **Required access** | Root or `sudo` privileges |
| **Documentation** | [`user-management/reame.md`](./user-management/reame.md) |

#### ✨ Features

- ✅ Create Linux users with generated temporary passwords
- ✅ Automatically create groups when they do not exist
- ✅ Delete users together with their home directories
- ✅ Rename users and update their groups
- ✅ Validate usernames before making changes
- ✅ Log operations and errors to `logs/user-mgmt.log`

#### ▶️ Run

```bash
cd user-management
chmod +x main.sh user.sh validation.sh log.sh
sudo ./main.sh
```

> **⚠️ Warning:** This project modifies system accounts. Review the scripts
> and run them only on a system where you have permission to manage users.

---

### 2. ☁️ [MERN Application Deployment](./deployment/)

| Details | Description |
| --- | --- |
| **Purpose** | Automate deployment of a MERN application to AWS EKS |
| **Configuration** | [`config/config.sh`](./deployment/config/config.sh) |
| **Workflow entry point** | [`scripts/full.sh`](./deployment/scripts/full.sh) |
| **Documentation** | [`deployment/readme.md`](./deployment/readme.md) |

#### 🔄 Deployment Workflow

1. 🛠️ Configure AWS and install required tools
2. ☸️ Provision or configure an EKS cluster
3. 📦 Create Amazon ECR repositories
4. 🐳 Build and push frontend and backend Docker images
5. 🚀 Apply Kubernetes deployment manifests
6. 🧹 Clean up EKS and ECR resources when required

#### ▶️ Run

```bash
cd deployment
bash scripts/full.sh
```

> **⚠️ Important:** AWS credentials, IAM permissions, cloud resources, and
> expected costs must be reviewed before running this workflow.

---

### 3. 📊 [Server Health Monitoring](./Monitoring/)

| Details | Description |
| --- | --- |
| **Purpose** | Monitor server health and send alerts when thresholds are exceeded |
| **Configuration** | [`config.sh`](./Monitoring/config.sh) |
| **Main script** | [`monitor.sh`](./Monitoring/monitor.sh) |
| **Documentation** | [`Monitoring/readme.md`](./Monitoring/readme.md) |

#### 📈 Monitored Health Checks

- 🧠 CPU usage
- 💾 Memory usage
- 💽 Disk usage
- ⚙️ Critical service status
- ✉️ Email alert delivery
- 📝 Daily log creation
- 🔄 Automatic log rotation for logs older than seven days
- ⏰ Cron-based scheduling

#### ▶️ Run

```bash
cd Monitoring
chmod +x config.sh monitor.sh
./config.sh
./monitor.sh
```

> **💡 Configuration:** Update thresholds, email settings, and monitored
> services in `config.sh` before starting the monitor.


---

## 🧰 General Requirements

| Requirement | Used by | Notes |
| --- | --- | --- |
| 🐧 Linux with Bash | All projects | Scripts are designed for Bash-compatible Linux environments |
| 🔐 Root or `sudo` access | User Management | Required for `useradd`, `userdel`, `usermod`, and related operations |
| ☁️ AWS CLI, `eksctl`, Docker, `kubectl` | Deployment | Required for AWS and Kubernetes automation |
| ✉️ `mailutils` or equivalent | Monitoring | Required to send email alerts |

---

## 🚦 Recommended Starting Path

1. 📚 Read this overview.
2. 📂 Open the project that matches your use case.
3. 📖 Read that project’s local `readme.md` file.
4. ⚙️ Review configuration and required permissions.
5. 🧪 Test scripts in a safe environment.
6. 🚀 Run the workflow only after validating the setup.

---

## 👨‍💻 Author

**Akash Kayande**  
*DevOps • AWS • Terraform • Kubernetes*

---

<div align="center">

⭐ If you find these projects useful, consider giving the repository a star!

</div>
