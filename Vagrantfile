# -*- mode: ruby -*-
# # vi: set ft=ruby :

Vagrant.require_version ">= 1.7.1"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
VIRTUAL_MACHINES = YAML.load_file('VIRTUAL_MACHINES.yaml')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  VIRTUAL_MACHINES.each do |cfg|
    config.vm.define cfg["vmName"] do |vm_config|
      ######################
      ### PROVIDER STAGE ###
      ######################

      # Base code block for Virtualbox provider
      vm_config.vm.provider :parallels do |parallels, override|
        override.vm.box    = "dreamscapes/archlinux"
        parallels.name    = cfg["vmName"]
        parallels.cpus    = cfg["cores"]
        parallels.memory  = cfg["memory_mb"]
      end

      #######################
      ### VM CONFIG STAGE ###
      #######################

      # Set hostname
      vm_config.vm.hostname = "#{cfg["hostname"]}"   if cfg["hostname"] and cfg["osFam"] == 'nix'

      # Network Configuration
      vm_config.vm.network "private_network", ip: cfg["ip1"]  if cfg["ip1"]
      vm_config.vm.network "private_network", ip: cfg["ip2"]  if cfg["ip2"]

      # Vagrant file sync settings
      #vm_config.vm.synced_folder ".", "/vagrant", type: "rsync"   if cfg["syncVagrant"]
      #vm_config.vm.synced_folder ".", "/vagrant", disabled: true  if cfg["syncVagrant"] == false

      # Set any additional synced folders
      vm_config.vm.synced_folder cfg["syncFolderSrc"], cfg["syncFolderDst"], type: cfg["syncFolderType"]  if cfg["syncFolder"]

      ##########################
      ### PROVISIONING STAGE ###
      ##########################

      vm_config.vm.provision :shell, :path => cfg["shellScript"]  if cfg["shellScript"]
    end
  end
end
