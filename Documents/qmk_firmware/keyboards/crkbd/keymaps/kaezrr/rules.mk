OLED_ENABLE = yes
LTO_ENABLE = yes
RGB_MATRIX_ENABLE = yes
COMBO_ENABLE = yes
CAPS_WORD_ENABLE = yes
SRC += oled.c

# Bootloader definition
BOOTLOADER = atmel-dfu

# Space-saving disables (Disabling unused features to save flash memory for OLED and RGB)
CONSOLE_ENABLE = no
COMMAND_ENABLE = no
KEY_OVERRIDE_ENABLE = no
MOUSEKEY_ENABLE = no
SPACE_CADET_ENABLE = no
GRAVE_ESC_ENABLE = no
MAGIC_ENABLE = no
BACKLIGHT_ENABLE = no
AUDIO_ENABLE = no
RGBLIGHT_ENABLE = no
NKRO_ENABLE = no
BOOTMAGIC_ENABLE = no

# Ensure media keys work (KC_MPLY, KC_VOLD, KC_VOLU, etc.)
EXTRAKEY_ENABLE = yes
