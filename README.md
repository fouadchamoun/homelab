# Homelab

[![Cloudflare](https://github.com/fouadchamoun/homelab/actions/workflows/cloudflare.yml/badge.svg)](https://github.com/fouadchamoun/homelab/actions/workflows/cloudflare.yml)

This repository contains the configuration for my personal homelab environment. It is managed using a combination of Ansible and Terraform to automate the setup and maintenance of various services.

## Repository Structure

- `pve/`: Ansible playbooks and Terraform configurations for managing a Proxmox Virtual Environment (PVE) cluster.

- `kube/`: Ansible playbook for managing a Kubernetes cluster.

- `docker-00/`: Ansible playbook for setting up a Docker host.

- `cloudflare/`: Terraform configurations for managing Cloudflare resources. This includes DNS records, Zero Trust policies, and other Cloudflare settings.

- `cloudflare/ad_block`: Terraform configuration for deploying an ad-blocking solution using Cloudflare Zero Trust Gateway Policies.

## Technologies Used

- **Ansible**: configuration management and application deployment.
- **Terraform**: infrastructure as code to manage resources in Proxmox and Cloudflare.
- **Proxmox Virtual Environment (PVE)**: virtualization platform.
- **Cloudflare**: DNS management and Zero Trust security.
- **Linstor**: software-defined storage for PVE & Kubernetes.
- **Traefik**: reverse proxy and load balancer.

## Contributing

This is a personal project, but feel free to open an issue or submit a pull request if you have any suggestions or find any problems.
