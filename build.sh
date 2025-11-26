#!/bin/sh
# build.sh - Prepare the build environment for distribution
#
# This script generates a fresh Makefile for creating distributions.
# Note: The SAP NW RFC SDK is NOT required for making a source distribution,
# only for actual compilation. The Makefile.PL will warn about missing SDK
# but will still generate a working Makefile for 'make dist'.

set -e  # Exit on any error

# Clean up any previous build artifacts
if [ -f Makefile ]; then
    echo "Cleaning previous build artifacts..."
    make realclean 2>/dev/null || true
    rm -f Makefile.old
fi

# Clean up generated files
rm -f MYMETA.yml MYMETA.json META.yml META.json

# Generate fresh Makefile
# Note: Will prompt for SDK path if not found, but we can just press Enter
# as we only need the Makefile for 'make dist', not for compilation
echo "Generating Makefile for distribution..."
echo "" | perl Makefile.PL

echo "Build preparation complete. Ready for 'make dist'."
