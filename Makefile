.PHONY: help
.DEFAULT_GOAL := help

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

build-image: test-dockerfile ## Build an image from the Dockerfile
	@echo "Build an image from the Dockerfile"
	@docker -l fatal build . -t gnas-portainer-templates

test-template: clean get-deps ## Test the Portainer Templates JSON file for lint
	@echo "Lint-test the Portainer Templates JSON file"
	@docker -l fatal run -v ${PWD}:/jsonlint --rm sahsu/docker-jsonlint jsonlint -q /jsonlint/templates.json

test-dockerfile: clean get-deps ## Test the Dockerfile for lint
	@echo "Test the Dockerfile for lint and syntax"
	@docker -l fatal run -i --rm hadolint/hadolint:latest < Dockerfile

test-docker-compose: clean get-deps ## Test Docker-compose files for lint and syntax
	@echo "Test Docker-compose files for lint and syntax"
	@docker -l fatal run -v ${PWD}:/yaml --rm sdesbure/yamllint:latest yamllint -d relaxed /yaml
	@for docker_compose_file in $(find stacks/ -type f -name docker-compose.yml); do \
		docker-compose -f $$docker_compose_file ; \
	done

ci: test-template test-dockerfile test-docker-compose ## Run all tests
