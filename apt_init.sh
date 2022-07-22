mv ./sources.list /etc/apt

apt update
apt install apt-transport-https ca-certificates -y
sed -e 's|http|https|g' -i /etc/apt/sources.list
apt update

apt install git wget curl lsof net-tools iputils-ping gpg build-essential -y

