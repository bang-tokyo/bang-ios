#!/bin/bash

pre_commit_path=".git/hooks"

if [ -e $pre_commit_path/pre-commit ]; then

   rm -f $pre_commit_path/pre-commit

fi

cp ./setup/hooks/pre-commit $pre_commit_path
