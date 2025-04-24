# mwi-demo-cluster

IaC for the MWI Demo cloud cluster.

This repo contains Teleport resources for the [MWI demo cluster](https://mwidemo.cloud.gravitational.io).

The `initial_resources` directory contains the two resources you need to create
via `tctl create -f` so that HCP Terraform can do runs against the Teleport cluster.

## Resources

`terraform/aws_staging_manager` contains a Workload Identity, Role and Bot to issue
a SPIFFE ID for a bot that can manage an AWS account. This is used in the MWI Demo 
Resources repo in a GitHub Action to create and manage resources for the demo 
environment using Terraform.
