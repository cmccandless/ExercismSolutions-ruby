.PHONY: lint test
lint:
	@ls ./*/*.rb | xargs -n1 | grep -v _test | xargs rubocop
	

test:
	@ $(foreach FILE,$(FILES), \
		$(call dotest,$(FILE)) \
	)

test-all:
	@ $(foreach FILE,$(shell ls -d */), \
		$(call dotest, $(FILE)) \
	)

define dotest
	cd $(1); \
	ruby $(OPTS) *_test.rb || exit 1; \
	cd ..;
endef
