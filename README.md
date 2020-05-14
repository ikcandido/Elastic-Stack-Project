# Elk-Stack-Project

The files in this repository were used to configure the network depicted in the image below:

[Network Diagram](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Diagrams/Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment in the network diagram. Select portions of the `filebeat_configuration.yml` file may be used to install certain pieces of it, such as Filebeat.

[Filebeat Playbook](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Ansible/filebeat_playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Monitored Machines
- Ansible Build Instructions

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly redundant, in addition to restricting access to the network.
- Load balancers have an external IP address accessible from the internet. LB's receive traffic that enters a website and distributes it across multiple servers.
- The jump box provides a gateway to the additional VMs in the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs/files and system metrics.
- Filebeat: monitors log files and collects data about log events and the file system. The data is then forwarded to elasticsearch & logstash
- Metricbeat: records machine metrics and sends data to elastricsearch and logstash.

The configuration details of each machine may be found below:

| Name                | Function   | IP Address | Operating System |
|---------------------|------------|------------|------------------|
| Jump-Box Provisioner| Gateway    | 10.0.0.4   | Linux            |
| DVWA-VM1            | Web Server | 10.0.0.5   | Linux            |
| ELK-VM              | Elk Server | 10.0.0.9   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Jump-Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 73.233.181.217

Machines within the network can only be accessed by my IP (73.233.181.217).
- Jump-Box Provisioner VM with cyberxsecurity/ansible container is able to SSH into the DVWA-VM1 machine with cyberxsecurit/dvwa container and the ELK VM with sebp/elk container
- Jump-Box Provisioner IP: 10.0.0.4
- DVWA-VM 1 IP: 10.0..5
- ELK-VM IP: 10.0.0.9

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IPs    |
|----------------------|---------------------|----------------|
| Jump-Box Provisioner | No                  | 73.233.181.217 |
| DVWA-VM1             | No                  | 73.233.181.217 |
| ELK-VM               | No                  | 73.233.181.217 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The configurations stay the same each time playbooks are run, with minor adjustments between configurations.
- Ansible also allows automatic configuration of multiple machines.

The playbook implements the following tasks:
- Downloads ELK to the machine connected to the IP listed under [elkservers] in /etc/ansible/hosts file.
- Increased virtual machine memory size (sysctl -w vm.max_map_count=262144).
- Installed docker.io, python-pip, and docker.
- Allowed ports:
    5601:5601 - Kibana web interface
    9200:9200 - Elasticsearch
    5044:5044 - Logstash interface, receives logs from Beats such as Filebeat

The screenshot "docker_ps.png" displays the result of running `docker ps` after successfully configuring the ELK instance.
- Images/docker_ps.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.9

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: monitors log files and collects data about log events and the file system. The data is then forwarded to elasticsearch & logstash
- Metricbeat: collects machine metrics and sends data to elastricsearch and logstash.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
  - The playbook is in /etc/ansible/ directory.
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
  - /etc/ansible/hosts - add the IP of the VM/Specific machine you want to run an ansible on.
  - The VM IP's should be separated by [name of server to install on] with the correct VM IP listed below.
  - When you create a playbook, the [server] will be listed as "hosts" in the text editor.
- _Which URL do you navigate to in order to check that the ELK server is running?
  - http://[ELK-VM-IP]:5601 brings you to the Kibana website/dashboard.

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
