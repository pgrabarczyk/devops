#!/bin/bash
# Script should download, install jdk 1.8 and set JAVA_HOME

# Required parameters
JAVA_HOME="/opt/java"
JAVA_HOME_SCRIPT_PATH="/etc/profile.d/java_home.sh"
OWNER_USERNAME="ubuntu"
OWNER_GROUP="ubuntu"

sudo apt-get update
sudo apt-get install -y wget unzip

# Download and install Java Development Kit (JDK) 1.8
wget \
	--no-check-certificate \
	--no-cookies \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz
tar -xzf jdk-8u144-linux-x64.tar.gz
sudo mv jdk1.8.0_144 $JAVA_HOME
rm jdk-8u144-linux-x64.tar.gz
sudo chown -R $OWNER_USERNAME:$OWNER_GROUP $JAVA_HOME/
# /Download and install Java Development Kit (JDK) 1.8

# Set JAVA_HOME script
sudo cat > $JAVA_HOME_SCRIPT_PATH <<EOT
#!/bin/sh
export JAVA_HOME=$JAVA_HOME
EOT
sudo cat >> $JAVA_HOME_SCRIPT_PATH <<'EOT'
export PATH=$JAVA_HOME/bin:$PATH
EOT
sudo chmod +x $JAVA_HOME_SCRIPT_PATH
source $JAVA_HOME_SCRIPT_PATH
# /Set JAVA_HOME script

# Download and install Java Cryptography Extension (JCE)
wget \
	--no-check-certificate \
	--no-cookies \
	--header "Cookie: oraclelicense=accept-securebackup-cookie" \
	http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip
unzip jce_policy-8.zip
rm $JAVA_HOME/jre/lib/security/local_policy.jar
rm $JAVA_HOME/jre/lib/security/US_export_policy.jar
mv UnlimitedJCEPolicyJDK8/*.jar $JAVA_HOME/jre/lib/security
rm -rf UnlimitedJCEPolicyJDK8
rm -rf jce_policy-8.zip
# /Download and install Java Cryptography Extension (JCE)
