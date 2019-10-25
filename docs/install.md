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

### Clean your environment

You can remove an NFVI environment by running the following ansible playbook. 

```
ansible-playbook -i inventory.yaml clean-nfvi.yaml
```

## Accessing the environment

### VNC

The easiest way to access the NFVI services is through VNC. Ensure port 5901 is open on your host firewall. 

Tight VNC Server is installed and can be run with the following command on the host machine

```
vncserver -geometry 1600x1200
```

