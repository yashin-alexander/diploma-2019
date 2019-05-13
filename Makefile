.PHONY: install_deps, install_fonts, generate, all, note, clean, task

FONTS_DIR = fonts
SOURCE_DIR = src
BUILD_DIR = build
STYLES_DIR = styles
ALL_TARGET_FILE = $(BUILD_DIR)/all.tex
NOTE_TARGET_FILE = $(BUILD_DIR)/note.tex
TASK_FILE = $(SOURCE_DIR)/main-task.tex
IMG_DIR = $(BUILD_DIR)/images
TREE_IMG_DIR = $(IMG_DIR)/tree
TREE_TARGET_FILE = $(TREE_IMG_DIR)/tree.tex

_TARGET = $(ALL_TARGET_FILE)
_BIB_TARGET = all

install_deps:
	sudo add-apt-repository ppa:jonathonf/texlive
	sudo apt update && sudo apt install texlive-full
	sudo apt-get install texlive-lang-cyrillic

install_fonts:
	sudo cp -r $(FONTS_DIR)/* /usr/local/share/fonts/
	fc-cache -f -v
	@echo "Fonts installed"

clean:
	rm -rf $(BUILD_DIR)

_generate:
	@$(MAKE) clean
	mkdir -p $(IMG_DIR)
	cp -r $(SOURCE_DIR)/* $(BUILD_DIR)
	cp $(STYLES_DIR)/* $(BUILD_DIR)
	xelatex -output-directory=$(TREE_IMG_DIR) $(TREE_TARGET_FILE)
	xelatex -output-directory=$(BUILD_DIR) $(_TARGET)
	bibtex $(BUILD_DIR)/$(_BIB_TARGET)
	xelatex -output-directory=$(BUILD_DIR) $(_TARGET)
	xelatex -output-directory=$(BUILD_DIR) $(_TARGET)
# Do not modify this target.

all: _TARGET=$(ALL_TARGET_FILE)
note: _BIB_TARGET=all
all: _generate

note: _TARGET=$(NOTE_TARGET_FILE)
note:	_BIB_TARGET=note
note: _generate

task:
	mkdir -p $(BUILD_DIR)
	xelatex -output-directory=$(BUILD_DIR) $(TASK_FILE)
