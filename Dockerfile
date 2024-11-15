# Use the official syslog-ng image as the base image
FROM balabit/syslog-ng:latest

#Add packages
RUN apt-get update && apt-get install -y \
            procps \
            net-tools \
            sudo \
            vim \
            strace

# Add a new user account
RUN groupadd -g 1000 syslog && useradd -u 1000 -g 1000 syslog

# Add syslog user to the sudoers file 
RUN echo 'syslog ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Create necessary directories with appropriate permissions
RUN mkdir -p /var/lib/syslog-ng /var/log/syslog-ng && \
    chown -R 1000:1000 /var/lib/syslog-ng /var/log/syslog-ng

# Copy the syslog-ng.conf into the container 
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

# Copy the entrypoint script into the container 
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the script executable 
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the user to run syslog-ng
USER syslog

# Start syslog-ng
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]