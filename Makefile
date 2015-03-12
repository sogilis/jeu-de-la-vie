
#SOURCES  := $(wildcard src/*.c)
#OBJECTS  := $(SOURCES:.c=.o)
#DEPENDS  := $(SOURCES:.c=.d)
#LINKDEFS := $(SOURCES:.c=.link)

#define GEN_DEP =
#	( \
#	echo -n "$(dir $*)"; \
#	cat $*.Dd; \
#	sed 's:^.*\::$@\::' $*.Dd; \
#	grep "%link " $*.Dl | sed "s/%%link/\n%link/g" | cut -d' ' -f2- \
#	  | sed 's:\$$TARGET\$$:$*:g'; \
#	echo '$*: $*.o $*.c ; $$(CCLD)'; \
#	) > $@
#endef

#define CCLD =
#	@echo "  CCLD  $@"
#	@$(CC) -Ilinkopts -o $@ $< $(TARGET_OBJECTS)
#endef

#% .o %.d: %.c
#	$(CC) -c -MD -MF $*.dd -Ilinkopts -o $*.o $<
#	cp $*.dd $*.d; \
#	  sed -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' \
#	  -e '/^$$/ d' -e 's/$$/ :/' < $*.d >> $*.P; \
#	  rm -f $*.dd

#%.link: %.c
#	$(CPP) -DINSPECT_LINK -Ilinkopts -MD -MF $*.ld $< -o $*.llink
#	(sed 's:^.*\::$@\::' $*.ld; grep "^%link " $*.llink | cut -d' ' -f2- | sed 's:\$$TARGET\$$:$*:g') > $@
#	rm -f $*.llink $*.ld

#CPPFLAGS += -Ilinkopts
#%.D: %.c
#	@echo "  DEP   $@"
#	@$(CPP) $(CPPFLAGS) -DINSPECT_LINK -MD -MF $*.Dd $< -o $*.Dl
#	@$(GEN_DEP)
#	@-$(RM) -f $*.Dd $*.Dl
#
#%.o: %.c
#	@echo "  CC    $@"
#	@$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
#
#include $(DEPENDS)
#include $(LINKDEFS)

src/catch.hpp:
	@echo "  CURL  $@"
	curl -Ls -o $@ https://raw.github.com/philsquared/Catch/master/single_include/catch.hpp

include linkopts/gendeps.make
include src/main.D
include src/tests.D

clean:
	rm -f src/*.D src/*.o

#ifdef DEP_TARGET
#include $(DEP_TARGET).D
#$(DEP_TARGET): $(DEP_TARGET).o
#	@echo "  CCLD  $@"
#	@$(CC) -Ilinkopts -o $@ $< $(TARGET_OBJECTS)
#endif
#
#%: %.D
#	@$(MAKE) DEP_TARGET='$@' '$@'
