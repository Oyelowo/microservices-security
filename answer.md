
Solution: Simple Infrastructure Threat Model with STRIDE
Solution: Simple threat model with STRIDE
Environment Diagram
Given the provided description, we created a simple diagram describing the application components and boundaries.

Sample diagram for simple infrastructure threat model
Sample diagram for simple infrastructure threat model

Threat Model Summary
Given the simple infrastructure threat model, let's evaluate what could go wrong with this infrastructure model based on the provided information.

Simple App Threat Model:
1.Provide a profile of potential attackers, including their goals and methods

Malicious attackers may be interested in either disrupting the application or financial gain by stealing user data or modifying pricing in their favor.
2.Given system components and the STRIDE, identify potential threats that may arise.

Here is an example for each aspect of STRIDE.

Spoofing: Single Internet-accessible OpenSUSE leap web server running Nginx to serve traffic over ports 80 (HTTP) and 443 (HTTPS). Traffic is allowed on port 80 (HTTP) is unencrypted. This may allow an attacker to intercept communication between client and server, leading to spoofing of the traffic.
Tampering: The web server is behind a load balancer. Data is stored in a SQL database. Using a load balancer provides security and scalability benefits. However, the application uses a SQL database, which may allow an attacker to pass URL parameters with a SQL injection, leading to tampering by querying data from the SQL database.
Repudiation: If the webserver traffic is spoofed, an attacker could gain control of a user session. This could lead to repudiation for user actions on the application and fraudulent transactions.
Information Disclosure: The application accepts credit cards processed via a third-party gateway provided by Braintree. The application logs all client/server transactions via a Syslog server. While the handling of sensitive payment data occurs by Braintree, the integration may involve log generation and storage that, if miss-configured, may lead to information disclosure of the credit card number. This will provide information to someone not authorized to access it.
Denial of Service: The application is behind a load balancer, which may provide some denial of service protection. However, that's not the dedicated focus for a load balance. Lack of purpose-built rate-limiting or denial of service protection could result in exhausting resources needed to provide the service and lead to an outage.
Elevation of Privilege: An attacker may attempt to abuse a regular user's login to escalate privilege to an administrative login such as admin or administrator. This may lead to the elevation of privilege, allowing them to do something they are not authorized to do.


























What Could Go Wrong?
Docker Client
Client compromise: the Docker desktop running on the administrator's machine
Client authorization abuse: abuse of the client's authorization to make privileged changes
Dockerfile misconfiguration: how the Dockerfile is built
Docker Host
Isolation tampering: we are very concerned with namespace isolation to prevent container escape attacks
Use of --privilege flag
Insecure defaults
Misconfiguration
Docker Registry - the largest attack surface
Image security
Open Source Software (OSS) security
Docker registry security
Evaluating Docker Client Using STRIDE
Spoofing - Client traffic from the Docker client to the Docker daemon or registry could be spoofed, or intercepted by a malicious party and replayed. Transport Layer Security (TLS) can be implemented to secure communication affecting the client.
Tampering - An attacker gets control of the Docker client. This could lead to tampering of the Dockerfile that’s used to build the image affecting Dockerfile.
Repudiation - Once the client is compromised, the attacker may use it to make changes that are not legitimate, which could impact the Dockerfile.
Information Disclosure - The client may expose sensitive information such as secrets that are hardcoded in configuration files that could impact the security of the Dockerfile.
Denial of Service - Excessive traffic from the client could overwhelm the daemon (often on the same machine) and could cause it to crash, leading to a client compromise.
Elevation of Privilege - when a Dockerfile does not specify a user, it defaults to executing the container using the root user, affecting client authorization and the Dockerfile.
Evaluating Docker Host Using STRIDE
Spoofing - This can occur when a sidecar container has intentional access to the primary container's namespace and may spoof the namespace used by the primary container, resulting in isolation tampering. You should be careful with using sidecar containers.
Tampering - Daemon configuration may be tampered with by a compromised client, leading to misconfiguration.
Repudiation - A user may make changes to the daemon that are not legitimate, leading to misconfiguration.
Information Disclosure - The Docker host file system may be misconfigured, exposing sensitive information and leading to insecure defaults.
Denial of Service - Daemon memory for the running container may be over-allocated, leading to a misconfiguration.
Elevation of Privilege - Daemon privilege may be escalated if a user name is not defined and the container runs as root, which gives access to any other container on the same host, leading to isolation tampering.
Evaluating Docker Registry Using STRIDE
Spoofing - Authenticity of images is a big concern as we put a lot of trust in them. An image may be spoofed with malicious images or libraries as part of the container layers, which affects image security.
Tampering - Container image may be tampered with, leading to supply chain injections. This is the biggest risk regarding the supply chain. An attacker may implant a malicious image into the image registry and entice organizations to use it. Alternatively, an attacker may introduce open source libraries in popular hosted repositories and encourage organizations to use them. This can affect both image security and Open Source Software security.
Repudiation - Malicious images may be committed without authorization by an attacker. This affects image security.
Information Disclosure - Sensitive data such as secrets may be left in the container image and exposed at runtime affecting image security and potentially much more, depending on the scope of the credentials. This would affect image security.
Denial of Service - Docker distribution may not properly restrict the amount of content accepted by a user. This allows remote attackers to cause a denial of service. This could affect registry security.
Elevation of Privilege - Container image permissions may be elevated using the --privilege flag. Image libraries may contain security flaws. This can affect image security.
New Terms
Sidecar container: A container that runs alongside the primary container in a pod. Sidecars are often used for logging or security use cases.
Namespace: A Linux native control that isolates or partitions resources such that one set of processes cannot see the resources of another set of processes.
Isolation: The state of being separated, both in a physical and virtual sense. On the Linux operating system, isolation allows each process to have its own isolated world to run processes.
Additional Resources
For further reading on Docker, please consider the following resources:

