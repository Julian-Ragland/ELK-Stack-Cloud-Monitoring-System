## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

https://www.dropbox.com/s/zd7srir3gsrc5fq/ELK%20Network%20Diagram.png?dl=0


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the config.yml file may be used to install only certain pieces of it, such as Filebeat.

  - Filbeat-config.yml & Metricbeat-config.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly secure, in addition to restricting unrestricted access to the network.

- The Load Balancer Protects the system from denial of service attacks by malicious actors. When it gets an influx of requests it spread them out to the 3 web servers we set up. We also set up a rule that we can only ssh on port 80 from our jump box. 


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the Logs and system Metrics.

- What does Filebeat watch for? - Filebeat consists of two main components: inputs and harvesters. These components work together to tail files and send event data to the output that you specif in this case sends data to cabana

- What does Metricbeat record? - system-level CPU usage, memory, file system, disk IO, and network IO statistics, as well as top-like statistics for every process running on your systems.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.7   | Linux            |
| Web 1    | Webserver| 10.0.0.12  | Linux            |
| Web 2    | Webserver| 10.0.0.14  | Linux            |
| Web 3    | Webserver| 10.0.0.15  | Linux            |

### Access Policies

The machines on the internal network are not exposed to the Public Internet. 

Only the Jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- IP ADDRESS: 172.90.6.190

Machines within the network can only be accessed by Jumpbox

The Elk VM was accessible via SSH from my jumpbox provisioner as well as my web 1,2 & 3 web servers, which actively send data to it via ports 9200 & 5601. 

IP Address 10.0.0.7

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 172.90.6.190         |
| Web 1 - 3| Yes                 | 104.42.100.133       |

  

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because we don't have to do it on every machine and we can push updates easily and efficiently. 

The playbook implements the following tasks:

- Installs Docker
- Installs Pip3 (Python) 
- Install Python Docker Module
- Tells the system to use more memory
- Downloads and launches a docker elk container on elk server
- Enables the docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

https://www.dropbox.com/s/noqshvr9gx9nm0w/Docker%20Setup%20Confirmation%20%28Kibana%29.png?dl=0

### Target Machines & Beats

Elk Server is monitoring web servers  1,2 and 3 at the following IP Addresses 10.0.0.12, 10.0.0.14 and 10.0.0.15


We have installed the following Beats on these machines:

Filebeats on web servers 1-3. 
Metricbeat on web servers 1-3

These Beats allow us to collect the following information from each machine:

Filebeat collects log data for our web servers and forwards them to our elk server so that we may track and analyze them in Kibana. It is essentially a log forwarding tool that itemized and tracks all files on the server and reports changes to them. 

Metricbeat. We expect to collect a wide assortment of data from which countries accessed the web servers, when and what they downloaded. It will also show up geographically where are vistors come from and what time they visited as well as the filetype in which they downloaded. 


Playbook - Filebeat

This is the compiler I created to install Filbeat on my web servers


---
- name: Installing and Launch Filebeat
  hosts: webservers
  become: yes
  tasks:
     Use command module
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

     Use command module
  - name: Install filebeat .deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

     Use copy module
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

     Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system

     Use command module
  - name: Setup filebeat
    command: filebeat setup

     Use command module
  - name: Start filebeat service
    command: service filebeat start

      Use systemd module
  - name: Enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes
      
## Playbook - Filebeat

---
- name: Installing and Launch Filebeat
  hosts: webservers
  become: yes
  tasks:
     Use command module
  - name: Download filebeat .deb file
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

    Use command module
  - name: Install filebeat .deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

     Use copy module
  - name: Drop in filebeat.yml
    copy:
      src: /etc/ansible/files/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

     Use command module
  - name: Enable and Configure System Module
    command: filebeat modules enable system

     Use command module
  - name: Setup filebeat
    command: filebeat setup

     Use command module
  - name: Start filebeat service
    command: service filebeat start

     Use systemd module
  - name: Enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes
