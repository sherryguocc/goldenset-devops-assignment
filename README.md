# 🧭 Goldenset DevOps Home Assignment

This project is part of the **Goldenset “Intern to Hire” DevOps challenge**.  
It demonstrates deploying a **Next.js dashboard application** to **AWS** using basic DevOps practices such as infrastructure automation (Terraform), scalability, and deployment workflow understanding.

---

## 🏗️ Project Overview

The project is based on the official [Next.js Learn Dashboard Tutorial](https://nextjs.org/learn/dashboard-app), located at:

> https://github.com/vercel/next-learn/tree/main/dashboard/final-example

The goal is to:
1. **Deploy** the fully functional dashboard application on AWS.  
2. **Provide** a public URL to the running app.  
3. **Explain** the deployment approach and reasoning.  
4. **Describe** how AI was used during development.  
5. **Reflect** on what could be improved with more time.

---

## 🚀 Deployment Details

### ✅ Approach

I used **AWS EC2** as the deployment target and **Terraform** for Infrastructure as Code (IaC).

**Steps:**
1. Created a dedicated EC2 instance using Terraform scripts inside the `/infra` directory.  
2. Configured the instance with a security group allowing ports `22`, `80`, and `443`.  
3. Used a `user_data` script to automatically:
   - Install Node.js  
   - Clone this GitHub repository  
   - Build and start the Next.js app using **PM2** (process manager)  
4. Exposed the running application publicly via EC2’s DNS at port `3000`.

This approach keeps the setup simple yet clearly demonstrates understanding of:
- AWS networking (VPC, Security Group, EC2)  
- Instance provisioning automation  
- Application lifecycle management  

---

## 🧱 Infrastructure (Terraform)

The **Terraform** configuration is located in the `/infra` folder and contains the following files:

| File | Purpose |
|------|----------|
| `provider.tf` | Defines the AWS provider and region |
| `variables.tf` | Holds configurable variables like region, AMI, instance type |
| `main.tf` | Creates the EC2 instance, security group, and setup script |
| `outputs.tf` | Exposes public IP and DNS for easy access |

After applying Terraform, the public output shows:
Apply complete! Resources: 2 added.
Outputs:
public_ip = "3.xxx.xxx.xxx"
web_url = "http://ec2-3-xxx-xxx-xxx.ap-southeast-2.compute.amazonaws.com:3000"

yaml
Copy code

---

## 🧠 Why This Route

I chose **Terraform + EC2** over managed services like Elastic Beanstalk or Amplify because:
- It gives clearer visibility into underlying AWS resources.
- It demonstrates foundational DevOps knowledge (infrastructure provisioning, SSH access, networking).
- It aligns with the assignment’s purpose: to show problem-solving and infrastructure understanding, not just managed service use.

---

## 🤖 AI Usage

I used **ChatGPT (OpenAI GPT-5)** to:
- Research and validate AWS service options (EC2, Amplify, Terraform).  
- Generate initial Terraform boilerplate (provider, instance, security group).  
- Debug Terraform syntax and `user_data` script commands.  
- Rephrase technical explanations in this README.

AI was used as a **research and code assistant**, not as an automatic deployment tool.  
All code was reviewed, tested, and adjusted manually.

---

## 💡 What Could Be Improved

If given more time, I would:
1. **Add a reverse proxy (Nginx)** to forward port 80 → 3000 and handle SSL (HTTPS).  
2. **Containerize the app with Docker** for consistent runtime environments.  
3. **Automate deployments** using GitHub Actions or AWS CodePipeline.  
4. **Add monitoring** via CloudWatch and implement auto-scaling groups for production-grade availability.  
5. **Use Secrets Manager** to store environment variables securely.

---

## 🔗 Live Application

Once deployed, the app can be accessed at:

> http://<your-ec2-public-dns>:3000  

*(Replace with actual EC2 DNS output from Terraform)*

---

## ⚙️ Infrastructure Setup Commands

To deploy the AWS infrastructure and run the app, follow these steps:

```bash
# Navigate to the infra folder
cd infra

# Initialize Terraform
terraform init

# Preview the deployment plan
terraform plan

# Apply the infrastructure (create EC2 and security group)
terraform apply -auto-approve

# After successful deployment, note down the public IP or DNS from the outputs
# Then open in your browser:
# http://<public-dns>:3000
```
To clean up all resources after testing:
```bash
terraform destroy -auto-approve
```
---

## 📚 Tech Stack Summary

| Layer | Technology |
|--------|-------------|
| Frontend | Next.js 14 + TailwindCSS |
| Backend Runtime | Node.js 18 (via PM2) |
| Infrastructure | Terraform |
| Cloud Provider | AWS (EC2, VPC, Security Group) |
| Version Control | Git + GitHub |
| AI Assistance | OpenAI GPT-5 |


---
## 🧾 License
This project is for educational and assessment purposes only and follows the guidelines of the Goldenset DevOps Intern-to-Hire Program.

---