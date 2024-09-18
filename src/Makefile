# Makefile for compiling required oct files

MKOCTFILE ?= mkoctfile

# libraries with functions for socket connections
ifneq (,$(findstring mingw,$(shell $(MKOCTFILE) -p CANONICAL_HOST_TYPE)))
SOCK_LIBS ?= -lws2_32 -lwsock32
endif

all:
	$(MKOCTFILE) webserve.cc $(SOCK_LIBS)
