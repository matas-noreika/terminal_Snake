############################################################################
#C Compiler
CC=gcc
#C Compiler Flags
CCFLAGS=-I./include
############################################################################


############################################################################
#Local project directories
LOCALSRC=./src
LOCALOBJ=./obj
LOCALBIN=./bin
LOCALEXAMPLES=./examples
LOCALDATA=./data
############################################################################


############################################################################
#All executable targets to build
TARGETS:=snake
TARGETS:=$(addsuffix .exe, $(addprefix $(LOCALBIN)/,$(TARGETS)))
#All example programs
EXAMPLES:=$(wildcard $(LOCALEXAMPLES)/*.c)
EXAMPLES:=$(EXAMPLES:$(LOCALEXAMPLES)/%.c=$(LOCALBIN)/%.exe)
#All source files
SRCS=$(wildcard $(LOCALSRC)/*.c)
#All target object files from sources (excluding the target files)
OBJS:=$(filter-out $(TARGETS:$(LOCALBIN)/%.exe=$(LOCALOBJ)/%.o),$(SRCS:$(LOCALSRC)/%.c=$(LOCALOBJ)/%.o))
############################################################################


############################################################################
#rule to provide available make rules
all:
	@echo "Available make commands:"
	@echo "build - builds all targets including examples and tests"
	@echo "clean - removes all build targets including examples and tests"
	@echo $(EXAMPLES)
#Rule to build all targets including examples and tests
build: $(TARGETS) $(EXAMPLES)
############################################################################


############################################################################
## rules to make object files
$(LOCALOBJ)/%.o: $(LOCALSRC)/%.c
	$(CC) $(CCFLAGS) -c $< -o $@
############################################################################


############################################################################
# Executables
# Object files for core library components are linked during this stage
$(LOCALBIN)/%.exe: $(OBJS) $(LOCALSRC)/%.c
	$(CC) $(CCFLAGS) $^ -o $@
#Generates all example program executables
$(LOCALBIN)/%.exe: $(OBJS) $(LOCALEXAMPLES)/%.c
	$(CC) $(CCFLAGS) $^ -o $@
############################################################################


############################################################################
#Rule to clean all build target files
clean:
	@echo "Performing clean..."
	@-rm $(LOCALBIN)/*.exe 2> /dev/null || true
	@-rm $(LOCALBIN)/*.o 2> /dev/null || true
	@-rm $(LOCALOBJ)/*.o 2> /dev/null || true
	@-rm $(LOCALDATA)/*.txt 2> /dev/null || true
	@echo "Clean complete!"
##########################################################################
