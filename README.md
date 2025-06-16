# DOKS MANAGER 
*(aka, "DigitalOcean Kubernetes Manager")*

## Project Description
This Terraform repo deploys and maintains Kubernetes clusters for running an application and a Postgresql database on the cloud hosting platform DigitalOcean.  

This originally was my IaaC solution for one of my Rails projects, but reusability came to mind so I have continue to migrate it towards a reusable, user-friendly (and well-documented) Terraform Module with which anyone can instantly create their own ready-to-go Kubernetes clusters and databases with minimal effort.

## Requirements
- Terraform Cloud
- Digital Ocean Account

## Current Features
- Creates Kubernetes cluster.
- Creates Kubernetes Postgresql cluster.
- Creates firewall permissions.
- Creates basic database defaults.
- Completely customizable through variables inherited through the user's own Terraform Cloud workspace variables.

## Future Features
- [ ] Customized GitHub actions with plan/apply/validation jobs.
- [ ] More dynamic to allow for limitless whitelisting.
- [ ] Scaling options
- [ ] Instructions for future users :)


DOCTL Setup
[Digital Ocean DOCTL docs](https://docs.digitalocean.com/reference/doctl/how-to/install/)
`brew install doctl`
