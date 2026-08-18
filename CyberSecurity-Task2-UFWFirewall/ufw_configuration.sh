# Task 2 — Basic Firewall Configuration with UFW

## Oasis Infobyte Internship Program


---

## 1. Objective

The objective of this task is to set up and configure a basic Linux firewall using UFW (Uncomplicated Firewall).

UFW was configured to control incoming and outgoing network traffic by defining which services should be allowed and denied.

The configuration and testing were performed in a controlled virtual laboratory environment using Ubuntu Linux as the firewall target and Kali Linux as the testing machine.

The main objectives of this task were:

- Install and configure UFW.
- Enable the firewall.
- Set the default incoming policy to deny.
- Set the default outgoing policy to allow.
- Allow SSH traffic on port 22.
- Deny HTTP traffic on port 80.
- Configure at least two additional firewall rules.
- Verify the firewall configuration.
- Test the firewall rules from Kali Linux.
- Analyze the security implications of the configured rules.
- Document the configuration and testing results.

---

# 2. Lab Environment

| Component | Details |
|-----------|---------|
| Firewall / Target | Ubuntu Linux |
| Testing Machine | Kali Linux |
| Target IP Address | `192.168.0.103` |
| Firewall | UFW (Uncomplicated Firewall) |
| Scanning / Testing Tool | Nmap |
| Virtualization | Oracle VirtualBox |

Ubuntu Linux was used as the target system where the UFW firewall was configured.

Kali Linux was used as the testing machine to verify whether the configured firewall rules successfully filtered network traffic.

---

# 3. UFW Installation

## 3.1 Installing UFW

UFW was installed on the Ubuntu system using the following command:

```bash
sudo apt install ufw
```

UFW (Uncomplicated Firewall) provides a simplified interface for managing firewall rules on Linux systems.

---

# 4. Enabling the Firewall

## 4.1 Enable UFW

After installation, UFW was enabled using:

```bash
sudo ufw enable
```

The firewall was successfully activated.

### Screenshot — UFW Enabled



---

# 5. Default Firewall Policies

The firewall was configured using a default-deny approach for incoming traffic.

The following commands were used:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

## 5.1 Incoming Traffic

The default incoming policy was set to:

```text
deny
```

This means incoming network connections are blocked unless an explicit firewall rule allows them.

This approach reduces the attack surface by preventing unnecessary incoming connections.

## 5.2 Outgoing Traffic

The default outgoing policy was set to:

```text
allow
```

This allows the Ubuntu system to initiate normal outbound network connections.

---

# 6. Firewall Rules Configuration

The following firewall rules were configured.

## 6.1 Allow SSH — Port 22

SSH was allowed using:

```bash
sudo ufw allow ssh
```

SSH normally uses TCP port 22 and is commonly used for secure remote administration.

SSH was allowed because remote administration may be required to manage the Ubuntu system.

### Security Considerations

Although SSH provides encrypted communication, exposing SSH can increase the attack surface.

Potential risks include:

- Brute-force login attempts.
- Password-based attacks.
- Unauthorized access if credentials are compromised.

Recommended security measures include:

- Use strong passwords.
- Prefer SSH key-based authentication.
- Keep OpenSSH updated.
- Restrict SSH access to trusted networks where possible.

---

## 6.2 Deny HTTP — Port 80

HTTP was denied using:

```bash
sudo ufw deny http
```

HTTP normally uses TCP port 80.

HTTP does not provide TLS encryption for normal web traffic, so it was blocked in this firewall configuration.

### Security Considerations

Blocking HTTP reduces exposure to unencrypted web traffic when HTTP is not required.

HTTPS can be used instead when encrypted web communication is required.

---

## 6.3 Allow HTTPS — Port 443

HTTPS was allowed using:

```bash
sudo ufw allow https
```

HTTPS normally uses TCP port 443 and provides encrypted communication using TLS.

HTTPS was allowed because encrypted web communication is preferred over unencrypted HTTP.

### Security Considerations

HTTPS should still be securely configured.

Recommended security measures include:

- Use valid TLS certificates.
- Keep the web server updated.
- Disable outdated TLS protocols.
- Use secure cryptographic configurations.

---

## 6.4 Deny FTP — Port 21

FTP was denied using:

```bash
sudo ufw deny ftp
```

FTP normally uses TCP port 21.

FTP was denied because it is an older file transfer protocol and does not provide the same level of protection as encrypted alternatives.

Blocking FTP also reduces unnecessary exposure when the service is not required.

---

# 7. Final Firewall Configuration

After applying the rules, the firewall configuration was checked using:

```bash
sudo ufw status verbose
```

