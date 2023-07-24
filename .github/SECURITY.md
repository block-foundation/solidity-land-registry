# Security Policy

_Last updated on: 2023-01-01_



**This following Security Policy outlines security procedures and general 
policies we take to ensure the safety and security of the Open Source projects 
of the Block Foundation, as found on our GitHub repositories at: 
[https://github.com/block-foundation](https://github.com/block-foundation).**


---

**Table of Contents**
  * [Security Contact](#security-contact)
  * [Security Conventions](#security-conventions)
  * [Vulnerability Reporting](#vulnerability-reporting)
  * [Public Disclosure Process](#public-disclosure-process)
  * [Patch and Release Process ](#patch-and-release-process-process)

---


## Security Contact
 
If you have any questions or concerns, please contact us at:
**[security@blockfoundation.io](mailto:security@blockfoundation.io)**.

```
security@blockfoundation.io
```

## Security Conventions

We take security seriously and are committed to protecting our users and follow 
the following conventions:

1. **Access Control** \
Access to our repository is restricted to authorized individuals and teams. 
Passwords are required for all accounts and are regularly rotated. 
Where possible, Two-factor Authentication is also required for all accounts.

2. **Vulnerability Reporting** \
We have a vulnerability reporting procedure in place, please see the:
['Vulnerability Reporting'](#vulnerability-reporting) section in this document.

3. **Third-Party Code** \
We take care to use only reputable third-party libraries and frameworks, 
and keep them updated to the latest version. Any vulnerabilities in 
third-party code will be addressed as soon as possible.

4. **Encryption** \
All sensitive data and communications are encrypted whenever and whereever 
possible.

5. **Backups** \
Regular backups of important data are taken to ensure it can be recovered in 
case of a security incident.

6. **Auditing** \
We regularly audit our repository for potential security issues using code 
scanning tools.

7. **Response Plan** \
We have a plan in place for responding to security incidents, including how 
to contain, eradicate, and recover from a security incident.


## Vulnerability Reporting

Security is of the highest importance and yhe the Block Foundation team takes all 
security vulnerabilities very seriously. 
If you discover a potential security vulnerability in our code, please report 
it to us privately, to minimize negative implications before it has been fixed.


Please report (suspected) security vulnerabilities with its details, by 
emailing our Security Team at:
**[security@blockfoundation.io](mailto:security@blockfoundation.io)**. 


> **IMPORTANT: Do not file public issues on GitHub for security vulnerabilities**


> **When to report a vulnerability**
> - When you think the open source software has a potential security 
vulnerability.
> - When you suspect a potential vulnerability but you are unsure of it impacts.
> - When you know of or suspect a potential vulnerability on another project 
that is used within this project. 


> **Proposed Email Content** \
> Provide a descriptive subject line and in the body of the email include the 
> following information:
> - Basic identity information, such as your name and your affiliation or company.
> - Detailed steps to reproduce the vulnerability (POC scripts, screenshots, 
and compressed packet captures are all helpful to us).
> - Description of the effects of the vulnerability and the related hardware 
and software configurations, so that the Security Team can reproduce it.
> - How the vulnerability affects Harbor usage and an estimation of the attack 
surface, if there is one.
> - List other projects or dependencies that were used in conjunction in order 
to produce the vulnerability.


## Public Disclosure Process

We very much appreciate your efforts to improve the security of our open source
software and responsible disclosure and will make every effort to acknowledge
your contributions.

We will investigate all reports and you will receive a response from the lead
maintainer as soon as possible, indicating the next steps in handling your report.
If the issue is confirmed, we will release a patch as soon as possible,
depending on complexity but historically within a few days.
After the initial reply to your report, the Security Team will endeavor
to keep you informed of the progress towards a fix and full announcement,
and may ask for additional information or guidance.

## Patch and Release Process

When the Security Team receives a security vulnerability report, they will
assign it to a primary handler. This person will coordinate the patch and
release process, involving the following steps:

1. The Security Team will investigate the vulnerability and confirm the problem.
2. If the issue is not deemed to be a vulnerability, the Security Team will
disclose a detailed reason for rejection, and initiate a conversation with the
reporter as soon as possible.
3. Determine the effects and criticality of the vulnerability and determine the
affected versions.
4. If a vulnerability is acknowledged, the effects and criticality and affected
versions of the vulnerability are determine.
5. The timeline for a fix is determined, the Security Team will work on a plan
to communicate with the appropriate community members, including identifying
mitigating steps that affected users can take to protect themselves until the
fix is rolled out.
6. The Security Team will work on fixing the vulnerability for all releases
still under maintenance, and perform internal testing before preparing to roll
out the fixes.
7. Once the fix is confirmed, the Security Team will patch the vulnerability in
the next patch or minor release.
