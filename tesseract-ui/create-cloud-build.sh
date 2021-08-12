TESSERACT_URL=$1
PROJECT_ID=$2
REPO_NAME=$3
IMAGE_NAME=$4

echo "
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build',
    '--build-arg', 'TESSERACT_URL=${TESSERACT_URL}',
    '-t', 'us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}',
    '.' 
  ]

images:
- 'us-central1-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}'
"