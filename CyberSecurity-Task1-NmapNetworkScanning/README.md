# Task 1 — Basic Network Scanning with Nmap

## Internship

**Oasis Infobyte Internship Program (OIBSIP)**

## Task

**Task 1: Basic Network Scanning with Nmap**

---

## 1. Objective

The objective of this task is to perform basic network scanning using Nmap in a controlled virtual laboratory environment.

The scanning process is used to:

- Verify network connectivity between the scanning machine and the target machine.
- Identify open TCP ports.
- Identify services running on open ports.
- Detect service and software versions.
- Attempt operating system detection.
- Analyze the security implications of exposed services.
- Document the scanning process and results.

All scanning activities were performed only against an authorized Ubuntu virtual machine in a controlled laboratory environment.

---

## 2. Lab Environment

| Component | Details |
|-----------|---------|
| Scanner | Kali Linux |
| Target | Ubuntu Linux |
| Target IP Address | `192.168.0.103` |
| Scanning Tool | Nmap 7.95 |
| Virtualization | Oracle VirtualBox |

### Network Setup

Kali Linux was used as the scanning machine, while Ubuntu Linux was used as the target machine.

The target Ubuntu machine was assigned the IP address:

```text
192.168.0.103
```

Before performing the scan, network connectivity between Kali Linux and Ubuntu was tested using ICMP ping.

---

# 3. Network Connectivity Test

## 3.1 Purpose

The first step was to verify that Kali Linux could communicate with the Ubuntu target machine.

The `ping` command was used to send four ICMP packets to the target.

## 3.2 Command

```bash
ping -c 4 192.168.0.103
```

## 3.3 Result

The ping test was successful.

The result showed:

- 4 packets transmitted
- 4 packets received
- 0% packet loss

This confirmed that the Kali Linux machine could successfully communicate with the Ubuntu target.

## 3.4 Screenshot

<img width="912" height="661" alt="ping check" src="https://github.com/user-attachments/assets/aeb348a8-847c-4b63-ac00-b52ff64aa24b" />


The screenshot should show the command:

```text
ping -c 4 192.168.0.103
```

and the result:

```text
4 packets transmitted, 4 received, 0% packet loss
```

---

# 4. Basic Nmap Scan

## 4.1 Purpose

After confirming network connectivity, a basic Nmap scan was performed to identify open TCP ports and the services associated with those ports.

## 4.2 Command

```bash
nmap 192.168.0.103
```

## 4.3 Scan Result

The scan identified the following open TCP ports:

| Port | State | Service |
|------|-------|---------|
| 22/tcp | Open | SSH |
| 80/tcp | Open | HTTP |
| 443/tcp | Open | HTTPS |

The scan also reported that the target host was up.

### Interpretation

**Port 22 — SSH**

Port 22 is commonly used by Secure Shell (SSH) for remote administration of Linux systems.

**Port 80 — HTTP**

Port 80 is commonly used for unencrypted HTTP web traffic.

**Port 443 — HTTPS**

Port 443 is commonly used for HTTPS web traffic protected by TLS/SSL.

The presence of an open port does not automatically mean that the service is vulnerable. Further assessment would be required to determine whether a specific vulnerability exists.

## 4.4 Screenshot

<img width="948" height="658" alt="basic nmap" src="https://github.com/user-attachments/assets/ab9b3866-80ec-468b-b350-fb7838113bb6" />


The screenshot should show:

```bash
nmap 192.168.0.103
```

and the open ports:

```text
22/tcp   open   ssh
80/tcp   open   http
443/tcp  open   https
```

---

# 5. Service and Version Detection

## 5.1 Purpose

The next step was to identify the specific services and software versions running on the open ports.

Nmap's `-sV` option was used for service and version detection.

## 5.2 Command

```bash
nmap -sV 192.168.0.103
```

## 5.3 Result

The scan identified the following services:

