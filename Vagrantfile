Vagrant.configure("2") do |config|
  
  config.vm.provider "virtualbox" do |vb|
      vb.name = "opstree"
      vb.memory = "4096"
      vb.cpus = "1"
  end
 
  config.vm.box = "centos/7"
  config.vm.network "public_network",
    ip: "192.168.0.17"
  
  config.vm.define "vj_mk" do |vj_mk|
  
  args = []
  config.vm.provision "shell",
    path: "scripts/setup.sh",
    args: args
  end
  
  end
