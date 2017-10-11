#!/bin/bash
# Script should download and setup JCE for java 1.8

# Required parameters if not set in env:
JAVA_HOME="/opt/java"

sudo apt-get update
sudo apt-get install -y wget unzip
  
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