| Port | Service | Version / Information |
|------|---------|-----------------------|
| 22/tcp | SSH | OpenSSH 8.9p1 Ubuntu 3ubuntu0.14 |
| 80/tcp | HTTP | Apache httpd 2.4.52 (Ubuntu) |
| 443/tcp | HTTPS | HTTPS/SSL service detected |

### OpenSSH

The SSH service was identified as:

```text
OpenSSH 8.9p1 Ubuntu 3ubuntu0.14
```

SSH provides secure remote administration. However, an exposed SSH service may become a target for brute-force attacks or unauthorized access attempts if authentication and access controls are weak.

### Apache HTTP Server

The HTTP service was identified as:

```text
Apache httpd 2.4.52 (Ubuntu)
```

Apache is a web server used to serve HTTP content.

An exposed web server increases the attack surface of the system. The software should therefore be regularly updated and securely configured.

### HTTPS

Nmap detected an HTTPS/SSL service on port 443.

HTTPS provides encrypted communication between clients and the web server. Proper TLS configuration and valid certificates are important for maintaining secure communication.

## 5.4 Screenshot

<img width="942" height="670" alt="sv nmap" src="https://github.com/user-attachments/assets/5fc31e2e-f6cc-466c-a3e7-0d3a362bb8f4" />


The screenshot should show:

```bash
nmap -sV 192.168.0.103
```

and the detected service/version information.

---

# 6. Operating System Detection

## 6.1 Purpose

Nmap OS detection was performed to attempt to identify the operating system of the target machine.

The `-O` option was used.

## 6.2 Command

```bash
sudo nmap -O 192.168.0.103
```

## 6.3 Result

Nmap was able to identify the target as a Linux-based system in its service information, but the OS detection did not produce an exact operating system match.

The scan reported:

```text
No exact OS matches for host (test conditions non-ideal).
```

Nmap also generated several possible OS guesses, but because there was no exact match, the result should not be treated as a definitive operating system identification.

### Interpretation

The OS detection result was considered **inconclusive**.

This can happen when Nmap does not have sufficient network responses or when the target environment, virtualization configuration, firewall, or network conditions affect OS fingerprinting.

Therefore, no unsupported claim about the exact Ubuntu version was made based solely on this scan.

## 6.4 Screenshot

<img width="968" height="649" alt="nmap-O" src="https://github.com/user-attachments/assets/c8461e13-33cb-4d6e-b8fc-1ee0b2b21923" />


The screenshot should show the OS detection command and Nmap's result.

---

# 7. Nmap Scan Summary

The following table summarizes the main findings from the scans.

| Scan | Purpose | Result |
|------|---------|--------|
| `ping -c 4 192.168.0.103` | Test connectivity | 4 packets received, 0% packet loss |
| `nmap 192.168.0.103` | Identify open ports | Ports 22, 80, and 443 open |
| `nmap -sV 192.168.0.103` | Detect services and versions | OpenSSH and Apache identified |
| `sudo nmap -O 192.168.0.103` | OS detection | No exact OS match |

---

# 8. Security Analysis

## 8.1 Port 22 — SSH

### Finding

Port 22/tcp was open and running SSH.

### Security Considerations

SSH is an important administrative service, but exposing it unnecessarily can increase the attack surface.

Potential risks include:

- Brute-force login attempts.
- Password-based attacks.
- Unauthorized remote access if credentials are compromised.
- Exploitation of outdated SSH software.

### Recommended Security Measures

- Use strong passwords.
- Prefer SSH key-based authentication.
- Disable unnecessary password authentication where appropriate.
- Keep OpenSSH updated.
- Restrict SSH access to trusted networks or IP addresses when possible.
- Consider additional protections such as rate limiting or fail2ban.

---

## 8.2 Port 80 — HTTP

### Finding

Port 80/tcp was open and running HTTP through Apache.

### Security Considerations

HTTP does not provide encryption for normal web traffic.

Potential concerns include:

- Sensitive information may be transmitted without encryption.
- The web server may expose additional attack surfaces.
- Misconfigured Apache services may expose unnecessary information.

