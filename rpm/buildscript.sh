# Important! On REDHAT/CENTOS you need to enable the EPEL repository. This is not required on Fedora!
sudo yum install epel-release
# See also: http://bit.ly/1xVxGlD
# Or: https://support.rackspace.com/how-to/install-epel-and-additional-repositories-on-centos-and-red-hat/

# Update system
sudo yum update -y
sudo yum upgrade -y

# rpm dependencies
sudo yum install -y rpm-build make wget tar httpd-devel libapreq2-devel R-devel libcurl-devel protobuf-devel openssl-devel libxml2-devel libicu-devel libssh2-devel

### Make sure to do building as non-root user!
# setup dirs
mkdir -p ~/rpmbuild/SOURCES
mkdir -p ~/rpmbuild/SPECS

# Get the rapache sources
wget https://github.com/jeffreyhorner/rapache/archive/v1.2.7.tar.gz -O rapache-1.2.7.tar.gz
tar xzvf rapache-1.2.7.tar.gz rapache-1.2.7/rpm/rapache.spec --strip-components 2
mv -f rapache-1.2.7.tar.gz ~/rpmbuild/SOURCES/
mv -f rapache.spec ~/rpmbuild/SPECS/

# Build rApache
rpmbuild -ba ~/rpmbuild/SPECS/rapache.spec

# Get opencpu sources
wget https://github.com/jeroenooms/opencpu-server/archive/v1.5.tar.gz -O opencpu-server-1.5.tar.gz
tar xzvf opencpu-server-1.5.tar.gz opencpu-server-1.5/rpm/opencpu.spec --strip-components 2
mv -f opencpu-server-1.5.tar.gz ~/rpmbuild/SOURCES/
mv -f opencpu.spec ~/rpmbuild/SPECS/

# Build OpenCPU
rpmbuild -ba ~/rpmbuild/SPECS/opencpu.spec

# Install OpenCPU
sudo yum install MTA mod_ssl /usr/sbin/semanage
cd ~/rpmbuild/RPMS/x86_64/
sudo rpm -i rapache-*.rpm
sudo rpm -i opencpu-lib-*.rpm
sudo rpm -i opencpu-server-*.rpm #takes a while!

# Test OpenCPU
curl http://localhost/ocpu/library/
