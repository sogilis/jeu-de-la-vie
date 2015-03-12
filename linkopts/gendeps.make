# kate: hl Makefile;

CCLD ?= $(CC)
CXXLD ?= $(CXX)
GENDEPS_MAKE_FILE   := $(lastword $(MAKEFILE_LIST))
GENDEPS_INCLUDE_DIR := $(dir $(GENDEPS_MAKE_FILE))
CPPFLAGS += -I$(GENDEPS_INCLUDE_DIR)

define CCLD_COMMANDS ?=
	@echo "  CCLD  $@"
	$(CCLD) -Ilinkopts -o $@ $< $(TARGET_OBJECTS)
endef

define CXXLD_COMMANDS ?=
	@echo "  CXXLD $@"
	$(CXXLD) -Ilinkopts -o $@ $< $(TARGET_OBJECTS)
endef

define CC_COMMANDS ?=
	@echo "  CC    $@"
	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
endef

define CXX_COMMANDS ?=
	@echo "  CXX   $@"
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ -c $<
endef

cLD_COMMANDS   = $(CCLD_COMMANDS)
cppLD_COMMANDS = $(CXXLD_COMMANDS)

define DEP_COMMANDS ?=
	@echo "  DEP   $@"
	$(CPP) $(CPPFLAGS) -DINSPECT_LINK -MD -MF $*.Dd $< -o $*.Dl
	( \
	echo -n "$(dir $*)"; \
	cat $*.Dd; \
	sed 's:^.*\::$@\: $(GENDEPS_MAKE_FILE) :' $*.Dd; \
	echo; \
	echo 'ifeq ($$(CURRENT_TARGET_OBJECTS),)'; \
	grep "%link " $*.Dl | sed "s/%%link/\n%link/g" | cut -d' ' -f2- \
	  | sed 's:\$$TARGET\$$:$*:g'; \
	echo '$*: TARGET_OBJECTS := $$(CURRENT_TARGET_OBJECTS)'; \
	echo '$*: $*.o $*$(suffix $<) $$(CURRENT_TARGET_OBJECTS) ; $$($(subst .,,$(suffix $<))LD_COMMANDS)'; \
	echo "undefine CURRENT_TARGET_OBJECTS"; \
	echo "else"; \
	grep "%link " $*.Dl | sed "s/%%link/\n%link/g" | cut -d' ' -f2- \
	  | sed 's:\$$TARGET\$$:$*:g'; \
	echo "endif"; \
	) > $@
	-$(RM) -f $*.Dd $*.Dl
endef

%.D: %.c   ; $(DEP_COMMANDS)
%.D: %.cpp ; $(DEP_COMMANDS)
%.o: %.c   ; $(CC_COMMANDS)
%.o: %.cpp ; $(CXX_COMMANDS)

$(V)$(VERB)$(VERBOSE).SILENT:
