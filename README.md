# Travel Memory

`.env` file to work with the backend after creating a database in mongodb: 

```
MONGO_URI='ENTER_YOUR_URL'
PORT=3001
```

Data format to be added: 

```json
{
    "tripName": "Incredible India",
    "startDateOfJourney": "19-03-2022",
    "endDateOfJourney": "27-03-2022",
    "nameOfHotels":"Hotel Namaste, Backpackers Club",
    "placesVisited":"Delhi, Kolkata, Chennai, Mumbai",
    "totalCost": 800000,
    "tripType": "leisure",
    "experience": "Lorem Ipsum, Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum,Lorem Ipsum, ",
    "image": "https://t3.ftcdn.net/jpg/03/04/85/26/360_F_304852693_nSOn9KvUgafgvZ6wM0CNaULYUa7xXBkA.jpg",
    "shortDescription":"India is a wonderful country with rich culture and good people.",
    "featured": true
}
```


For frontend, you need to create `.env` file and put the following content (remember to change it based on your requirements):
```bash
REACT_APP_BACKEND_URL=http://localhost:3001
```

# **Three-Tier Application Deployment with AWS, Terraform, and Jenkins**

## **Project Overview**
This project sets up and deploys a **three-tier web application** on **AWS** using **Terraform** for infrastructure provisioning and **Jenkins** for CI/CD automation.

The application consists of:
- **Frontend:** React.js (hosted on an EC2 instance)
- **Backend:** Node.js API server (running on a separate EC2 instance)
- **Database:** MongoDB (running on its own EC2 instance)

To simplify deployment, **shell scripts** (`backend_setup.sh`, `frontend_setup.sh`, `mongodb_setup.sh`) are used to automate the installation of necessary dependencies.

---

## **Infrastructure Setup**
The following AWS resources are provisioned using Terraform:
- **EC2 Instances**
  - Frontend Server (React.js)
  - Backend Server (Node.js)
  - Database Server (MongoDB)
- **Security Groups**
  - Configured for proper network isolation
- **Default VPC & Subnets**
  - Used for simplicity
- **Provisioning via Shell Scripts**
  - Automates package installation and service configuration

---

## **CI/CD Pipeline (Jenkins)**
The Jenkins pipeline automates the following tasks:
1. **Cloning the Application Code** from GitHub
2. **Provisioning Infrastructure** using Terraform
3. **Deploying the Backend, Frontend, and Database**
4. **Testing & Validation**

The **Jenkins pipeline** uses shell scripts to install required software and start services automatically.

---

## **Deployment Steps**
### **1. Infrastructure Setup using Terraform**
```sh
cd terraform
terraform init
terraform apply -auto-approve
```
This provisions all required AWS resources.

### **2. Configure EC2 Instances (Using Shell Scripts)**
After Terraform creates the instances, the following shell scripts will configure each instance with the necessary dependencies and services.

#### **Backend Setup**
```sh
ssh -i your-key.pem ubuntu@backend-ip 'bash -s' < scripts/backend_setup.sh
```

- Installs Node.js, npm, and required backend dependencies.
- Clones the backend repository.
- Configures environment variables (`.env`).
- Starts the backend server using `nohup` to ensure it runs in the background.

#### **Frontend Setup**
```sh
ssh -i your-key.pem ubuntu@frontend-ip 'bash -s' < scripts/frontend_setup.sh
```

- Installs Node.js, npm, and Nginx.
- Clones the frontend repository.
- Builds the frontend project.
- Deploys frontend files to /var/www/html/.
- Configures Nginx as a reverse proxy for serving the React frontend.
- Restarts Nginx to apply changes.

#### **MongoDB Setup**
```sh
ssh -i your-key.pem ubuntu@mongodb-ip 'bash -s' < scripts/mongodb_setup.sh
```

- Installs MongoDB and necessary dependencies.
- Starts and enables the MongoDB service.
- Configures MongoDB to accept connections only from the backend instance.
- Ensures correct permissions and security settings.

---

### **3. Run the Jenkins Pipeline**
The Jenkins pipeline is configured to **automatically trigger on a push to the `main` branch**.  

#### **CI/CD Workflow**
1. **Developer pushes code to GitHub (`main` branch).**  
2. **Jenkins automatically triggers the pipeline.**  
3. **Pipeline stages:**
   - Clones the latest code.
   - Provisions AWS infrastructure using Terraform.
   - Deploys the backend, frontend, and MongoDB using pre-configured shell scripts.

#### **Manually Triggering the Pipeline (Optional)**
If needed, the pipeline can also be triggered manually from the **Jenkins Dashboard**:
- Go to **Jenkins → Pipeline Job**.
- Click **"Build Now"**.

---

## **Security Considerations**
- **Security Groups** restrict traffic between tiers.
- **MongoDB is secured** by allowing only the backend instance to connect.
- **Environment Variables** are securely managed.
- **AWS Parameter Store** can be used for storing sensitive credentials.

---

## **Conclusion**
This project successfully automates the deployment of a **three-tier web application** using AWS, Terraform, and Jenkins. With Jenkins set up for **automated CI/CD**, every push to the `main` branch triggers an end-to-end deployment. The use of **shell scripts** simplifies instance setup and ensures a smooth deployment experience. 🎯
