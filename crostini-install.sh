# enable these options in chrome://flags:
#ignore-gpu-blocklist
#crostini-ime-support
#crostini-gpu-support
#scheduler-configuration
#crostini-container-install -> bullseye

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install mesa-utils -y
glxinfo -B # check gpu accelerated = true

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash miniconda.sh -b -u -p ~/miniconda3

ssh-keygen -t ed25519 -C wchen.hi@gmail.com

git clone git@github.com:wchengit/linux-configs.git
cd linux-configs/
cp .bash* .gitconfig .tmux.conf ~/

~/miniconda3/bin/conda init bash
source ~/.bashrc
conda create -n py310 python=3.10
conda activate py310

git clone git@github.com:wchengit/flexcr.git
cd flexcr
sudo apt-get install make
make all

pip install timeout_decorator bs4
pip install pandas==1.5.3
pip install boto3 matplotlib click
