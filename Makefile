.PHONY: sync build-and-push

sync:
	@gh repo sync pasha-gurkov/rawfile-localpv -b develop
build-and-push:
	@./build-and-push-to-k8s-local.sh
