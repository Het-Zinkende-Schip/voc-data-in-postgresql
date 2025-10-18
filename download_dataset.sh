#!/usr/bin/env bash
set -e

ZIP_URL="https://zenodo.org/records/10599528/files/VOC_Dataset.zip?download=1"
ZIP_PATH="dataset_download/VOC_Dataset.zip"

mkdir -p "dataset_download"

echo "downloading VOC dataset"

if [ -f "$ZIP_PATH" ]; then
  echo "dataset already exists at $ZIP_PATH"
else
  echo "downloading from $ZIP_URL"
  curl -L "$ZIP_URL" -o "$ZIP_PATH"
  echo "download complete: $ZIP_PATH"
fi
