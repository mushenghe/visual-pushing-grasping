set -e

add-apt-repository universe && add-apt-repository restricted && add-apt-repository multiverse
chmod 777 -R /etc/apt/sources.list.d/
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
apt update && apt install -y ros-melodic-desktop-full
rosdep init
rosdep update
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
#source ~/.bashrc
apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential

