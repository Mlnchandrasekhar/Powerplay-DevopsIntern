---

# **DevOps Intern Assignment Powerplay**

---

## **📌 Part 1 — Environment Setup**

### **1. Launch EC2 Instance**

* Create a **t2.micro Ubuntu** instance on AWS.
* Download the **private key (.pem)** file.

---

### **2. SSH into the EC2 Instance**

```bash
ssh -i /path/to/key.pem ubuntu@<PUBLIC-IP>
```

---

### **3. Create User `devops_intern` and Assign Passwordless Sudo**

```bash
sudo adduser devops_intern
sudo usermod -aG sudo devops_intern
sudo visudo
```

Add this line inside visudo:

```
devops_intern ALL=(ALL) NOPASSWD:ALL
```

---

### **4. Modify Hostname**

Edit the hostname files:

```bash
sudo nano /etc/hosts
sudo nano /etc/hostname
```

OR use hostnamectl:

```bash
sudo hostnamectl set-hostname yourname-devops
```

---

### **5. Switch User & Verify**

```bash
su - devops_intern
sudo whoami
hostnamectl
```

---

### **6. Attach Screenshot**

Place screenshots in:
`./screenshots/part1/`

```md
![Part 1 Screenshot in the Repo
```

---

# **📌 Part 2 — Simple Web Service Setup**

### **1. Create HTML File**

Create a file that displays:

* Your name
* Instance ID
* Uptime

Example:

```html
<html>
<head>
    <title>Server Info</title>
</head>
<body>
    <h1>Your Name: devops_intern</h1>
    <h2>Instance ID: i-05d4bfb6a91b3a9ac</h2>
    <h2>Server Uptime</h2>
    <pre>(uptime)</pre>
</body>
</html>
```

---

### **2. Install Web Server (Nginx/Apache) or Use Docker**

If using Docker, install prerequisites:

```bash
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Add Docker repo:

```bash
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
```

Install Docker:

```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

---

### **3. Create Dockerfile**

Example:

```dockerfile
FROM nginx:alpine3.22

RUN rm -rf /usr/share/nginx/html/*

COPY index.html /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]
```

---

### **4. Build & Run Container**

```bash
docker build -t imagename .
docker run --name containername -d -p 8080:80 imagename 
```

---

### **5. Access Hosted Page**

Open browser:

```
http://<EC2-PUBLIC-IP>:8080
```

---

### **6. Attach Screenshot**

Place screenshots in:
`./screenshots/part2/`

```md
![Part 2 Screenshot in the Repo
```

---

# **📌 Part 3 — Monitoring Script**

### **1. Create Shell Script**

Create `systemreport.sh` with system information commands or the scriptfile in the repo.

---

### **2. Make Script Executable**

```bash
chmod +x systemreport.sh
```

---

### **3. Create Cronjob**

Open cron:

```bash
sudo crontab -e
```

Create a cron job (runs every 5 minutes):

```
*/5 * * * * /path/to/systemreport.sh >> /var/log/system_report.log 2>&1
```

---

### **4. Verify Logs as we forward the Stdout and Stderr to the log file**

After 5 minutes:

```bash
cat /var/log/system_report.log
```

---

### **5. Attach Screenshot**

Place screenshot in:
`./screenshots/part3/`

```md
![Part 3 Screenshot in the Repo
```

---

# **📌 Part 4 — AWS Integration**

### **1. Create Log Group & Log Stream**

Go to:

```
AWS Console → CloudWatch → Create Log Group → Create Log Stream
```

---

### **2. Install AWS CLI**

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

---

### **3. Configure AWS CLI**

```bash
aws configure
```

Enter:

* Access key
* Secret access key
* Region
* Format

---

### **4. Create IAM Role**

1. Create role with **EC2 service**
2. Attach policy:
   **CloudWatchAgentServerPolicy**
3. Assign role to EC2:
   **EC2 → Actions → Security → Modify IAM Role**

---

### **5. Create Log Stream Pusher Script Given in the Repo **

Using `logstream.sh`:

```bash
chmod +x logstream.sh
```

---

### **6. Create Cronjob to Push Logs**

```bash
sudo crontab -e
```

Add:

```
*/5 * * * * /path/to/logstream.sh >> /var/log/aws_logstream.log 2>&1
```

---

### **7. Verify Logs**

```bash
cat /var/log/aws_logstream.log
```

---

### **8. Attach Screenshot**

Place screenshot in:
`./screenshots/part4/`

```md
![Part 4 Screenshot in the Repo
```

---
