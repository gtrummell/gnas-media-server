.PHONY: help
.DEFAULT_GOAL := help
VERSION=`cat VERSION`

# Self-documenting Makefile based on code written by [François Zaninotto](http://bit.ly/2PYuVj1)

help:
	@echo "Make targets for GNAS Linuxserver.io HTPC Portainer Templates:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean: ## Sanitize the workspace by removing containers"
	@echo "Sanitize the workspace by removing containers"
	-docker -l fatal stop gnas-portainer-tempates
	-docker -l fatal rm -f gnas-portainer-tempates
	-docker -l fatal rmi -f gnas-portainer-templates

get-deps: ## Retrieve dependencies locally
	@echo "Retrieve dependencies locally"
	@docker -l fatal pull hadolint/hadolint:latest
	@docker -l fatal pull nginx:stable-alpine
	@docker -l fatal pull sdesbure/yamllint:latest
	@docker -l fatal pull sahsu/docker-jsonlint:latest

build-image: clean test-template test-dockerfile get-deps ## Build an image from the Dockerfile
	@echo "Build an image from the Dockerfile"
	@docker -l fatal build . -t gtrummell/gnas-portainer-templates:$(VERSION)

test-dockerfile: ## Test the Dockerfile for lint
	@echo "Lint-test the Dockerfile"
	@docker -l fatal run -i --rm hadolint/hadolint:latest < Dockerfile

test-template: ## Test the Portainer Templates JSON file for lint
	@echo "Lint-test the Portainer Templates JSON file"
	@docker -l fatal run -v ${PWD}:/jsonlint --rm sahsu/docker-jsonlint jsonlint -q /jsonlint/templates.json

ci: test-template test-dockerfile ## Run all tests
