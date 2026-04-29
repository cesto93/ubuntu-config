#!/bin/bash

# Check if a file argument was provided
if [ -z "$1" ]; then
    echo "Usage: $0 <filename.puml>"
    exit 1
fi

# Configuration: Update this path to where your plantuml.jar is located
PLANTUML_PATH="/opt/plantuml/plantuml.jar"

# Check if the jar file exists at the specified path
if [ ! -f "$PLANTUML_PATH" ]; then
    echo "Error: plantuml.jar not found at $PLANTUML_PATH"
    exit 1
fi

# Run the conversion
# -tpng: specifies PNG output (default)
echo "Converting $1 to PNG..."
java -jar "$PLANTUML_PATH" -tpng "$1"

if [ $? -eq 0 ]; then
    echo "Success! Image generated."
else
    echo "Error: Conversion failed."
fi
