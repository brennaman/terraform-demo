# Use the light version of the image that contains just the latest binary
FROM hashicorp/terraform:light

# The app folder will contain all our files
WORKDIR /data

# Put all your configration files in the same folder as the Dockerfile
COPY . /data