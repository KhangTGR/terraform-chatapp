#! /bin/bash

if [[ $1 == 'fmt' ]]
then
    terraform fmt
elif [[ $1 == 'state' ]]
then
    terraform state
elif [[ $1 == 'init' ]]
then
    terraform init
elif [[ $1 == 'apply' ]]
then
    terraform apply
elif [[ $1 == 'plan' ]]
then
    terraform plan
elif [[ $1 == 'run' ]]
then
    terraform init
    terraform apply -auto-approve
elif [[ $1 == 'destroy' ]]
then
    terraform destroy
elif [[ $1 == 'kill' ]]
then
    terraform destroy -auto-approve
else
    echo "Please enter either: fmt, state, init, apply, plan, run, destroy, kill"
fi
