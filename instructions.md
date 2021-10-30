Important Steps to Follow:
Make sure that GO runtime is properly installed. Check the GO installation with go env
Pull in the latest Docker OpenSUSE leap image with the following code:
```sh
docker pull opensuse/leap:latest
```
### Output
```txt

latest: Pulling from opensuse/leap
Digest: sha256:20c884408cb56f97bbd500bf5eeb1d28204a4abfa266a74827ae6bc4eb78175a
Status: Image is up to date for opensuse/leap:latest
docker.io/opensuse/leap:latest
```

Check and make sure that you have the Docker image locally:
```sh
docker images | grep opensuse                                                      
#opensuse/leap                                                              latest              09d5e2cf44af   4 days ago      109MB
```

Pull in the exercise starter repository from GitHub:
```
git clone git@github.com:udacity/nd064-c3-microservices-security-exercises.git
```
Navigate to the exercises directory for this lesson:

```sh
cd nd064-c3-microservices-security-exercises/lesson-3-docker-attack-surface-analysis-and-hardening/exercises/starter
```

To access all the help commands for docker build and review the security-relevant flags, you can use
```sh
docker build --help
```

Here are some flags that are worth highlighting:
- --no-cache: Whenever you build an image, you should run no-cache to make sure you fetch. all the latest dependencies from Docker Hub and other locations, and not using anything local. This is important from a security perspective, because the cache may contain a legacy code or library that may be vulnerable.

- -m or --memory megabytes: these flags allow us to set a memory limit for the image. When we hardcode a memory amount, that amount cannot be exceeded. This helps prevent the memory amount from being abused by an attacker.

Next, we will build the OpenSUSE image with a memory amount set to 256 megabytes with the no-cache option:

```sh
docker build . -t opensuse/leap:latest -m 256mb --no-cache=true
```



## Running docker bench 

In this demo, we utilize Docker-bench to evaluate the Docker installation and local environment.

Important Steps to Follow:
Clone the Docker-bench repository from GitHub:
git clone git@github.com:aquasecurity/docker-bench.git
Because this is a GO application, we need to build this application in order to run it to check our Docker environment. To do so, we first need to cd into the docker-bench repo, then compile this GO application using make and build docker-bench:
cd  /docker-bench 
go build -o docker-bench 
Next, we will run Docker-bench for the first time and look at some of the help files:
./docker-bench --help 
Here let's pay attention to some of the flags:
--benchmark string: This is the flag we need to specify a particular version of the CIS Benchmark. You can set the string to, for example, CIS 1.2 or 1.1 if you need to access an earlier version of the benchmark.

--version string: This flag specifies a specific version of Docker. This application automatically picks up the latest version of Docker. But if you want to run Docker-bench against an earlier version of Docker, you can specify this string accordingly.

Next, we will run Docker-bench against our Docker environment and output the text to a file. Running Docker-bench to a file makes it easier to review the result afterward.
./docker-bench --include-test-output >docker-bench.txt 
Concatenate the docker-bench.txt file and look for the lines where there is a failure:
cat docker-bench.txt | grep FAIL
This command returns the checks that failed. In the next demo, we will look at these checks more closely, pick one of the failed checks, harden that check, then rerun Docker-bench to show that the failed check has been fixed.

Note: The total number of failed findings you get after running Docker-bench may be different from the number shown in the demo, due to the specific setup of your local environment.












## Solution: Running Docker-bench to Evaluate Docker Installation
Solution: Running Docker-bench to Harden Docker


Building on our previous lesson where we examined the Docker threat model, in this exercise, you will use Docker-bench to evaluate the actual attack surface hands-on!

Exercise Tasks:

Navigate to the lesson 3 starter code and open the Dockerfile in a code editor.
From the lesson 3 directory, open the CIS_Docker_Benchmark_v1.2.0.pdf from the exercise repo. Leave it open as you will likely reference it in the exercise.
Run docker pull opensuse/leap:latest to fetch the latest OpenSUSE leap image and ensures it's in your local docker repo via docker images | grep opensuse.
nick.reva@nreva-mbp starter % docker pull opensuse/leap:latest
latest: Pulling from opensuse/leap
Digest: sha256:b41ade84e893461b2fdd1ae631bfe39d95f4cdcaa0b6d43ba56608d200d22446
Status: Image is up to date for opensuse/leap:latest
docker.io/opensuse/leap:latest
nick.reva@nreva-mbp starter % docker images | grep opensuse
opensuse/hardened-v1.0            latest              65f78964649e   13 hours ago    183MB
opensuse/leap                     latest              9eb32c8d07b4   2 days ago      106MB
opensuse/leap                     <none>              963be48f5f20   5 weeks ago     106MB<pre><code>
Build the Docker image as opensuse/hardened-v1.0 without cache. Later we will evaluate the image.
docker build -t opensuse/hardened-v1.0 . --no-cache=true
CD to the folder and startup a machine via Vagrant via vagrant up. SSH into the Vagrant machine via vagrant ssh
Install Docker client and daemon by running the shell script ./installdocker.sh
From the Vagrant machine, clone the official Docker-bench repo
Inspect the Docker-bench findings
% docker-bench % ./docker-bench --version 18.09

