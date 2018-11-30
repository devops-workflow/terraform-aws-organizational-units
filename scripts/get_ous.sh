#!/usr/local/bin/bash
# #!/bin/bash
#
# This script is expected to be from Terraform via external provider

# Get the current OU names and ids
#
# Parameters:
#   aws_profile   AWS profile

set -e
eval "$(jq -r '@sh "aws_profile=\(.aws_profile)"')"

root_id=$(aws organizations list-roots --profile ${aws_profile} | jq -r .Roots[0].Id)

ou_exists_list=$(aws organizations list-organizational-units-for-parent --parent-id ${root_id} --profile ${aws_profile} | jq -r '.OrganizationalUnits[] | [.Name, .Id] | join(":")')
declare -A ou_lookup
for ou in ${ou_exists_list}; do
  ou_lookup["${ou%%:*}"]="${ou##*:}"
done

# can only return strings
#echo "{\
# \"ou_names\": $(echo -n "${!ou_lookup[@]}" | jq -cRs 'split(" ")'),\
# \"ou_ids\": $(echo -n "${ou_lookup[@]}" | jq -cRs 'split(" ")') \
#}"

json="{"
for ou in "${!ou_lookup[@]}"; do
  json="${json} \"${ou}\":\"${ou_lookup[${ou}]}\","
done
json="${json%%,}"
json="${json} }"
echo "${json}"
