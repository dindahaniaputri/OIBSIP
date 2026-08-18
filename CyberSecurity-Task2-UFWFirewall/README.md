# Cyber Security Task 2 – UFW Firewall Configuration

**Oasis Infobyte Cyber Security Internship**

## 1. Objective

The objective of this task is to configure and manage a firewall using UFW (Uncomplicated Firewall) on Ubuntu Linux.

The firewall configuration includes:
- Enabling UFW
- Allowing SSH connections
- Denying HTTP connections
- Allowing HTTPS connections
- Denying FTP connections
- Verifying the firewall rules and status

---

## 2. Environment

| Item | Details |
|---|---|
| Operating System | Ubuntu Linux |
| Firewall | UFW (Uncomplicated Firewall) |
| Testing Machine | Kali Linux |
| Network | Local Virtual Machine Network |
| Target IP Address | 192.168.0.103 |

---

## 3. Firewall Configuration

UFW was enabled using the following command:

```bash
sudo ufw --force enable
```

This activates the UFW firewall and enables it to start automatically.

### Screenshot

<img width="851" height="572" alt="VirtualBox_ubuntu20_18_08_2026_09_34_47" src="https://github.com/user-attachments/assets/66fc0fdf-ab46-4fdd-8d26-4fbbbeb26187" />


---

## 4. Allow SSH

SSH was allowed so that remote administration through port 22 remains available.

```bash
sudo ufw allow ssh
```

Equivalent port:

```text
22/tcp – ALLOW
```

### Screenshot

<img width="851" height="572" alt="VirtualBox_ubuntu20_18_08_2026_09_34_47" src="https://github.com/user-attachments/assets/d2b215a7-dc34-402f-8cc0-31cfe3dda11d" />


---

## 5. Deny HTTP

HTTP traffic on port 80 was denied.

```bash
sudo ufw deny http
```

Port 80 is commonly used for unencrypted web traffic.

### Screenshot

<img width="851" height="572" alt="VirtualBox_ubuntu20_18_08_2026_09_34_47" src="https://github.com/user-attachments/assets/5bb83ba0-6edf-42c1-8773-8331fb859fb4" />


---

## 6. Allow HTTPS

HTTPS traffic on port 443 was allowed.

```bash
sudo ufw allow https
```

HTTPS provides encrypted communication between a client and a web server.

###
<img width="752" height="314" alt="allow" src="https://github.com/user-attachments/assets/e8fc46e0-d416-49a3-aaad-f03a0776b130" />


---

## 7. Deny FTP

FTP traffic on port 21 was denied.

```bash
sudo ufw deny ftp
```

FTP is an insecure file transfer protocol when used without additional protection, so blocking it reduces unnecessary exposure.

### Screenshot

<img width="752" height="314" alt="allow" src="https://github.com/user-attachments/assets/88ff4881-3a7f-49d7-9f5f-37e2aa942681" />


---

## 8. Verify Firewall Status

The firewall configuration was verified using:

```bash
sudo ufw status verbose
```

The final configuration should show:

```text
Status: active

Default: deny (incoming), allow (outgoing), disabled (routed)

22/tcp    ALLOW IN
80/tcp    DENY IN
443/tcp   ALLOW IN
21/tcp    DENY IN
```

### Screenshot

<img width="853" height="564" alt="final" src="https://github.com/user-attachments/assets/6150e8b2-22d2-4f0c-9a2c-43770a44d763" />


---

## 9. Network Verification Using Nmap

The firewall rules were tested from the Kali Linux machine using Nmap.

Command:

```bash
nmap -p 21,22,80,443 192.168.0.103
```

Expected result:

```text
PORT     STATE      SERVICE
21/tcp   filtered   ftp
22/tcp   open       ssh
80/tcp   filtered   http
443/tcp  open       https
```

### Screenshot

<img width="736" height="347" alt="nmapscan" src="https://github.com/user-attachments/assets/36355b28-12af-456e-bb5c-f4a5126e4abf" />


The scan demonstrates that the firewall rules affect the accessibility of the selected network services.

---

## 10. Results

The UFW firewall was successfully configured with the following rules:

| Port | Service | Action | Purpose |
|---|---|---|---|
| 21/tcp | FTP | DENY | Block FTP traffic |
| 22/tcp | SSH | ALLOW | Permit remote administration |
| 80/tcp | HTTP | DENY | Block unencrypted HTTP traffic |
| 443/tcp | HTTPS | ALLOW | Permit secure web traffic |

The Nmap scan was used to verify the network-level effect of these firewall rules.

---

## 11. Security Analysis

The firewall configuration reduces the attack surface by blocking unnecessary or insecure services while allowing required services.

- **SSH (22/tcp)** is allowed for remote administration.
- **HTTP (80/tcp)** is blocked because it does not provide encrypted communication.
- **HTTPS (443/tcp)** is allowed because it provides encrypted web communication.
- **FTP (21/tcp)** is blocked because traditional FTP does not provide secure encrypted communication.

Firewall rules should be reviewed regularly to ensure that only required services are exposed.

---

## 12. Conclusion

UFW was successfully enabled and configured on Ubuntu Linux.

The firewall was configured to allow SSH and HTTPS while denying HTTP and FTP. Nmap was then used from Kali Linux to verify the accessibility of the selected ports.

This task demonstrates the basic principles of host-based firewall configuration, network service control, and security verification using UFW and Nmap.

---

## 13. Evidence

The screenshots below document the configuration and verification process:

1. UFW enabled
2. SSH allowed
3. HTTP denied
4. HTTPS allowed
5. FTP denied
6. Final UFW status
7. Nmap verification

All screenshots are stored in the `screenshots` directory of this project.
