#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

helpMessage()
{
   echo "build-images.sh: Use packer to build images for deployment"
   echo ""
   echo "Help: build-images.sh"
   echo "Usage: ./build-images.sh -n hostname -v version"
   echo "Flags:"
   echo -e "-n hostname \t\t\t(Mandatory) Name of the host for which to build images"
   echo -e "-v version \t\t\t(Mandatory) Version stamp to apply to images, e.g. 20210101-1"
   echo -e "-m mariadb_version \t(Optional) Override default mariadb version to use for the mariadb image, e.g. 10.6.4 (default)"
   echo -e "-h \t\t\t\tPrint this help message"
   echo ""
   exit 1
}

errorMessage()
{
   echo "Invalid option or mandatory input variable is missing"
   echo "Use \"./build-images.sh -h\" for help"
   exit 1
}

# Default software versions
mariadb_version='10.6.4'

while getopts n:c:v:h flag
do
    case "${flag}" in
        n) hostname=${OPTARG};;
        v) version=${OPTARG};;
        m) mariadb_version=${OPTARG};;
        h) helpMessage ;;
        ?) errorMessage ;;
    esac
done

if [ -z "$hostname" ] || [ -z "$version" ] || [ -z "$mariadb_version" ] # || [ -z "$consul_template_version" ]
then
   errorMessage
fi


echo "Building images for ryo-mariadb module on "$hostname""
echo ""
echo "Building MariaDB image"
echo ""
echo "Executing command: packer build -var \"host_id="$hostname"\" -var \"version="$version"\" -var \"mariadb_version="$mariadb_version"\" "$SCRIPT_DIR"/image-build/mariadb.pkr.hcl"
echo ""
packer build -var "host_id="$hostname"" -var "version="$version"" -var "mariadb_version="$mariadb_version"" "$SCRIPT_DIR"/image-build/mariadb.pkr.hcl
echo ""
