Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/precise32" // ubuntu 32

    config.vm.define :web |web_config| // nome da imagem 
    
    web_config.vm.network "private_network", ip: "192.168.50.10" //colocando um ip fixo para maquina 
    
    end
end