Getting started with STRIDE
Threat modelng Manifesto


























Solution: Threat Model Docker with STRIDE
Docker Threat Model Summary
Given the four areas most relevant to Docker security, let's evaluate what could go wrong with this docker model based on the provided information. As we learned in the lesson, containers have their own unique attack surface.

1. The three primary Docker components that are most relevant to Docker security
Docker Client: We are concerned with the compromise of the docker desktop running on the administrator's machine, abuse of the client's authorization to make privileged changes, and how the Dockerfile is built.
Docker Host: Docker host also has a large attack surface. We are very concerned with namespace isolation to prevent container escape attacks, use of the --privileged flag, insecure defaults, and misconfiguration.
Docker Registry: Docker Registry is the largest attack surface which has the most external implications. We are concerned with image security, open-source component security, and Docker registry security.
2. Given Docker's system components and the STRIDE framework, identify potential threats that may arise. I provide an example for three aspects of STRIDE.
Spoofing of network traffic: Docker supports the addition and removal of capabilities. You should remove all capabilities not required for the correct function of the container. Specifically, in the default capability set provided by Docker, the new_raw capability should be removed if not explicitly required, as it can give an attacker with access to a container the ability to create spoofed network traffic.
Tampering: Docker provides a TLS CA certificate file to allow secure communication between the Docker server and the client. This file should be protected from any tampering. It is used to authenticate the Docker server based on a given CA certificate. It must therefore be individually owned and group-owned by root to ensure that it cannot be modified by less privileged users to avoid tampering.
Denial of Service: By default, a container can use all of the memory on the host. You can use memory limit mechanisms to prevent a denial of service from occurring, where one container consumes all of the host’s resources and other containers on the same host are therefore not able to function. Denial of Service protection could result in exhausting resources needed to provide the service and lead to an outage.
With this more elaborate exercise, we identified 3 concrete threats on Docker using the STRIDE model.

Review
Through this more complex exercise, we evaluated the threat model for Docker at a high level. Although all responses will be marked as "correct", I encourage you to compare your response with the solution and think about the differences.

When evaluating this environment against STRIDE, it's important to think about the implications of the foundational design. For example, if you are not familiar enough with the core properties of Docker in order to evaluate threats, I would encourage you to rewatch the earlier courses and/or read official docker documentation. If you found this exercise more difficult than expected, I would encourage you to read the Docker CIS Benchmark in the starter exercise repo, as it does a wonderful job outlining the system security weaknesses very thoroughly to get you started.

While there is no "single right answer", the goal is to understand how to threat model in a systemic and methodical way. Before you can objectively evaluate the security properties of a system, you need to understand the system architecture, boundaries, and core entities.

As we progress through the course and go deeper into Docker, our threat models will become even more sophisticated. However, the basic foundation questions will be the same:

What could go wrong?
What are we going to do about it?
How do we know our mitigations are good enough?
Next, we will work to apply the STRIDE methodology to concretely evaluate Kubernetes' primary components.


























