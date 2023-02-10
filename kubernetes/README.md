
# Pytesseract-infrastructure

Kubernetes manifests to deploy pytesseract-oec in GKE

## Requirements

- [Running GKE instance](https://cloud.google.com/kubernetes-engine/)
- [GitHub secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository)

```
# Docker
- DOCKER_HUB_USERNAME
- DOCKER_HUB_ACCESS_TOKEN
- DOCKER_HUB_REPOSITORY

# Google
- GCP_PROJECT_ID
- GCP_SA_KEY
- GKE_CLUSTER
- GKE_ZONE
- GKE_DEPLOYMENT_NAME

# Slack
- SLACK_WEBHOOK_URL
```

## Create Kubernetes Secrets
- DB connector, replace the output in [TESSERACT_BACKEND](secrets/tesseract.yaml): `echo -n 'clickhouse://<user>:<password>@<host>/<db>' | base64`
- Access private repos in DockerHub: `kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v1/ --docker-username=<your-username> --docker-password=<your-pword> --docker-email=<your-email>`

## Deploy

- Connect to cluster: `gcloud container clusters get-credentials <cluster-name> --region <cluster-region> --project <project-id>`
- Apply manifests:

```
> kubectl apply -f secrets/docker.yaml
> kubectl apply -f secrets/pytesseract.yaml
> kubectl apply -f python-tesseract.yaml
> kubectl apply -f managed_cert.yaml
> kubectl apply -f ingress.yaml
```

- Get ingress ip: `kubectl get ingress` add it to the DNS provider, the name should match the [domain](managed_cert.yaml) and [host](ingress.yaml)
```
NAME            CLASS    HOSTS                      ADDRESS          PORTS   AGE
nginx-ingress   <none>   pytesseract.datawheel.us   35.186.226.181   80      20d
```


## Util
- GCP_SA_KEY = [service_account.json](https://github.com/Datawheel/company/wiki/Setting-Up-a-Service-Account-for-Workflows#setting-up-a-service-account-for-github-workflows)
- DOCKER_HUB_ACCESS_TOKEN = https://docs.docker.com/docker-hub/access-tokens/#create-an-access-token
- SLACK_WEBHOOK_URL = https://slack.com/help/articles/115005265063-Incoming-webhooks-for-Slack

## Github Actions
To trigger GitHub actions:
- tag a commit: `git tag -a vX.X.X COMMIT_HASH -m "message"`
- push tag: `git push origin vX.X.X`