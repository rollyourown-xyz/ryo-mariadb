#!/bin/bash

# Script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

helpMessage()
{
  echo "delete-terraform-state.sh: Delete the terraform state for the module deployed on a host server"
  echo ""
  echo "Help: delete-terraform-state.sh"
  echo "Usage: ./delete-terraform-state.sh -n hostname"
  echo "Flags:"
  echo -e "-n hostname \t\t(Mandatory) Name of the host for which the terraform state is to be deleted"
  echo -e "-h \t\t\tPrint this help message"
  echo ""
  exit 1
}

errorMessage()
{
  echo "Invalid option or mandatory input variable is missing"
  echo "Use \"./delete-terraform-state.sh -h\" for help"
  exit 1
}

while getopts n:m:h flag
do
  case "${flag}" in
    n) hostname=${OPTARG};;
    h) helpMessage ;;
    ?) errorMessage ;;
  esac
done

if [ -z "$hostname" ]
then
  errorMessage
fi

# Get Module ID from configuration file
MODULE_ID="$(yq eval '.module_id' "$SCRIPT_DIR"/../configuration/configuration.yml)"

# Delete terraform state for module on "$hostname"
echo ""
echo "Deleting terraform state for module "$MODULE_ID" on "$hostname""
rm -R "$SCRIPT_DIR"/../module-deployment/terraform.tfstate.d/"$hostname"/terraform.tfstate