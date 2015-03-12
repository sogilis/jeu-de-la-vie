#if defined(INSPECT_LINK)

#define __LINK_ABS_SOURCE(SRC) $(dir $(shell echo __FILE__))$(shell echo SRC)

#define LINK_SOURCE(SRC) \
    %%link CURRENT_TARGET_OBJECTS += $(basename __LINK_ABS_SOURCE(SRC)).o \
    %%link ifeq (__LINK_ABS_SOURCE(SRC),$TARGET$) \
    %%link include $(basename __LINK_ABS_SOURCE(SRC)).D \
    %%link endif

#else

#define LINK_SOURCE(f)

#endif