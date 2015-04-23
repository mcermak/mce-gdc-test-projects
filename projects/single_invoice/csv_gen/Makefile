-include .config

# The default target of this Makefile is this
all::

# Define V=1 to have a more verbose compile.
#
# .config
# gen sparse invocie
# $ echo "SPARSE_ROW=y" >> .config

PROGRAM = sig

CFLAGS = -g -O2 -Wall
LDFLAGS =

BASIC_CFLAGS :=
BASIC_LDFLAGS :=

CC = cc
RM = rm -f
INSTALL = install

obj-y :=
obj-h :=

ifndef SHELL_PATH
       SHELL_PATH = /bin/sh
endif

obj-y += sig.o
obj-x += simple_invoice_gen.o

dep_check = $(shell $(CC) $(ALL_CFLAGS) \
       -c -MF /dev/null -MQ /dev/null -MMD -MP \
       -x c /dev/null -o /dev/null 2>&1; \
       echo $$?)

ifneq ($(dep_check),0)
$(error please use newer gcc or contact *me*)
endif

### Quite rules
ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
       QUIET_CC       = @echo '  ' CC '  '$@;
       QUIET_LINK     = @echo '  ' LINK $@;

       export V
endif
endif

ifeq ($(SPARSE_ROW),y)
       BASIC_CFLAGS += -DSPARSE_ROW
endif

### Build rules
all:: $(PROGRAM)

ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
ALL_LDFLAGS = $(LDFLAGS) $(BASIC_LDFLAGS)

dep_files := $(foreach f,$(obj-y),$(dir $f).depend/$(notdir $f).d)
dep_dirs := $(addsuffix .depend,$(sort $(dir $(obj-y))))
missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
dep_file = $(dir $@).depend/$(notdir $@).d
dep_args = -MF $(dep_file) -MQ $@ -MMD -MP
$(dep_dirs):
	@mkdir -p $@

$(PROGRAM): $(obj-y) $(obj-x)
	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $(PROGRAM) $(obj-y) $(obj-x) $(ALL_LDFLAGS)

$(obj-y): %.o: %.c $(missing_dep_dirs)
	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<

$(obj-x): %.o: %.c $(missing_dep_dirs)
	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(ALL_CFLAGS) $<


dep_files_present := $(wildcard $(dep_files))
ifneq ($(dep_files_present),)
include $(dep_files_present)
endif

clean:
	$(RM) *.o $(PROGRAM)
	$(RM) -r .depend

.PHONY: clean FORCE
