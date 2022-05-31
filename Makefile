SHELL = /bin/bash
CPCMD = gcc

FLAGS = -std=c17 -Wall -pipe
SHRFLAGS = -fPIC -shared

DEVFLAGS = -fsanitize=address # -g
RELFLAGS = -O3
# TODO flag conditional
############################
LIBFLAGS = $(FLAGS) $(DEVFLAGS)
############################

# Recursively list source files
_rwc = $(foreach d, $(wildcard $(1:=/*)), $(call _rwc,$d,$2) $(filter $(subst *, %, $2), $d))
LIBSRC = $(call _rwc, src, *.c)
LIBOBJ = $(patsubst src/%.c, build/%.o, $(LIBSRC))
# DBGSRC = $(call _rwc, debug, *.c)


# TODO: Determine platform and compile accordingly*
# TODO: Add option for O3 optimization for building a release (and remove address sanitizer)

# Example foreach loop (holding onto this in case I need it)
# @echo $(foreach sf,$(SRCS), src/$(sf))


# Default behavior: will build library and debug program both
.PHONY: all
all: lib debug


# Build object files (with assumed dependency)
build/%.o: src/%.c
	@echo Build $@
	mkdir -p build
	$(CPCMD) -c $(FLAGS) $^ -o $@


# Build the library test program (exectuable named 'debug')
debug: debug.c # $(DBGSRC)
	@echo Build $@ \($^\)...
	$(CPCMD) $(FLAGS) $^ dragonlib.so -o $@


# Build the library itself (named dragonlib.so, dragonlib.dll, or dragonlib.dylib)
lib: $(LIBOBJ)
	@echo Build $@ \($^\)...
	$(CPCMD) $(SHRFLAGS) $(LIBFLAGS) $^ -o dragonlib.so


# Clean out the repo (forces a rebuild upon next call of make)
.PHONY: clean
clean:
	@echo Remove binaries
	rm -rf debug dragonlib.* build
