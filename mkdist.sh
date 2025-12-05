#!/bin/sh
# Get the directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
find . -name '*.log' -type f -exec echo \> {} \;
find . -name 'rfc*trc' -type f -exec rm -f {} \;
find . -name '*~' -type f -exec rm -f {} \;

VERS=0.52
DIST=sapnwrfc-$VERS
BALL=$DIST.tar.gz
ZIP=$DIST.zip

./build.sh

if [ -d $DIST ]; then
  echo "removing: $DIST ..."
  rm -rf $DIST
fi

if [ -f $BALL ]; then
  echo "removing: $BALL ..."
  rm -f $BALL
fi

if [ -f $ZIP ]; then
  echo "removing: $ZIP ..."
  rm -f $ZIP
fi

echo "Creating distribution via make dist..."
make dist

echo "Extracting tarball to create zip..."
tar -xzf $BALL

echo "Creating zip: $ZIP"
zip -r $ZIP $DIST
ls -l $ZIP

echo "Removing temporary files..."
rm -f $BALL
if [ -d $DIST ]; then
  rm -rf $DIST
fi

echo "Done. Created: $ZIP"

chmod a+r $ZIP

#echo "Copy up distribution"
#scp $BALL piersharding.com:www/download/
#scp $ZIP piersharding.com:www/download/
