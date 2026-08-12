This repository contains utilities to create VMs on your windows machine, making it ready to run kubernetes!

`cka-shell.yaml` defines the VM you'll use to interact with your kubernetes cluster.

`k8s-node.yaml` defines a kubernetes node. 

`create-lab.ps1` creates the VMs that you will use in your cluster as well as the interaction terminal VM.
`create-lab.sh` is UNTESTED. Double check anything you run first!

Make sure you install `multipass`, otherwise the powershell script won't work. 

I wanted to play around with kubernetes and maybe attempt the cka exam. 
Unfortunately I have a single machine that is network capable (my desktop) and things like minikube and kind aren't immersive enough. 

## Prerequisites

`Hyper-V` to run VMs
`multipass` to interact with hyper V easily

## Instructions

Run `create-lab.ps1`.

Make sure your VMs exist using `multipass list`.
Example output:
```
Name            State      IPv4             Image
controlplane    Running    172.25.160.10    Ubuntu 24.04 LTS
worker01        Running    172.25.160.11    Ubuntu 24.04 LTS
worker02        Running    172.25.160.12    Ubuntu 24.04 LTS
```

After that, set up your kubernetes cluster. 

I used `kubeadm` and ran through their [docs](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/). Docs are a bit confusing. 

## Recommendations

Take snapshots of important checkpoints you want to restore to. This way you can brick your setup as much as you want and just revert it.

```bash
multipass stop controlplane worker01 worker02 cka-shell
multipass snapshot controlplane --name clean-cluster
multipass snapshot worker01 --name clean-cluster
multipass snapshot worker02 --name clean-cluster
multipass snapshot cka-shell --name clean-cluster
multipass start controlplane worker01 worker02
```

Restore with
```
multipass stop controlplane worker01 worker02
multipass restore controlplane.clean-cluster
multipass restore worker01.clean-cluster
multipass restore worker02.clean-cluster
```

To start, I would make a few checkpoints:
- base-linux (Ubuntu + containerd + kubeadm installed, no cluster)
- kubeadm-initialized (kubeadm init done, workers joined)