The final configuration showed:

```text
Status: active

Default: deny (incoming)
Default: allow (outgoing)

22/tcp  ALLOW  SSH
80/tcp  DENY   HTTP
443/tcp ALLOW  HTTPS
21/tcp  DENY   FTP
```

### Screenshot — Final UFW Status



The screenshot shows that the firewall was active and that the configured rules were applied successfully.

---

# 8. Firewall Rules Summary

| Port | Protocol | Service | Rule | Purpose |
|------|----------|---------|------|---------|
| 22 | TCP | SSH | ALLOW | Permit secure remote administration |
| 80 | TCP | HTTP | DENY | Block unencrypted HTTP traffic |
| 443 | TCP | HTTPS | ALLOW | Permit encrypted web traffic |
| 21 | TCP | FTP | DENY | Block insecure FTP traffic |

The firewall follows a default-deny policy for incoming traffic and explicitly permits only the services that are required.

---

# 9. Firewall Configuration Script

To make the firewall configuration reproducible, the rules were also documented in a shell script named:

```text
ufw_configuration.sh
```

The script contains the complete configuration sequence.

```bash
#!/bin/bash

# UFW Firewall Configuration
# Oasis Infobyte Cyber Security Internship - Task 2

echo "Starting UFW firewall configuration..."

# Enable UFW firewall
sudo ufw --force enable

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow ssh

# Deny HTTP
sudo ufw deny http

# Allow HTTPS
sudo ufw allow https

# Deny FTP
sudo ufw deny ftp

# Display firewall status
sudo ufw status verbose

echo "UFW firewall configuration completed."
```

The same script is included separately in the project repository as:

```text
ufw_configuration.sh
```

This allows the firewall configuration to be reproduced in a controlled environment.

---

# 10. Firewall Testing

## 10.1 Testing Method

After configuring UFW, the firewall was tested from the Kali Linux virtual machine.

The Ubuntu target IP address was:

```text
192.168.0.103
```

Nmap was used to test the selected ports.

The following command was executed from Kali Linux:

```bash
nmap -p 21,22,80,443 192.168.0.103
```

The scan checked the status of:

- Port 21 — FTP
- Port 22 — SSH
- Port 80 — HTTP
- Port 443 — HTTPS

---

# 11. Firewall Testing Results

The Nmap scan produced the following results:

```text
21/tcp   filtered   ftp
22/tcp   open       ssh
80/tcp   filtered   http
443/tcp  open       https
```

### Screenshot — Firewall Testing from Kali Linux

[INSERT YOUR KALI NMAP TESTING SCREENSHOT HERE]

---

# 12. Testing Result Analysis

## Port 21 — FTP

The result was:

```text
21/tcp filtered ftp
```

The firewall rule for FTP was:

```text
DENY 21/tcp
```

The port was reported as `filtered`, indicating that network filtering prevented Nmap from determining normal access to the port.

This result is consistent with the configured firewall rule.

**Result: FTP successfully filtered.**

---

## Port 22 — SSH

The result was:

```text
22/tcp open ssh
```

The firewall rule was:

```text
ALLOW 22/tcp
```

The port remained accessible from Kali Linux.

This confirms that the SSH allow rule was working as expected.

**Result: SSH successfully allowed.**

---

## Port 80 — HTTP

The result was:

```text
80/tcp filtered http
```

The firewall rule was:

```text
DENY 80/tcp
```

The port was filtered by the firewall.

This confirms that HTTP traffic was successfully blocked.

**Result: HTTP successfully filtered.**

---

## Port 443 — HTTPS

The result was:

```text
443/tcp open https
```

The firewall rule was:

```text
ALLOW 443/tcp
```

The port remained accessible from Kali Linux.

This confirms that HTTPS traffic was allowed by the firewall.

**Result: HTTPS successfully allowed.**

---

# 13. Firewall Testing Summary

| Port | Service | Firewall Rule | Nmap Result | Expected | Status |
|------|---------|---------------|-------------|----------|--------|
| 21 | FTP | DENY | Filtered | Blocked | PASS |
| 22 | SSH | ALLOW | Open | Allowed | PASS |
| 80 | HTTP | DENY | Filtered | Blocked | PASS |
| 443 | HTTPS | ALLOW | Open | Allowed | PASS |

The testing results were consistent with the configured UFW rules.

---

# 14. Security Analysis

## 14.1 Default-Deny Incoming Policy

The default incoming policy was configured as:

```text
deny
```

This means that incoming connections are blocked unless they are explicitly allowed.

A default-deny approach helps reduce the attack surface by limiting unnecessary network exposure.

---

## 14.2 SSH — Port 22

