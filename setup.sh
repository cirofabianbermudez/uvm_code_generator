#!/bin/bash

echo -e "\n[INFO]: Checking dependencies"
DEPENDENCIES=("python3")
for item in "${DEPENDENCIES[@]}"; do
  if command -v $item &> /dev/null; then
    printf "  > %8s is INSTALLED\n" "$item"
  else 
    printf "  > %8s is NOT INSTALLED\n" "$item"
    exit 1
  fi
done
echo -e "[INFO]: All dependencies found\n"

echo "[INFO]: Checking Python Version"
PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
CUR_VERSION=$(echo $PYTHON_VERSION | awk -F. '{print $1"."$2}' )
MIN_VERSION="3.5"
COMPARE=$(echo $PYTHON_VERSION $MIN_VERSION | awk '{ print ( $1 >= $2) }')
printf "  > Detected Python Version: Python %s\n" "$PYTHON_VERSION"
printf "  > Requirement: >= %s\n" "$MIN_VERSION"
if [ "$COMPARE" -eq 1 ]; then
  echo -e "[INFO]: Python Version requirement met"
else
  echo -e "[ERROR] Python Version requirement NOT met"
  exit 1
fi

echo -e "\n[INFO]: Creating Virtual Environment"
rm -rf venv
/usr/bin/python3 -m venv venv
source venv/bin/activate
set +e
pip install --upgrade pip
set -e
pip install -r .python_requirements

ROOT_DIR=$(pwd)
echo -e ""
echo -e "==============================================================================="
echo -e "To activate environment run:"
echo -e " bash: source $ROOT_DIR/venv/bin/activate"
echo -e "  csh: source $ROOT_DIR/venv/bin/activate.csh"
echo -e "==============================================================================="
echo -e ""