# Kubernetes
Solution: Threat Model Kubernetes with STRIDE
Kubernetes Threat Model Summary
1. Provide a summary of what could go wrong
An attacker may attempt to target any one of the 6 Kubernetes attack surfaces.
The kube-apiserver is the most powerful Kubernetes component. However, other components such as etcd are also very valuable, as it stores all the configuration data for the cluster.
The kube-scheduler is very important to ensuring pods-to-nodes scheduling and has an attack surface albeit less material than kube-apiserver and etcd.
The kubelet and kube-proxy are vital for communication to the kube-apiserver and in a default Kubernetes installation. Kubelet runs unsecured — leaving it vulnerable for an attack. Kubelet has also been shown to be used as a pivot point to attack the kube-apiserver.
The kube-controller-manager and cloud-controller-manager have a smaller attack surface but can also be abused.
2. Provide a profile of potential attackers, including their goals and methods
Attackers may be interested in abusing cluster resources to run crypto mining, this is a very common attack that we have seen many times.
Attackers may be interested in financial, user, or personally identifiable information (PII) data being processed.
Attackers may be interested in intellectual property, trade secrets, or even critical infrastructure.
Attackers may be interested in supply chain tampering components that could affect other organizations upstream.
3. Given Kubernetes' system components and the STRIDE framework, identify potential threats that may arise.
I provide an example for only three aspects of STRIDE. Notice how we provide a specific example using the threat fundamentals we learned.

Spoofing: Kubernetes ships with insecure defaults, for example, all pods have CAP_NET_RAW permissions. This allows all pods to open raw sockets and inject malicious packets into the Kubernetes container network, which may lead to spoofing.
Repudiation: Kubernetes natively doesn't allow certificate revocation, which may lead to repudiation if a certificate cannot be revoked when necessary.
Denial of Service: Kubernetes ships without an upper limit for setting the memory footprint. This may lead to a denial of service which could result in exhausting resources needed to run the pod.
With this more elaborate exercise, we identified 3 concrete threats on Kubernetes using the STRIDE model.

Review
Through this more complex exercise, we evaluated the threat model for Kubernetes at a high level. Although all responses will be marked as "correct", I encourage you to compare your response with the solution and think about the differences.

Kubernetes is a large and complex system that is not trivial to threat-model, even for very experienced security architects and senior engineers. Don't worry if it doesn't make sense right away. We will continue to learn and unpack each component throughout the course.

When evaluating this environment against STRIDE it's important to think about the implications of the foundational design. For example, if you are not familiar enough with the core tenets of Kubernetes in order to evaluate threats, I would encourage you to:

Rewatch the earlier courses
Read official Kubernetes security documentation
Examine the CIS Kubernetes Benchmark (provided courtesy of the Center for Internet Security) in the starter repo
If you found this exercise more difficult than expected, I would encourage you to read the CIS Kubernetes benchmarks in the starter exercise repo, as it does a wonderful job outlining the system security weaknesses very thoroughly to get you orientated to evaluating risk on Kubernetes.
While there is no "single right answer", the goal is to being understanding how to threat model in a systemic and methodical way.

















# Hardening:

## Docker-client
Docker client security is vital because the Docker client is how the user interacts with the Docker host.

What Could Happen with Client Compromise
If the Docker client is compromised, you should assume the attacker has privileged access to the host. At this point, the attacker controls the client and has the ability to control the host using the administrator's privilege access. All the built-in security controls are bypassed.

How the Client Can Be Abused
The machine running the Docker client is often an engineer's machine which often runs in a privileged context. This machine may be compromised via malware which may allow an attacker to control the machine remotely.

How to Protect against Abuse
Hardening the machine running the client (macOS, Windows, or Linux) is a good practice. However, that's beyond the scope of this course. The Center for Internet Security (CIS) provides hardening guides for all popular operating systems. You should collect and analyze Docker client logs.
Run the latest patched version of the Docker client.
Run anti-virus (AV) and endpoint detection and response (EDR) software to detect malicious processes and respond.
Avoid using the --privileged flag when running commands, as this flag makes the container privileged, opening the door to container escape.
New Terms
Endpoint detection and response (EDR) software: An agent that monitors for and alerts to suspicious processes and file system changes. Commercial examples include Crowdstrike Falcon and Carbon Black Response.



## Docker host 
What Is Isolation?
Let's cover what isolation is on the Linux system. Isolation is the state of being separated, both in a physical and virtual sense that we can easily apply to Docker. Let's look at a simple analogy.

An apartment building has a shared common hallway, but each apartment has its own isolated door. The shared common areas in the apartment (i.e. the hallway) are like the kernel and each apartment is like a container. The isolation for each container is provided by namespaces, which are like the door to your apartment.

Two key things to keep in mind:

In a container, you rely on the kernel for all runtime operations.
Isolation allows each process to have its own isolated world to run processes.
How Namespace Isolation Works in Docker
Containers use a single shared kernel on the host. Unlike VMs, containers do not have their own kernel. Hence isolation is very vital to limit container processes.
Namespaces are what allows for isolation of process ID (PID).
Hence container “udacity” running PID 900 cannot directly see container “student” running PID 1000, or any other PIDs on the host system.
To allow isolation, namespaces provide doors for each container to communicate to the host.
Container Breakout
The term “Container breakout” is used when isolation checks have been bypassed. To prevent this, you can restrict the use of --privileged flags, which increase the risk of container breakout.

