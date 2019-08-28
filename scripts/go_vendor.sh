#!/usr/bin/env bash

# This is a simple script to help developers who use dep for golang.
# If the developer works through serveral projects which are linked each other,
# it could be annoying sometimes.
# for example there's a core project and project A, B use the core project via import.
# then he might have to update verdor directory of project A, B whenever the core has been changed.
#
# Here's a trick.
# 1) work directly in gopath/repository-path/core-project
# 2) remove(or rename) vendor directory of project A, B, then project A, B refer gopath/repository-path/core-project
# not ./vendor/repository-path/core-project
# 3) after finishing work, restore vendor using dep ensure -update.
#
# this script will help you for above routines.

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
else
	case $1 in
		dev)
			echo "It will remove vendor directory and assume-unchanged at git."
			echo ""
			# echo "rm -rf ./vendor"
			# rm -rf ./vendor
			echo "mv ./vendor ./vendor_tmp"
			mv ./vendor ./vendor_tmp
			# echo "git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin"
			# git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin
			echo "git ls-files -z ./vendor/ ./vendor_tmp/ | xargs -0 git update-index --assume-unchanged"
			git ls-files -z ./vendor/ ./vendor_tmp/ | xargs -0 git update-index --assume-unchanged
			;;
		deploy)
			echo "It will recover assumed-unchanged files at git and update vendor directory."
			echo ""
			echo "mv ./vendor_tmp ./vendor"
			mv ./vendor_tmp ./vendor
			echo "git assumed | xargs git update-index --no-assume-unchanged"
			git assumed | xargs git update-index --no-assume-unchanged
			echo "dep ensure -update"
			dep ensure -update
			;;
		*)
			echo "Usage:"
			echo ""
			echo "for development: go_vendor.sh dev"
			echo "for deploy: go_vendor.sh deploy"
			;;
	esac
fi
