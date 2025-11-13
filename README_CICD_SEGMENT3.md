# 🚀 CI/CD Pipeline Setup with Jenkins, SonarQube, Nexus, and Docker

This document describes **Segment 3: CI/CD Setup** for a full-stack DevOps project using **Jenkins**, **SonarQube**, **Nexus**, **Docker**, and **Kubernetes**.

---

## 📋 Prerequisites
Before proceeding, ensure:
- Jenkins is installed and running.
- SonarQube, Nexus, and Docker are accessible from Jenkins.
- GitHub repository is connected.

---

## ⚙️ Step 1: Install Required Jenkins Plugins

**Path:** `Jenkins > Manage Jenkins > Plugins > Available plugins`

Install the following plugins:

| # | Plugin Name |
|---|--------------|
| 1 | SonarQube Scanner |
| 2 | Nexus Artifact Uploader |
| 3 | Docker, Docker Pipeline, docker-build-step, CloudBees Docker Build and Publish |
| 4 | OWASP Dependency-Check |
| 5 | Eclipse Temurin installer (JDK) |
| 6 | Config File Provider (for Nexus) |
| 7 | Pipeline Maven Integration Plugin |
| 8 | Kubernetes |
| 9 | Kubernetes CLI |

---

## 🧰 Step 2: Configure Tools

**Path:** `Jenkins > Manage Jenkins > Tools`

| Tool | Configuration | Version / Notes |
|------|----------------|-----------------|
| **JDK 17** | Name: `jdk17` | Install from `adoptium.net` → `jdk-17.0.9+9` |
| **JDK 11** | Name: `jdk11` | Install from `adoptium.net` → `jdk-11.0.21+9` |
| **SonarQube Scanner** | Name: `sonar-scanner` | Latest version |
| **Maven** | Name: `maven3` | Version: 3.6.3 |
| **OWASP Dependency-Check** | Install from GitHub | Version: 6.5.1 |
| **Docker** | Name: `docker` | Download from `docker.com` → Latest |

---

## 🔐 Step 3: Configure Credentials

### 1️⃣ SonarQube Token
1. Go to **SonarQube → Administration → Security → Users → Tokens**  
2. Generate a new token (e.g., `jenkins-token`)
3. In Jenkins:  
   `Manage Jenkins > Credentials > System > Add Credentials`  
   - Kind: `Secret text`  
   - Secret: `<paste token>`  
   - ID: `sonar-token`

### 2️⃣ Docker Hub Credentials
`Manage Jenkins > Credentials > System > Add Credentials`  
- Kind: `Username with password`  
- Username: `<dockerhub-username>`  
- Password: `<dockerhub-password>`  
- ID: `docker-cred`

---

## 🌐 Step 4: Configure SonarQube Server in Jenkins

**Path:** `Jenkins > Manage Jenkins > System > SonarQube Servers`

| Field | Value |
|--------|--------|
| Name | sonar |
| Server URL | `http://<your-sonarqube-ip>:9000` |
| Server Token | `sonar-token` |

> ✅ Click **Apply and Save**

---

## 🧱 Step 5: Configure Nexus in Jenkins

**Path:** `Jenkins > Manage Jenkins > Managed Files > Add a new Config`

- Type: **Global Maven settings.xml**
- ID: `global-maven`

**Add the following lines (edit credentials as needed):**

```xml
<server>
  <id>maven-releases</id>
  <username>admin</username>
  <password>1111</password>
</server>

<server>
  <id>maven-snapshots</id>
  <username>admin</username>
  <password>1111</password>
</server>
```

### Add Nexus Repositories to `pom.xml`

```xml
<repository>
  <url>http://<your-nexus-ip>:8081/repository/maven-releases/</url>
</repository>

<snapshotRepository>
  <url>http://<your-nexus-ip>:8081/repository/maven-snapshots/</url>
</snapshotRepository>
```

> Commit these changes to your GitHub repository.

---

## 🧩 Step 6: Create a Jenkins Pipeline Job

**Path:** `Jenkins > New Item`

1. Name: `full-stack`
2. Type: `Pipeline`
3. Discard Old Builds → Keep for 100 days, max 2 builds
4. Add pipeline script:

```groovy
pipeline {
    agent any
    tools {
        maven 'maven3'
        jdk 'jdk17'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/xrootms/DevOps-CI-CD-Pipeline.git'
            }
        }

        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }

        stage('Unit Tests') {
            steps {
                sh "mvn test -DskipTests=true"
            }
        }
    }
}
```

---

## 🧪 Verify the Setup

- ✅ Jenkins successfully clones the GitHub repo  
- ✅ Maven compiles without errors  
- ✅ Unit test stage runs successfully  
- ✅ SonarQube and Nexus integrations visible in logs  

---

## 📁 Directory Summary

```
DevOps-CI-CD-Pipeline/
├── pom.xml
├── Jenkinsfile (optional)
├── README.md
└── src/
    └── main/
```

---

## 📚 References

- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [SonarQube Docs](https://docs.sonarqube.org/)
- [Nexus Repository Manager](https://help.sonatype.com/repomanager3)
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)
- [Docker Docs](https://docs.docker.com/)
