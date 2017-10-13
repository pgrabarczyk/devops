#!/bin/bash
# Script should download, install MAVEN and add it to PATH

# Required parameters
MAVEN_HOME="/opt/maven"
MAVEN_SCRIPT_PATH="/etc/profile.d/maven.sh"
OWNER_USERNAME="pgrabarczyk"
OWNER_GROUP="pgrabarczyk"

sudo apt-get update
sudo apt-get install -y wget tar

# Download and install maven
DOWNLOAD_URL="http://www-eu.apache.org/dist/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz"
DOWNLOADED_FILENAME=$(basename "$DOWNLOAD_URL")
wget $DOWNLOAD_URL
sudo mkdir -p $MAVEN_HOME
sudo tar -xzf $DOWNLOADED_FILENAME -C $MAVEN_HOME --strip 1
rm $DOWNLOADED_FILENAME
sudo chown -R $OWNER_USERNAME:$OWNER_GROUP $MAVEN_HOME
# /Download and install maven

# Set PATH script
sudo cat > $MAVEN_SCRIPT_PATH <<EOT
#!/bin/sh
export MAVEN_HOME=$MAVEN_HOME
EOT
sudo cat >> $MAVEN_SCRIPT_PATH <<'EOT'
export PATH=$MAVEN_HOME/bin:$PATH
EOT
sudo chmod +x $MAVEN_SCRIPT_PATH
source $MAVEN_SCRIPT_PATH
# /Set PATH  script
