# Challenge README

This repository contains solutions for three assignments related to AWS, scripting, and system troubleshooting.

## Assignment 1: CloudFront + S3 Setup

* Created one CloudFront distribution without custom CNAMEs.
* Hosted static content on two S3 buckets.
* Root path shows: **"Hello, CDN origin is working fine"**
* `/devops-folder/` path points to second S3 bucket and shows: **"Hello, CDN 2 origin is working fine"**
* Configured behavior to cache objects in edge locations for at least 48 hours.
* Terraform scripts used for automation.

Directory:

```
content/
terraform/
scripts/
```

## Assignment 2: Log Parsing Script

* Script extracts top 8 IP addresses by number of hits from a log file.
* No file extension, executable file.
* Outputs IP and hit count.
* Log file included for testing.

Directory:

```
assignment-2/
```

## Assignment 3: High Load Troubleshooting

* Analyzed high load average on a Linux server.
* Listed commands and what to look for to identify CPU, memory, I/O or process issues.
* Simple issue‑diagnosis approach documented.

Directory:

```
assignment-3/
```

## Project Structure

```
content/          # S3 site files
terraform/        # CloudFront + S3 IaC
scripts/          # Deployment scripts
assignment-2/     # Log analysis script
assignment-3/     # Troubleshooting notes
```

## Notes

* Built using AWS Free Tier resources.
* Simple and minimal setup focused on functionality.
