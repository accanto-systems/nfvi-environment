# NFVI Sandbox

This project deploys an Openstack and Kubernetes NFVI sandbox on a bare metal Ubuntu linux machine. The Openstack and Kubernetes environments are integrated to a provider switching fabric that is controlled by an Onos SDN controller. The environment is setup to mimick a real world resilient data centre for NFV testing purposes.

![NFVI Environment](/docs/images/nfvi-environment.PNG)

The image above shows the major components of the NFVI environment. They are:
* **Openstack**: A [Packstack](https://www.rdoproject.org) environment created with a set of virtual machines that leverage KVM passthrough on the host.  
* **Kubernetes**: [Kubeadm](https://kubernetes.io) environment with [Intel Multus](https://github.com/intel/multus-cni) to accomodate provider networking. 
* **Switching Fabric**: Openvswitch provider fabric is deployed to the host using [mininet](http://mininet.org/). 
* **Onos SDN Controller**: An [Onos controller](https://onosproject.org/) manages the Openvswitch provider fabric. 
* **Skydive**: A [skydive](http://skydive.network/) set of agents and netwowrk analyser are deployed across all environments.

More details on the environment setup can be found [here](/docs/environment.md). 

## Installation

See the [installation guide](/docs/install.md) to customise and create a working NFVI environment.

The Ansible installation scripts will create an NFVI lab environment on a single machine as depicted in the picture below. 

![Lab setup](/docs/images/lab.PNG)

A number of internal linux and openvswith networks will be created that are attached to Openstack and Kubernetes compute and worker virtual machines. 

### Acccessing NFVI Services

* LM - https://192.168.10.5:8082
* CICD Hub - http://192.168.10.5:8084-7
* Openstack Dashboard - http://192.168.10.10 (admin/password)
* K8s dashboard - http://192.168.10.50:31443 
* Onos - locally @ http://127.0.0.1:8181/onos/ui vpn @ http://10.8.0.1:8181/onos/ui (onos/rocks)
* Skydive - locally @ http://127.0.0.1:8082 vpn @ http://10.8.0.1:8082
