# The name of the source files
SOURCES = main.c

# Flags for compilation (adding warnings are always good)
CFLAGS = -Wall

# Flags for linking (none for the moment)
LDFLAGS =

# Libraries to link with (none for the moment)
LIBS =

# This creates a list of object files from the source files
OBJECTS = $(SOURCES:%.c=%.o)

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all

# Having an "all" target is customary, so one could write "make all"
# It depends on the executable program
all: $(pname)

# This will link the executable from the object files
$(pname): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(pname) $(LIBS)

# This is a target that will compile all needed source files into object files
# We don't need to specify a command or any rules, "make" will handle it automatically
%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

# Target to clean up after us
clean:
	-rm -f $(pname)      # Remove the executable file
	-rm -f $(OBJECTS)  # Remove the object files

install: $(pname)
	mkdir -p $(out)/bin
	install -m 755 $(pname) $(out)/bin/$(pname)

main.o: main.c

