#!/usr/local/bin/bash
# #!/bin/bash
#
# This script is expected to be from Terraform via external provider
#
# Parameters:
#   aws_profile   AWS profile
#   ou_list       List of OU names
#
# Assumptions:
#   There is only a single root
#   Only OUs off of root. No nested OUs
#   This only creates OUs. It does not delete or rename them
#
# TODO:
#   support plan & apply - pass as argument and make changes or not. Any reason to do anything during plan?
#   could be 2 scripts: ou managing & account location

# Using Cloud formation & lambda
# https://theithollow.com/2018/09/10/create-aws-accounts-with-cloudformation/

set -e
eval "$(jq -r '@sh "aws_profile=\(.aws_profile) ou_list=\(.ou_list)"')"

#echo "profile: $aws_profile, OUs: $ou_list" 1>&2

root_id=$(aws organizations list-roots --profile ${aws_profile} | jq -r .Roots[0].Id)
ou_exists_list=$(aws organizations list-organizational-units-for-parent --parent-id ${root_id} --profile ${aws_profile} | jq -r .OrganizationalUnits[].Name)

# idempotent
# Loop on OUs per parent - Only support root for now
# if ou not in list ou for parent then create
for ou in ${ou_list}; do
  if [ $(echo ${ou_exists_list} | grep ${ou} | wc -l) -eq 0 ]; then
    #echo "Creating OU: ${ou}" >&2
    aws organizations create-organizational-unit --parent-id ${root_id} --name ${ou} --profile ${aws_profile} >/dev/null 2>&1
    # save id ou_ids[name]=id # Only if want to return what was created
  fi
done

ou_exists_list=$(aws organizations list-organizational-units-for-parent --parent-id ${root_id} --profile ${aws_profile} | jq -r '.OrganizationalUnits[] | [.Name, .Id] | join(":")')
declare -A ou_lookup
for ou in ${ou_exists_list}; do
  ou_lookup["${ou%%:*}"]="${ou##*:}"
done

# OUs: core, environments
# What data should be outputted?
#   all OU names and IDs
#   format?
#   Other things will need to be able lookup OU ID
#   2 ordered lists ${!ou_lookup[@]} ${ou_lookup[@]}

echo "{\
 \"ou_names\":$(echo -n "${!ou_lookup[@]}" | jq -cRs 'split(" ")'),\
 \"ou_ids\":$(echo -n "${ou_lookup[@]}" | jq -cRs 'split(" ")') \
}"
