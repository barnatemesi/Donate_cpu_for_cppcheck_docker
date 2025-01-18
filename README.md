# Disclaimer
No warranty or support is given. Project is as is. Use it at your own risk!

Please consider supporting (in any way or shape) the cppcheck project!

# Donate_cpu_for_cppcheck_docker
Docker container for donating CPU(s) for the cppcheck project. 
The python script provided by the project will analyse debian source code and upload the results to a cppcheck server. We need these results both to improve Cppcheck and to detect regressions.

There is no officially supported docker image yet. Instead of running the project from the terminal with the given python command, I thought it would be nice to a docker image of this and manage it with your other docker images.

# Install
Download the latest cppcheck from their source such as:

https://github.com/danmar/cppcheck

Place the `Dockerfile` in root.

# Usage
Building the image: 

`docker build -t <container-name> -f path/to/your/Dockerfile .`

The provided python script might fail due to external server issues. In order to force restart of the container update the restart setting (does not need to be `unless-stopped`):

`docker update --restart=unless-stopped <container-name>`

The number of CPUs donated might be configured as shown below:

`docker run -e NUM_OF_CPUS=8 <container-name>`

# Sources

http://cppcheck.net/

https://cppcheck.sourceforge.io/