== Summary ==
19 checks PASS
51 checks FAIL
43 checks WARN
10 checks INFO
grep for FAIL to inspect failed only.

% ./docker-bench --version 18.09 | grep FAIL
[FAIL] 1.2.1 Ensure a separate partition for containers has been created (Scored)
[FAIL] 1.2.3 Ensure auditing is configured for the docker daemon (Scored)
[FAIL] 1.2.4 Ensure auditing is configured for Docker files and directories - /var/lib/docker (Scored)
[FAIL] 1.2.5 Ensure auditing is configured for Docker files and directories - /etc/docker (Scored)
[FAIL] 1.2.6 Ensure auditing is configured for Docker files and directories - docker.service (Scored)
[FAIL] 1.2.7 Ensure auditing is configured for Docker files and directories - docker.socket (Scored)
[FAIL] 1.2.8 Ensure auditing is configured for Docker files and directories - /etc/default/docker (Scored)
[FAIL] 1.2.9 Ensure auditing is configured for Docker files and directories - /etc/sysconfig/docker (Scored)
[FAIL] 1.2.10 Ensure auditing is configured for Docker files and directories - /etc/docker/daemon.json (Scored)
[FAIL] 1.2.11 Ensure auditing is configured for Docker files and directories - /usr/bin/docker-containerd (Scored)
[FAIL] 1.2.12 Ensure auditing is configured for Docker files and directories - /usr/sbin/runc (Scored)
[FAIL] 2.1 Ensure network traffic is restricted between containers on the default bridge (Scored)
[FAIL] 2.2.b Ensure the logging level is set to 'info' (Scored)
[FAIL] 2.6.a Ensure TLS authentication for Docker daemon is configured (Scored)
[FAIL] 2.6.b Ensure TLS authentication for Docker daemon is configured (Scored)
[FAIL] 2.8 Enable user namespace support (Scored)
[FAIL] 2.11.a Ensure that authorization for Docker client commands is enabled (Scored)
[FAIL] 2.12 Ensure centralized and remote logging is configured (Scored)
[FAIL] 2.13.a Ensure live restore is Enabled (Scored)
[FAIL] 2.13.b Ensure live restore is Enabled (Scored)
[FAIL] 2.14.a Ensure Userland Proxy is Disabled (Scored)
[FAIL] 2.14.b Disable Userland Proxy (Scored)
[FAIL] 2.17.a Ensure containers are restricted from acquiring new privileges (Scored)
[FAIL] 2.17.b Ensure containers are restricted from acquiring new privileges (Scored)
[FAIL] 3.1 Ensure that docker.service file ownership is set to root:root (Scored)
[FAIL] 3.2 Ensure that docker.service file permissions are appropriately set (Scored)
[FAIL] 3.3 Ensure that docker.socket file ownership is set to root:root (Scored)
[FAIL] 3.4 Ensure that docker.socket file permissions are set to 644 or more restrictive (Scored)
[FAIL] 3.5 Ensure that /etc/docker directory ownership is set to root:root (Scored)
[FAIL] 3.6 Ensure that /etc/docker directory permissions are set to 755 or more restrictive (Scored)
[FAIL] 3.7 Ensure that registry certificate file ownership is set to root:root (Scored)
[FAIL] 3.8 Ensure that registry certificate file permissions are set to 444 or more restrictive (Scored)
[FAIL] 3.15 Ensure that Docker socket file ownership is set to root:docker (Scored)
[FAIL] 3.16 Ensure that Docker socket file permissions are set to 660 or more restrictive (Scored)
[FAIL] 3.17 Ensure that daemon.json file ownership is set to root:root (Scored)
[FAIL] 3.18 Ensure that daemon.json file permissions are set to 644 or more restrictive (Scored)
[FAIL] 3.19 Ensure that /etc/default/docker file ownership is set to root:root (Scored)
[FAIL] 3.20 Ensure that the /etc/sysconfig/docker file ownership is set to root:root (Scored)
[FAIL] 3.21 Ensure that /etc/sysconfig/docker file permissions are set to 644 or more restrictive (Scored)
[FAIL] 3.22 Ensure that /etc/default/docker file permissions are set to 644 or more restrictive (Scored)
[FAIL] 4.1 Ensure that a user for the container has been created (Scored)
[FAIL] 4.5 Ensure Content trust for Docker is Enabled (Scored)
[FAIL] 5.4 Ensure that privileged containers are not used (Scored)
[FAIL] 5.10 Ensure that the memory usage for container is limited (Scored)
[FAIL] 5.11 Ensure that CPU priority is set appropriately on container (Scored)
[FAIL] 5.12 Ensure that the container's root filesystem is mounted as read only (Scored)
[FAIL] 5.14 Ensure that the 'on-failure' container restart policy is set to '5' (Scored)
[FAIL] 5.22 Ensure that docker exec commands are not used with the privileged option (Scored)
[FAIL] 5.23 Ensure that docker exec commands are not used with the user=root option (Not Scored)
[FAIL] 5.25 Ensure that the container is restricted from acquiring additional privileges (Scored)
[FAIL] 5.28 Ensure that the PIDs cgroup limit is used (Scored)
51 checks FAIL
Review the Docker-bench findings to identify and document in the fields below three weaknesses you would like to remediate.
I have chosen three findings to evaluate and remediate. Let's take a closer look at these three.

