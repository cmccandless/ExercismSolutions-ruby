EXTENSION:=rb
SOURCE_FILES := $(shell find * -type f -name '*.$(EXTENSION)')
EXERCISES := $(shell find * -type f -name '*.$(EXTENSION)' | cut -d/ -f1 | uniq)
LINT_TARGETS := $(addprefix lint-,$(EXERCISES))
OUT_DIR=.build
OBJECTS=$(addprefix $(OUT_DIR)/,$(EXERCISES))


.PHONY: lint test-all
lint: $(LINT_TARGETS)

$(LINT_TARGETS):
	@ echo $@ | sed -E 's/lint-(.+)/\1\/*.js/g' | xargs -n1 | grep -v _test | xargs rubocop

# test:
# 	@ $(foreach FILE,$(FILES), \
# 		$(call dotest,$(FILE)) \
# 	)

# test-all:
# 	@ $(foreach FILE,$(shell ls -d */), \
# 		$(call dotest, $(FILE)) \
# 	)

# define dotest
# 	cd $(1); \
# 	ruby $(OPTS) *_test.rb || exit 1; \
# 	cd ..;
# endef

test-all: $(EXERCISES)

$(EXERCISES): %: $(OUT_DIR)/%

$(OUT_DIR):
	@mkdir -p $@

clean:
	rm -rf $(OUT_DIR)

.SECONDEXPANSION:

GET_DEP = $(filter $(patsubst $(OUT_DIR)/%,%,$@)%,$(SOURCE_FILES))
$(OBJECTS): $$(GET_DEP) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/%,%,$@))
	@ echo "Testing $(EXERCISE)..."
	@ cd $(EXERCISE) && ruby $(OPTS) *_test.rb
	@ touch $@
