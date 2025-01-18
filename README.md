# Disclaimer
No warranty or support is given. Project is as is. Used it at your own risk!

# Donate_cpu_for_cppcheck_docker
Docker container for donating CPU for the cppcheck project.

There is no officially supported docker image yet. Instead of running the project from the terminal with the given python command, I thought it would be nice to a docker image of this and manage it with your other docker images.

# Install
Download the latest cppcheck from their source such as:

https://github.com/danmar/cppcheck

# Usage
Building the image: 

`docker build -t <image-name> -f path/to/your/Dockerfile .`

The provided python script might fail due to external server issues. In order to force restart of the container update the restart setting (does not need to be `unless-stopped`):

`docker update --restart=unless-stopped <container-name>`

The number of CPUs donated might be configured as shown below:

`docker run -e NUM_OF_CPUS=8 <container-name>`

# Sources

http://cppcheck.net/

https://cppcheck.sourceforge.io/