[FAIL] 5.10 Ensure that the memory usage for container is limited (Scored)
[FAIL] 5.14 Ensure that the 'on-failure' container restart policy is set to '5' (Scored)
[FAIL] 5.22 Ensure that docker exec commands are not used with the privileged option (Scored)
9.a [FAIL] 5.10 Ensure that the memory usage for container is limited (Scored)

According to the CIS Docker Benchmark (provided courtesy of the Center for Internet Security),

By default, a container can use all of the memory on the host. You can use memory limit mechanisms to prevent a denial of service, i.e. one container consumes all of the host’s resources and the other containers on the same host are therefore not able to function. Having no limit on memory usage can lead to issues where one container can easily make the whole system unstable and as a result unusable.

Setting a memory limit prevents a container escape and protects the Docker daemon. A container escape is a situation where a Docker container has bypassed isolation checks, accessing sensitive information from the host or gaining additional privileges.

9.b [FAIL] 5.14 Ensure that the 'on-failure' container restart policy is set to '5' (Scored)

According to the CIS Docker Benchmark (provided courtesy of the Center for Internet Security),

If you indefinitely keep trying to start the container, it could possibly lead to a denial of service on the host. It could be an easy way to do a distributed denial of service attack especially if you have many containers on the same host. Additionally, ignoring the exit status of the container and always attempting to restart the container can lead to non-investigation of the root cause behind containers getting terminated. If a container gets terminated, you should investigate the reason behind it instead of just attempting to restart it indefinitely. You should use the on-failure restart policy to limit the number of container restarts to a maximum of 5 attempts.

Setting a restart policy limits protects the host from resource starvation. This protects the Docker daemon.

9.c [FAIL] 5.22 Ensure that docker exec commands are not used with the privileged option (Scored)

According to the CIS Docker Benchmark (provided courtesy of the Center for Internet Security),

Using the --privileged option in docker exec commands gives extended Linux capabilities to the command. This could potentially be an insecure practice, particularly when you are running containers with reduced capabilities or with enhanced restrictions.

Disallowing the usage of the privileged command is a very strong control that reduces the risk of a container escape and protects the Docker daemon.

With this hands-on exercise, we identified 3 concrete threats with Docker-bench. In the next exercise, you will harden the Docker image and commit it to a private registry! Later, you will use this image to deploy your own hardened Kubernetes cluster.

The material will continue to get more difficult, hang in there and keep going! If you get stuck on anything, consider coming back to the lesson, checking out the official Docker security documentation and Sean Kane's book Docker: Up and Running.

New Terms
Container breakout/escape: A situation where a Docker container has bypassed isolation checks, accessing sensitive information from the host or gaining additional privileges.
;




## Hardening docker

echo $DOCKER_CONTENT_TRUST 
