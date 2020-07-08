.PHONY: ansible docker python

REQS := python/requirements.txt
REQS_TEST := python/requirements.txt
# Used for colorizing output of echo messages
BLUE := "\\033[1\;36m"
NC := "\\033[0m" # No color/default

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
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then echo "Don't run make docker inside docker container" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build homelab
	@docker-compose -f docker/docker-compose.yml run homelab /bin/bash

docs: python ## Generate documentation
	$(MAKE) print-status MSG="Building documentation with Sphinx"
	#sphinx-quickstart
	cd docs && make html

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

python: ## setup python stuff
	if [ ! -f /.dockerenv ]; then echo "Run make python inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python -m pip install -r$(REQS); fi

test: python ## run tests in container
	@if [ ! -f /.dockerenv ]; then echo "Run make test inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Testing"
	if [ -f '$(REQS_TEST)' ]; then python -m pip install -r$(REQS_TEST); fi
