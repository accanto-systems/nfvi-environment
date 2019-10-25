# Environment setup

The following is a description of the NFVI environment architecture and setup. These environment aspects are automated in the Ansible scripts

## Host networking & hypervisor

The Ubuntu bionic bare metal host is configured as follows to provide a hypervisor and networking foundation for Openstack and Kubernetes installations. 

### Hypervisor

KVM is installed and requires nested virtualisation/kvm to be enabled on the host machine. You can check this by running the following commands. 

```
cat /sys/module/kvm_intel/parameters/nested
Y
# if the result is [N], change like follows and reboot the system )
echo 'options kvm_intel nested=1' >> /etc/modprobe.d/qemu-system-x86.conf
```

### Openstack Networking

Openstack requires the following openvswitches to be in place on the host machine. 

* **br-ex**: All public tenant networking traffic will appear on this switch
* **br-tun**: This switch carries all inter compute node tenant network tunnels


#### Mininet configuration

The inter VIM network fabric openvswitches are managed by a mininet application. The following switches are created:

* S1, S2 - Openstack TOR switches
* S3, S4 - Kubernetes TOR switches
* S5, S6 - Spline switches

The mininet application has a rest API that can start/stop and remove the switches as follows
* http://localhost:5000/start - this will create the switches and their connections
* http://localhost:5000/stop - this will remove the switches but keep the mininet application running
* http://localhost:5000/exit - this will remove the switches and kill the mininet application

All switches specify they are managed by an external Openflow controller on the local host. 

### Onos SDN Controller

Onos SDN controller is run as a system service on the local machine. A number of plugins are enabled by default
* org.onosproject.openflow - enabled to manage the mininet openflow openvswitches
* org.onosproject.fwd - reactive forwarding learning switch

### Skydive

Skydive analyser is run on the host maching with a generated topology of Openstack and Kubernetes compute and worker nodes. 

## Openstack configuration

Openstack virtual machines are created with vagrant. Vagrant usese Centos7 images built using Accanto [base image project](https://github.com/accanto-systems/base-vagrant-images) and hosted on vagrantup.

![Openstack Setup](/docs/images/openstack.PNG)

The Openstack virtual machines are configured with bonded NICs that are connected to the mininet network fabric. 

Packstack configures the virtual machines with a "Stein" Openstack distribution. 

The compute nodes are provisioned with a **"br-vlan"** openvswitch that is bound to the provider bonded NICs. Packstack is then configured with **"br-vlan"** as the provider network named **"provider"**. The network named **"provider"** can then be named as a VLAN network in Neutron networks created in Openstack. 

## Kubeadm configuration

Kubernetes virtual machines are created with Vagrant. Vagrant uses Ubuntu Xenial images built using Accanto [base image project](https://github.com/accanto-systems/base-vagrant-images) and hosted on vagrantup.

![Kubeadm Setup](/docs/images/k8s.PNG)

As with Openstack, the Kubernetes worker nodes are configured with bonded NICs that are connected to the mininet network fabric. 

Kubeadm configures the virtual machines. 

Provider networking is added by deploying Intel's Multus CNI plugin and also added a number of networks that bind to the bonded NICs on each worker node. Each multus network created is configured with Vlan IDs that allow PODs to communicate with Virtual Machines attached to provider networks on Openstack. 