How to Protect Docker Host
Avoid using --privileged flag.
Give containers individual “capabilities” they need. Reference the Docker documentation for specific capabilities that can be added.
Use SELinux in enforcing mode.
New Terms
Container breakout/escape: A situation where a Docker container has bypassed isolation checks, accessing sensitive information from the host or gaining additional privileges.
Isolation: The state of being separated, both in a physical and virtual sense. On the Linux operating system, isolation allows each process to have its own isolated world to run processes as enforced by the kernel using namespaces.
Kernel: The orchestrator for all processes on a computer. The kernel has complete control over everything on the machine. Security and isolation of processes are enforced by the kernel.
Process ID (PID): An identifier assigned by the kernel to each created process to uniquely identify an active process.
Namespace: A Linux native control that isolates or partitions resources such that one set of processes cannot see the resources of another set of processes. Namespaces are what allows for isolation of process ID (PID).




## Docker registry security

A Docker image is a collection of layers of software manifests and tarballs that together form a single container unit. Each layer consists of manifests and libraries that could have vulnerabilities. The image itself must also be trusted, signed, and verified using the Docker content trust (DCT), which we will talk about in-depth later in this lesson.

How Image Security Can Be Abused
Images may inadvertently contain authentication secrets. If the image is exposed, the system may be compromised.
An attacker may introduce a spoofed image to the Docker Hub and fool users to use that image. This happens frequently. Usually, the attacker conceals the malicious elements by using common names to trick others to use them.
Dependencies used by the image may be tampered with or have vulnerabilities.
How Image Security Can Be Protected
Image hardening: Be sure to handle secrets properly. Also, minimize the use of third-party software and use verifiable ones to avoid introducing malicious software to the container environment.
Image signing with Docker content trust
Verifying public images by comparing the image digest sha256 hash with one provided by the image repository.
New Terms
Tarball: A tarball or tarfile is the name of a group or archive of files that are bundled together using the tar command. They usually have the .tar file extension. If the tar file is compressed using the gzip command, the tarball will end with .tar. Sometimes ZIP files are also called tarballs.
Docker content trust (DCT) gives you the ability to verify the integrity of both the publisher and the images they provide. It allows publishers to digitally sign their collections with a cryptographically designed key, while users get to use the key to verify the integrity of the content they use. DCT serves as an anti-spoofing control.
Image digest: A cryptographic representation of the Docker image as a string of characters. An image digest or sha256 hash represents the image you are using. Using the digest as the identifier, Docker will not only pull the image with that digest, but also calculate the sha256 hash of what you downloaded, and verify it against what you specified. Using and verifying image digests ensure the integrity of the image you are running. It also mitigates man-in-the-middle attacks.
Sha256: The algorithm used to generate a cryptographic representation of the Docker image as a string of characters, also known as the image digest.
Man in the middle: A type of security attack, where an attacker intercepts communication between two parties, for example, intercepting communication between the Docker client/daemon and Docker Hub may allow an attacker to modify the image. Image signing mitigates this risk.
Further Reading
How to Man in the Middle Docker Container Traffic
Books:

Jean-Philippe Aumasson | A Practical Introduction to Modern Encryption
;



## CIS Benchmark
The Docker CIS Benchmark establishes an authoritative hardening guide for Docker across the core attack surfaces - Docker client, host, and registry. Changes can be applied to the configuration to harden the attack surface.

CIS Docker Benchmark Defines Three Surfaces to Evaluate
Docker Daemon
Docker Host
Docker Engine Enterprise
CIS defines two profile levels (1 and 2) for these three surfaces based on the required security. The descriptions of the levels in the video are directly cited from the CIS Docker benchmark document, provided courtesy of the Center for Internet Security.

Things to Note:
The CIS standard is really large (nearly 300 pages) and can be difficult to approach. Very few companies implement every single control to the standard.
You should use a tool like Docker-bench to audit which controls are failing, then evaluate and prioritize which controls matter most from your threat model based on STRIDE. This should not be prescriptive.
New Terms
CIS Profile: A pre-defined set of security checks for security controls associated with a profile level. CIS stands for Center for Internet Security, a non-profit organization that focuses on the creation of security standards.
Security Control: A technical or process mechanism to affect the security of a system. Hardening access to the Docker client is an example of security control.
Further Reading
For further reading on Docker CIS Benchmark, please consider the following resources:

Docker CIS Benchmark: Best Practices in Brief

