OLED_ENABLE = yes
WPM_ENABLE = yes
KEY_OVERRIDE_ENABLE = no
LTO_ENABLE = yes
RGB_MATRIX_ENABLE = yes
SRC += oled.c

# Bootloader definition
BOOTLOADER = atmel-dfu

# Space-saving disables (Disabling unused features to save flash memory for OLED and RGB)
CONSOLE_ENABLE = no
COMMAND_ENABLE = no
MOUSEKEY_ENABLE = no
SPACE_CADET_ENABLE = no
GRAVE_ESC_ENABLE = no
MAGIC_ENABLE = no

# Ensure media keys work (KC_MPLY, KC_VOLD, KC_VOLU, etc.)
EXTRAKEY_ENABLE = yes
