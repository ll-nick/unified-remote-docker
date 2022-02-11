# unified-remote-docker
Dockerized unified remote

[Unified Remote](https://www.unifiedremote.com/) is a brilliant little piece of software to remote control you computer I have been using for years.
Unfortunately, I couldn't find a dockerized version anywhere, so I created one for my Raspberry Pi.

For a different CPU architecture, most of the setup should work quite analogously, so feel free to fork or contribute.

## Set up

For unified remote to work within the container, it needs to have access to /dev/uinput which is how it sends command to the host computer.
Execute the set_permissions.sh script (`./set_permissions.sh`) to create the required udev rules.
For persistent configuration changes using the web ui, the urserver.config file is mounted into the container.
Make sure to copy the provided empty template config (`cp urserver.config.template urserver.config`) before the first use.
That's it, you can now start the docker container using either the provided bash script or the docker-compose.yaml.

`./run.sh`
`docker-compose up -d`

### PiInput

[There seems to be a bug](https://askubuntu.com/questions/1244234/unified-remote-bluetooth-left-and-right-clicks-not-working) with the arm version of unified remote, where the BasicInput remote won't work properly.
Using the bug fix mentioned in the linked discussion, I created the PiInput remote and added it to the docker image.
This step should not be necessary for other archs.
