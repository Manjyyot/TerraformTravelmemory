# Travel Memory - Cloud Deployment (AWS + Terraform + Docker)

## Project Overview

This project deploys a three-tier web application to AWS using Docker containers, Terraform for infrastructure-as-code, and manual provisioning scripts. It includes auto-scaling, high availability, and reverse proxy routing via Nginx.

**Tech Stack:**
- Frontend: React.js
- Backend: Node.js/Express
- Database: MongoDB
- Infra: AWS (EC2, ECS Fargate, ALB, Auto Scaling)
- IaC: Terraform
- Containerization: Docker
- Routing: Nginx reverse proxy

---

## Environment Setup

### Backend `.env` File

Create a `.env` file for the backend:
```env
MONGO_URI='your_mongo_uri'
PORT=3001
```

### Frontend `.env` File

```env
REACT_APP_BACKEND_URL=http://your-backend-ip:3001
```

---

## Infrastructure Setup (Terraform)

This project provisions:
- VPC with public subnet
- EC2 instances: MongoDB, Backend, Frontend (Docker-based)
- ECS cluster (Fargate) for auto-scaling backend/frontend containers
- ALB (Application Load Balancer) to route external traffic
- Auto-scaling group to scale frontend/backend tasks
- Security Groups to enforce traffic boundaries

### Run Infrastructure:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Outputs will include public IPs for:
- MongoDB instance
- Backend server
- Frontend server

---

## Docker Deployment (Automated)

Shell provisioning scripts automatically:
- Install Docker
- Clone the GitHub repo
- Build and run containers for backend and frontend
- Load environment variables from `.env` file

---

## Nginx Reverse Proxy Configuration

The frontend instance also runs an Nginx server to route traffic.

### Nginx Config (default.conf):

```nginx
server {
    listen 80;

    location /api/ {
        proxy_pass http://<backend_instance_ip>:3001/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    location / {
        proxy_pass http://localhost:80;
        try_files $uri $uri/ /index.html;
    }
}
```

Place this file inside the container at:
```
/etc/nginx/conf.d/default.conf
```

The container should be built with:
```dockerfile
FROM nginx:alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html
```

---

## ECS + ALB + Auto Scaling Setup

The backend and frontend are containerized and deployed to ECS using Fargate. Terraform provisions:
- ECS Cluster
- Task Definitions (backend, frontend)
- ECS Services connected to ALB
- Target Groups + Health Checks
- Auto-scaling based on CPU usage

Auto-scaling configuration:
- Min Tasks: 2
- Max Tasks: 10
- Target CPU Utilization: 60%

ALB Listeners forward traffic:
- Port 80 → Frontend Container
- Port 80 `/api` route → Backend Container

---

## Output of Deployment

After `terraform apply`, you get:
- Public IP of MongoDB EC2
- Public IP of Frontend EC2
- Public IP of Backend EC2
- ALB DNS Name for ECS services

You can access the full app via:
```
http://<alb_dns_name>
```

---

## Project Deliverables

| Requirement | Implemented |
|-------------|-------------|
| Dockerized App | Yes |
| MongoDB Setup | Yes (Docker on EC2) |
| AWS Infra via Terraform | Yes |
| ALB Integration | Yes |
| ECS with Auto Scaling | Yes |
| Nginx Reverse Proxy | Yes |
| Environment Variables | Managed via .env |
| Outputs | Terraform outputs IPs |
| CI/CD | Optional, can be added |
| Documentation | This README |

---

## Manual Access & Testing

```bash
# SSH into backend server
ssh -i keys/newManjyyot.pem ubuntu@<backend_instance_ip>

# Check running containers
docker ps
```

---

## Conclusion

This deployment demonstrates a full production-grade environment for a containerized web app using AWS native services. Infrastructure is provisioned using Terraform, and app components are deployed using Docker with auto-scaling via ECS. Nginx provides routing and reverse proxy for a unified user experience.
