#!/bin/bash

echo "Installing go via snap"
sudo snap install go --classic

sudo go install github.com/jfeliu007/goplantuml/cmd/goplantuml@latest