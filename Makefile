#!/usr/bin/make

# ##############################################################
# ragel stuff. http://www.complang.org/ragel/
DOT			?= dot
RAGEL		?= ragel

RAGEL_DIR := .
GENERATED_DIR := .

RAGEL_SOURCES := $(wildcard ./$(RAGEL_DIR)/*.rl)
RAGEL_GENERATED := $(RAGEL_SOURCES:./$(RAGEL_DIR)/%.rl=./$(GENERATED_DIR)/%.m)
RAGEL_PDF := $(RAGEL_SOURCES:./$(RAGEL_DIR)/%.rl=./$(GENERATED_DIR)/%.pdf)

./$(GENERATED_DIR)/%.m : ./$(RAGEL_DIR)/%.rl
	$(RAGEL) -e -s -G2 -C -o $@ $<
./$(GENERATED_DIR)/%.dot : ./$(RAGEL_DIR)/%.rl
	$(RAGEL) -e -p -V -o $@ $<
%.pdf: %.dot
	$(DOT) -Tpdf -o $@ $<

################################################################
## Run ragel to generate statemachine implementations
generate:	$(RAGEL_GENERATED)

################################################################
## Create ragel statemachine charts - runs literally for hours
doc:	$(RAGEL_PDF)

################################################################
## remove all ragel generated artifacts
clean:
	-rm $(RAGEL_GENERATED) $(RAGEL_PDF)
