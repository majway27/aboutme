#!/bin/bash
JEKYLL_ENV=production

#jekyll build
jekyll build --incremental
find _site/ -name "*.xml" -delete

#aws s3 cp _site s3://majway.com/ --recursive
aws s3 sync _site s3://majway.com/ --exclude _site/tag*