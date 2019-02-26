EXTENSION:=rb
SOURCE_FILES := $(shell find * -type f -name '*.$(EXTENSION)')
EXERCISES := $(shell find * -type f -name '*.$(EXTENSION)' | cut -d/ -f1 | uniq)
LINT_TARGETS := $(addprefix lint-,$(EXERCISES))
LINT_FIX_TARGETS := $(addsuffix -fix,$(LINT_TARGETS))
OUT_DIR=.build
OBJECTS=$(addprefix $(OUT_DIR)/,$(EXERCISES))
LINT_OBJECTS := $(addprefix $(OUT_DIR)/,$(LINT_TARGETS))
LINT_FIX_OBJECTS := $(addprefix $(OUT_DIR)/,$(LINT_FIX_TARGETS))
MIGRATE_OBJECTS := $(addsuffix /.exercism/metadata.json, $(EXERCISES))

.PHONY: clean lint test-all no-skip check-migrate 
all: lint test
pre-push pre-commit: no-skip check-migrate lint test
lint: $(LINT_TARGETS)
lint-fix: $(LINT_FIX_TARGETS)
test: $(EXERCISES)
clean:
	rm -rf $(OUT_DIR)

no-skip:
	@ ! grep -rE '^\s+ skip' .

check-migrate: $(MIGRATE_OBJECTS)

$(MIGRATE_OBJECTS):
	@ [ -f $@ ] || $(error "$(shell echo $@ | cut -d/ -f1) has not been migrated")

dev:
	@ echo $(MIGRATE_OBJECTS)

$(LINT_TARGETS): %: $(OUT_DIR)/%
$(LINT_FIX_TARGETS): %: $(OUT_DIR)/%
$(EXERCISES): %: $(OUT_DIR)/%

$(OUT_DIR):
	@ mkdir -p $@

.SECONDEXPANSION:

GET_DEP = $(filter $(patsubst $(OUT_DIR)/%,%,$@)%,$(SOURCE_FILES))
$(OBJECTS): $$(GET_DEP) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/%,%,$@))
	@ echo "Testing $(EXERCISE)..."
	@ cd $(EXERCISE) && ruby $(OPTS) *_test.rb
	@ touch $@

GET_DEP_LINT = $(filter $(patsubst $(OUT_DIR)/lint-%,%,$@)%,$(SOURCE_FILES))
$(LINT_OBJECTS): $$(GET_DEP_LINT) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/lint-%,%,$@))
	@ echo "linting $(EXERCISE)..."
	@ ls $(EXERCISE)/*.rb | xargs -n1 | grep -v _test | xargs rubocop
	@ touch $@
	@ touch $@-fix

GET_DEP_LINT_FIX = $(filter $(patsubst $(OUT_DIR)/lint-%-fix,%,$@)%,$(SOURCE_FILES))
$(LINT_FIX_OBJECTS): $$(GET_DEP_LINT_FIX) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/lint-%-fix,%,$@))
	@ echo "lint-fixing $(EXERCISE)..."
	@ ls $(EXERCISE)/*.rb | xargs -n1 | grep -v _test | xargs rubocop --safe-auto-correct
	@ touch $(patsubst %-fix,%,$@)
	@ touch $@
