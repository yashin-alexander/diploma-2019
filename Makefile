FONTS_DIR = fonts
SOURCE_DIR = src
SOURCE_FILE = $(SOURCE_DIR)/main.tex
BUILD_DIR = build

install_fonts:
	sudo cp -r $(FONTS_DIR)/* /usr/local/share/fonts/
	fc-cache -f -v
	@echo "Fonts installed"
build:
	mkdir -p $(BUILD_DIR)
	xelatex -output-directory=$(BUILD_DIR) $(SOURCE_FILE) 