### Recommended Security Measures

- Keep Apache updated.
- Remove unnecessary services and modules.
- Apply secure server configuration.
- Use HTTPS for sensitive communication.
- Redirect HTTP traffic to HTTPS where appropriate.
- Avoid exposing unnecessary files or directories.

---

## 8.3 Port 443 — HTTPS

### Finding

Port 443/tcp was open and HTTPS/SSL was detected.

### Security Considerations

HTTPS provides encrypted communication, but the security of the service depends on the TLS configuration and certificate.

Potential concerns include:

- Weak TLS configurations.
- Outdated protocols or cipher suites.
- Invalid or improperly configured certificates.
- Vulnerable web applications behind the HTTPS service.

### Recommended Security Measures

- Use valid TLS certificates.
- Disable obsolete TLS protocols.
- Use strong cryptographic configurations.
- Keep the web server updated.
- Regularly review HTTPS configuration.

---

# 9. Overall Security Assessment

The Nmap scan identified three externally accessible TCP services:

```text
22/tcp   SSH
80/tcp   HTTP
443/tcp  HTTPS
```

These services are not automatically vulnerabilities. However, every exposed service increases the potential attack surface of the system.

The most important security considerations identified during the assessment are:

1. SSH should be properly secured because it provides remote administrative access.
2. Apache should be regularly updated and securely configured.
3. HTTP should be minimized or redirected to HTTPS when appropriate.
4. HTTPS should use secure TLS configuration and valid certificates.
5. Unnecessary services should be disabled to reduce the attack surface.
6. Regular vulnerability and configuration assessments should be performed.

---

# 10. Ethical Considerations

This assessment was performed in a controlled laboratory environment using virtual machines.

The target IP address:

```text
192.168.0.103
```

belonged to the Ubuntu virtual machine used for this exercise.

No unauthorized public systems or third-party networks were scanned.

Network scanning should only be performed against systems for which the tester has explicit authorization.

---

# 11. Tools Used

## Kali Linux

Kali Linux was used as the scanning environment.

## Ubuntu Linux

Ubuntu Linux was used as the authorized target system.

## Nmap

Nmap was used for:

- Network connectivity verification
- Port scanning
- Service detection
- Version detection
- Operating system detection

## Oracle VirtualBox

VirtualBox was used to run the virtual machines used in the laboratory environment.

---

# 12. Commands Used

The following commands were used during the assessment:

### Connectivity Test

```bash
ping -c 4 192.168.0.103
```

### Basic Port Scan

```bash
nmap 192.168.0.103
```

### Service and Version Detection

```bash
nmap -sV 192.168.0.103
```

### Operating System Detection

```bash
sudo nmap -O 192.168.0.103
```

---

# 13. Conclusion

The Nmap network scanning exercise successfully demonstrated the basic process of network reconnaissance in a controlled environment.

The Ubuntu target at `192.168.0.103` was reachable from Kali Linux, with 0% packet loss during the connectivity test.

The basic Nmap scan identified three open TCP ports:

- **22/tcp — SSH**
- **80/tcp — HTTP**
- **443/tcp — HTTPS**

Service and version detection further identified:

- **OpenSSH 8.9p1 Ubuntu 3ubuntu0.14**
- **Apache httpd 2.4.52 (Ubuntu)**
- **HTTPS/SSL service**

OS detection was also attempted, but Nmap reported that the test conditions were non-ideal and did not provide an exact OS match.

The exercise demonstrated how Nmap can be used to identify exposed services and gather information that can support a basic security assessment. The results also show why unnecessary services should be minimized and exposed services should be properly secured and maintained.

---

# 14. Evidence

The following screenshots document the practical steps performed during the assessment:

1. Network connectivity test using `ping`
2. Basic Nmap port scan
3. Nmap service and version detection
4. Nmap operating system detection

All screenshots were captured from the Kali Linux laboratory environment and document the actual commands and results obtained during the assessment.
