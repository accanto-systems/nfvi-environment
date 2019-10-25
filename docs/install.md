# Installation instructions 

## Pre-requisites

* Bare metal server with at least 64G Memory and 16 Cores
* Ubuntu Bionic Operating system
* KVM passthrough enabled on server

### Add worker/compute nodes

In the **inventory.yaml** file you can add more worker and compute nodes and to kubernetes and openstack deployments by adding hosts to the workers group for kubernetes and to the compute group for openstack.  

Openstack compute nodes can be added as below:

```
[workers]
worker1 ansible_host=192.168.10.51 vagrant_mem=8192 vagrant_cpu=1
worker2 ansible_host=192.168.10.52 vagrant_mem=8192 vagrant_cpu=1
```

Kubernetes worker nodes can be added as below:

```
[compute]
computenode1 ansible_host=192.168.10.12 vagrant_mem=8192 vagrant_cpu=1
computenode2 ansible_host=192.168.10.13 vagrant_mem=8192 vagrant_cpu=1
```

You must provide ip address, and memory and cpu requirements for each host.

### Configure your environment 

Update the **variables.yaml** file with your required environment configuration and run the following command to create the NFVI sandbox. 

```
ansible-playbook -i inventory.yaml setup-nfvi.yaml
```

## LM Installation

If you chose to create an AIO virtual machine, one will be created with a network attached to the underlay managements provider network. The VM has the following credentials:

* **VM IP address**: 192.168.10.5
* **Username**: vagrant
* **Password**: vagrant

You can install the LM AIO into the created VM by cloning the AIO github project and run its playbooks against 192.168.10.5. 

Within your AIO project you must configure the Ansible LM inventory to connect to the VM above through the base host by configuring an SSH jumphost. If you have a bare metal server with an IP address of 192.168.1.168 and a key called demo.pem, the LM inventory would look as follows: 

```
ansible_connection="ssh" 
ansible_user="vagrant" 
ansible_ssh_pass="vagrant" 
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -i ~/demo.pem -o StrictHostKeyChecking=no -W %h:%p ubuntu@192.168.1.168"'
```

The ALM address is assigned IP address 10.0.30.5 on the provider management network that openstack and k8s machines will attach to. 

## Accessing the environment

### VNC

The easiest way to access the services is through VNC. Ensure port 5901 is open on your host firewall. 

Tight VNC Server is installed and can be run with the following command on the host machine

```
vncserver -geometry 1600x1200
```

