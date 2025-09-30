# Homelab

[![Terraform](https://github.com/fouadchamoun/homelab/actions/workflows/terraform.yml/badge.svg?event=workflow_run)](https://github.com/fouadchamoun/homelab/actions/workflows/terraform.yml)

This repository contains the configuration for my personal homelab environment. It is managed using a combination of Ansible and Terraform to automate the setup and maintenance of various services.

## Repository Structure

- `pve/`: Ansible playbooks and Terraform configurations for managing a Proxmox Virtual Environment (PVE).

- `kube/`: Ansible playbook for deploying a Kubernetes cluster using K3s.

- `docker-00/`: Ansible playbook for setting up a Docker host.

- `cloudflare/`: Terraform configurations for managing Cloudflare resources. This includes DNS records, Zero Trust policies, and other Cloudflare settings.

- `cloudflare/ad_block`: Terraform configuration for deploying an ad-blocking solution using Cloudflare Zero Trust Gateway Policies.

## Technologies Used


- **Ansible**: For configuration management and application deployment.
- **Terraform**: For infrastructure as code to manage resources in Proxmox and Cloudflare.
- **Docker**: For containerization of applications.
- **Kubernetes (K3s)**: For container orchestration.
- **Proxmox Virtual Environment (PVE)**: As the virtualization platform.
- **Cloudflare**: For DNS management and Zero Trust security.
- **Linstor**: For software-defined storage for Kubernetes.
- **Traefik**: As a reverse proxy and load balancer.
- **Portainer**: For managing Docker containers.

## Contributing

This is a personal project, but feel free to open an issue or submit a pull request if you have any suggestions or find any problems.
