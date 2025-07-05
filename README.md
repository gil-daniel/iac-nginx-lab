# 🧱 IaC NGINX Lab: Load-Balanced Linux VMs on Azure Using Modular Bicep

**License:** MIT  
**Status:** Complete

This project automates the deployment of a production-ready environment using modular [Azure Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) templates. It provisions multiple Ubuntu virtual machines (VMs) behind a Load Balancer, with NGINX installed and configured automatically via a custom script extension.

---

## 🚀 What It Deploys

- ✅ Virtual Network (VNet), Subnet, and Network Security Group (NSG)
- ✅ Azure Load Balancer (Standard SKU) with health probe and rule
- ✅ Static Public IP attached to Load Balancer frontend
- ✅ Multiple Ubuntu Linux VMs (default: 2)
- ✅ Automatic NGINX installation using Custom Script Extension
- ✅ Secure SSH access via public key

---

## 📁 Project Structure

```plaintext
iac-nginx-lab/
├── main.bicep                 # Coordinates all module deployments
├── parameters.json            # Input parameters (private, not versioned)
├── parameters.example.json    # Template with placeholder values
├── README.md                  # Project documentation
├── scripts/
│   └── install-nginx.sh       # Bash script executed by VMs to install NGINX
└── modules/
    ├── network.bicep          # VNet, Subnet, NSG configuration
    ├── loadbalancer.bicep     # Load Balancer, health probe, rule, and IP
    └── vm-multi.bicep         # Multiple Ubuntu VMs with NICs and extensions
```

# 🧪 How to Deploy

* Prerequisites:
* Azure CLI installed and authenticated
* SSH public key available
* parameters.json file created from example

Deployment command:
```bash
az deployment group create \
  --resource-group <your-resource-group> \
  --template-file main.bicep \
  --parameters @parameters.json
```
# 📤 Deployment Output

After deployment completes, the output will include the Load Balancer’s public IP:
```json
{
  "loadBalancerIp": "xx.xx.xx.xx"
}
```
You can access the NGINX welcome page via:
```bash
curl http://xx.xx.xx.xx
```
Each response will indicate the VM instance name (e.g., nginxvm-0, nginxvm-1).

# 🔐 Security

* Password-based login is disabled
* SSH access is secured using public key authentication
* NSG only allows inbound traffic on ports:
    TCP 22 (SSH)
    TCP 80 (HTTP for NGINX)

# 🧰 Script: install-nginx.sh

Automatically executed on all VMs during provisioning:
```bash
# Update package lists and install NGINX
sudo apt update -y
sudo apt install nginx -y

# Set custom index page with hostname
echo "Instance: $(hostname)" | sudo tee /var/www/html/index.html

# Ensure NGINX runs on startup
sudo systemctl enable nginx
sudo systemctl start nginx
```
# 🛠️ Tech Stack

* Infrastructure as Code: Azure Bicep (modular architecture)
* Provisioning: Azure CLI
* OS: Ubuntu Server 22.04 LTS
* Automation: Custom Script Extension
* Web: NGINX
* Monitoring basics: curl, access logs, health probe

# 📎 Notes
* This project was built from scratch to demonstrate advanced infrastructure automation for DevOps/SRE roles
* The modular Bicep architecture follows best practices for scalability and reusability
* Ideal for portfolio demonstration, lab experimentation, or adapting to production environments

📜 License

MIT License — free to use and extend.