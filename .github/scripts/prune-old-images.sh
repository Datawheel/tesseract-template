#!/bin/bash

# Copyright © 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# adapted from https://gist.github.com/ahmetb/7ce6d741bd5baa194a3fac6b1fec8bb7


IFS=$'\n\t'
set -eu pipefail

main(){
  C=0
  for digest in $(gcloud container images list-tags "${IMAGE_PATH}" --limit=999999 --sort-by=TIMESTAMP \
    --filter "NOT tags:*" --format='get(digest)'); do
    (
      set -x
      gcloud artifacts docker images delete "${IMAGE_PATH}@${digest}" --delete-tags --quiet
    )
    C=$((C+1))
  done
  echo "Deleted ${C} images in ${IMAGE_PATH}." >&2
}

main