SSH provides secure remote administration.

However, an exposed SSH service can be targeted by attackers through:

- Brute-force attacks.
- Password attacks.
- Credential theft.
- Unauthorized remote access attempts.

Security recommendations:

- Use strong passwords.
- Prefer SSH key authentication.
- Keep OpenSSH updated.
- Restrict SSH access to trusted networks.
- Monitor authentication attempts.

---

## 14.3 HTTP — Port 80

HTTP was blocked because normal HTTP traffic does not provide TLS encryption.

Blocking unnecessary HTTP traffic can reduce exposure to unencrypted communications.

When web access is required, HTTPS should be preferred.

---

## 14.4 HTTPS — Port 443

HTTPS was allowed because it provides encrypted communication using TLS.

However, allowing HTTPS does not automatically make the web service secure.

The web server should:

- Use valid certificates.
- Use secure TLS settings.
- Disable obsolete protocols.
- Remain patched and updated.
- Be securely configured.

---

## 14.5 FTP — Port 21

FTP was blocked because it is an older file transfer protocol and should not be exposed when it is unnecessary.

Blocking unnecessary services helps reduce the overall attack surface.

---

# 15. Overall Security Assessment

The firewall configuration successfully limited incoming network access according to the defined security policy.

The final policy was:

```text
Default incoming: DENY
Default outgoing: ALLOW

SSH 22   → ALLOW
HTTP 80  → DENY
HTTPS 443 → ALLOW
FTP 21   → DENY
```

The Nmap testing results confirmed that:

- SSH was accessible.
- HTTPS was accessible.
- HTTP was filtered.
- FTP was filtered.

This demonstrates that the UFW firewall was successfully enforcing the configured network access rules.

---

# 16. Ethical Considerations

All firewall configuration and testing activities were performed in a controlled laboratory environment.

The Ubuntu machine was used as the authorized firewall target.

The Kali Linux machine was used as the authorized testing machine.

The Nmap scan was performed only against the Ubuntu virtual machine:

```text
192.168.0.103
```

No unauthorized public systems, third-party servers, or public networks were scanned.

Network scanning and security testing should only be performed against systems for which the tester has explicit authorization.

---

# 17. Tools Used

### Ubuntu Linux

Used as the firewall target and system where UFW was configured.

### Kali Linux

Used as the testing machine.

### UFW

Used to configure and manage Linux firewall rules.

### Nmap

Used to test the accessibility and filtering behavior of selected network ports.

### Oracle VirtualBox

Used to run the Ubuntu and Kali Linux virtual machines.

---

# 18. Commands Used

### Install UFW

```bash
sudo apt install ufw
```

### Enable UFW

```bash
sudo ufw enable
```

### Set Default Incoming Policy

```bash
sudo ufw default deny incoming
```

### Set Default Outgoing Policy

```bash
sudo ufw default allow outgoing
```

### Allow SSH

```bash
sudo ufw allow ssh
```

### Deny HTTP

```bash
sudo ufw deny http
```

### Allow HTTPS

```bash
sudo ufw allow https
```

### Deny FTP

```bash
sudo ufw deny ftp
```

### Check Firewall Status

```bash
sudo ufw status verbose
```

### Test Firewall from Kali

```bash
nmap -p 21,22,80,443 192.168.0.103
```

---

# 19. Evidence

The following screenshots document the actual practical work performed during this task:

1. UFW firewall activation.
2. Final UFW firewall configuration.
3. Kali Linux Nmap firewall testing.

The screenshots demonstrate the configuration and testing of the firewall in the virtual laboratory environment.

---

# 20. Conclusion

The Basic Firewall Configuration with UFW task successfully demonstrated the configuration and testing of a Linux firewall.

UFW was enabled on the Ubuntu target and configured with a default-deny incoming policy and default-allow outgoing policy.

The following firewall rules were implemented:

- **Port 22 — SSH — ALLOW**
- **Port 80 — HTTP — DENY**
- **Port 443 — HTTPS — ALLOW**
- **Port 21 — FTP — DENY**

The firewall configuration was verified using:

```bash
sudo ufw status verbose
```

Testing was then performed from Kali Linux using:

```bash
nmap -p 21,22,80,443 192.168.0.103
```

The resulting scan showed:

```text
21/tcp   filtered   ftp
22/tcp   open       ssh
80/tcp   filtered   http
443/tcp  open       https
```

The results matched the configured firewall rules. SSH and HTTPS remained accessible, while HTTP and FTP were filtered.

This task demonstrated how UFW can be used to control network access, reduce unnecessary exposure, and implement basic firewall security policies on a Linux system.
