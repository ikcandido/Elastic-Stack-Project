# Candido-Elk-Stack-Project

The files in this repository were used to configure the network depicted in the image below:

[Network Diagram](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Diagrams/Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to recreate the entire deployment in the network diagram. Minor adjustments can be made to the playbook files to install various Elk Beats, such as Filebeat and Metricbeat.

[Filebeat Playbook](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Ansible/filebeat_playbook.yml)
[Metricbeat Playbook](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Ansible/metricbeat_playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Monitored Machines
- Ansible Build Instructions

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load balancers receive traffic that enters a website and distribute it across multiple servers. This is an important part of establishing a fault tolerant system and can play a role in the mitigation of DoS/DDoS attacks.
- One advantage of using a jump box is that it is a secure gateway to the additional VMs in the network and is typically used by system administrators. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to system logs/files and machine metrics.
- Filebeat: monitors log files and collects data about log events and the file system. The data is then forwarded to elasticsearch & logstash
- Metricbeat: records machine metrics and sends data to elastricsearch and logstash.

The configuration details of each machine may be found below:
*table created using: [Table Markdown Generator](https://www.tablesgenerator.com/markdown_tables)*

| Name                | Function   | IP Address | Operating System |
|---------------------|------------|------------|------------------|
| Jump-Box Provisioner| Gateway    | 10.0.0.4   | Linux            |
| DVWA-VM1            | Web Server | 10.0.0.5   | Linux            |
| ELK-VM              | Elk Server | 10.0.0.9   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Jump-Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 73.233.181.217

Machines within the network can only be accessed by SSH (port 22).
- Jump-Box Provisioner VM with cyberxsecurity/ansible container is able to SSH into the DVWA-VM1 machine with cyberxsecurit/dvwa container and the ELK VM with sebp/elk container
- Jump-Box Provisioner IP: 10.0.0.4
- DVWA-VM1 IP: 10.0..5
- ELK-VM IP: 10.0.0.9

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IPs             |
|----------------------|---------------------|-------------------------|
| Jump-Box Provisioner | Yes                 | 73.233.181.217          |
| DVWA-VM1             | No                  | 10.0.0.4                |
| ELK-VM               | Yes                 | 73.233.181.217/10.0.0.4 |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- The configurations stay the same each time playbooks are run, with minor adjustments between configurations.
- Ansible also allows automatic configuration of multiple machines and is simple to use.

[Elk Playbook](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Ansible/elk_playbook.yml)

The playbook implements the following tasks:
- Edit the `/etc/ansible/hosts` file to inclue ELK-VM IP address under [elkservers].
- Add the correct username to the `/etc/ansible/ansible.cfg` file.
- Create an Ansible playbook `elk_playbook.yml` that will: 
  - Increase virtual machine memory size (sysctl -w vm.max_map_count=262144).
  - Install  docker.io, python-pip, and docker.
  - Allow ports:
      5601:5601 - Kibana web interface
      9200:9200 - Elasticsearch
      5044:5044 - Logstash interface, receives logs from Beats such as Filebeat
- Run the `elk_playbook.yml`
- SSH to ELK-VM
- start sebp/elk docker

The screenshot below displays the result of running `docker ps` after successfully configuring the ELK instance.

[Docker](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Images/docker_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.9

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: monitors log files and collects data about log events and the file system. The data is then forwarded to elasticsearch & logstash
- Metricbeat: collects machine metrics, such as CPU usage and memory, and sends data to elastricsearch and logstash.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned:

SSH into the control node and follow the steps below:
- Copy the source to destination files.
- Update the configuration files to include the correct VM IP addresses
- Run the playbook, and navigate to Kibana website to check that the installation worked as expected.

[Check Data](https://github.com/ikcandido/Elk-Stack-Project/blob/master/Images/Kibana_site.png)

*Which file is the playbook? Where do you copy it?*
- The playbooks are in `filebeat.yml` and `metricbeat.yml`. The files are copied to `/etc/filbeat/filebeat.yml` and `/etc/metricbeat/metricbeat.yml`.

*Which file do you update to make Ansible run the playbook on a specific machine?*
- `/etc/ansible/hosts` - add the IP of the specific machine you want to run an ansible on.

*How do I specify which machine to install the ELK server on versus which to install Filebeat on?*
- The VM IP's should be separated by [name of server to install on] with the correct VM IP listed below. Ex. `[elkservers]`.
- When creating a playbook, the [server] will be listed as "hosts" in the text editor. Ex. `hosts: elkservers`.

*Which URL do you navigate to in order to check that the ELK server is running?*
- http://[ELK-VM Public IP]:5601 brings you to the Kibana website/dashboard.

