FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base

# Install the SSHD server
RUN apt-get update \ 
 && apt-get install -y --no-install-recommends openssh-server \ 
 && mkdir -p /run/sshd

# Set password to '123456'. Change as needed.  
RUN echo "root:123456" | chpasswd

#Copy settings file. See elsewhere to find them. 
COPY sshd_config /etc/ssh/sshd_config

# Install Visual Studio Remote Debugger
RUN apt-get install zip unzip
RUN curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l ~/vsdbg  
EXPOSE 2222
CMD ["service", "ssh", "start"]
