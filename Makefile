.PHONY: ansible docker

REQS := requirements.txt

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
  match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
  if match:
    target, help = match.groups()
    print("%-20s %s" % (target, help))
endef

export PRINT_HELP_PYSCRIPT

help: 
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

docker: ## build docker container for testing
	@echo "Building test env with docker-compose"
	docker-compose -f docker/docker-compose.yml build homelab
	@docker-compose -f docker/docker-compose.yml run homelab /bin/bash

python: ## setup python3
	pip3 install -rrequirements/requirements.txt

test: python ## run tests in container
	pip3 install -rrequirements/requirements-test.txt
