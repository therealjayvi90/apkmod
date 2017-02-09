#!/bin/bash

### A script for creating a modified apk based on 
### user input. Uses apktool to decode an apk, then
### prompts for specific modifications.

ROOT_DIR=$(pwd)

### Stores the output directory 
echo What is the name of the output directory?
read APK_OUT

### Stores the name of the apk
echo What is the name of the apk?
read ORIG_APK

### Stores original directory name and what to change it to
read -p 'Enter the the entire path leading to the directory you wish to change: ' ORIG_DIR
read -p 'Enter the new name for the directory: ' MOD_DIR
read -p 'Enter name for the final apk: ' APK_DONE

### Decodes apk
apktool d -f -o $ROOT_DIR/$APK_OUT $ROOT_DIR/$ORIG_APK

### Renames the directories
mv $ROOT_DIR/$ORIG_DIR $ROOT_DIR/$MOD_DIR && cd $ROOT_DIR/$APK_OUT/smali

### Makes the changes reflect inside all internal smali files
find ./ -type f -exec sed -i '' 's/com/gh/g' {} \;
find ./ -type f -exec sed -i '' 's/ghmon/common/g' {} \;

### Updates AndroidManifest.xml
sed -i '' 's/com/gh/g' ../AndroidManifest.xml
sed -i '' 's/ghmon/common/g' ../AndroidManifest.xml

### Return to root of project for apktool to recompile
cd $ROOT_DIR

### Recompile the apk
apktool b -f -o $ROOT_DIR/$APK_DONE $ROOT_DIR/$APK_OUT

