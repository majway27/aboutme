#!/bin/bash
JEKYLL_ENV=production

jekyll build
aws s3 cp _site s3://majway.com/ --recursive