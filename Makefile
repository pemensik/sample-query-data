XZ=xz
OPTS=-8
KEEP=-k
FORCE=-f

QUERY_FILES=queryfile-example-10million-201202_part01.xz queryfile-example-10million-201202_part02.xz queryfile-example-10million-201202_part03.xz queryfile-example-10million-201202_part04.xz queryfile-example-10million-201202_part05.xz queryfile-example-10million-201202_part06.xz queryfile-example-10million-201202_part07.xz queryfile-example-10million-201202_part08.xz queryfile-example-10million-201202_part09.xz queryfile-example-10million-201202_part10.xz

all: decompress

decompress: $(QUERY_FILES)
	@for F in $(QUERY_FILES); do \
		UNPACKED=$$(basename $$F .xz); \
		if test $$F -nt $$UNPACKED; then \
			echo "# unpacking $$F"; \
			$(XZ) -d $(KEEP) $$F; \
		else \
			echo "# Skipping $$UNPACKED"; \
		fi; \
	done

compress:
	@for F in $(QUERY_FILES); do \
		UNPACKED=$$(basename $$F .xz); \
		if test $$UNPACKED -nt $$F; then \
			echo "# Packing $$F"; \
       			$(XZ) $(OPTS) $(KEEP) $(FORCE) $$UNPACKED; \
		else \
			echo "# Skipping $$UNPACKED"; \
		fi; \
	done

clean: 
	@for F in $(QUERY_FILES); do \
		UNPACKED=$$(basename $$F .xz); \
		rm -vf "$$UNPACKED"; \
	done

c: compress
d: decompress

%: %.xz
	$(XZ) -d $(OPTS) $(KEEP) $(FORCE) $<

