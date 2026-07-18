/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H

enum custom_keycodes {
    GUI_LM3 = SAFE_RANGE,
};

static uint16_t gui_lm3_timer;
static bool gui_lm3_held = false;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    switch (keycode) {
        case GUI_LM3:
            if (record->event.pressed) {
                gui_lm3_timer = timer_read();
                gui_lm3_held = true;
                layer_on(3);
                register_code(KC_LGUI);   // real mod, active immediately for hold-chords
            } else {
                layer_off(3);
                unregister_code(KC_LGUI);
                if (timer_elapsed(gui_lm3_timer) < TAPPING_TERM) {
                    // it was a tap, not a hold: arm one-shot GUI for next keypress
                    set_oneshot_mods(MOD_BIT(KC_LGUI));
                }
                gui_lm3_held = false;
            }
            return false;
    }
    return true;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       KC_TAB,    KC_Q,    KC_W,    KC_F,    KC_P,    KC_B,                         KC_J,    KC_L,    KC_U,    KC_Y, KC_SCLN,  KC_ESC,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      GUI_LM3,    KC_A,    KC_R,    KC_S,    KC_T,    KC_G,                         KC_M,    KC_N,    KC_E,    KC_I,    KC_O, KC_QUOT,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      OS_LCTL,    KC_Z,    KC_X,    KC_C,    KC_D,    KC_V,                         KC_K,    KC_H, KC_COMM,  KC_DOT, KC_SLSH, OS_RALT,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                           OSL(1),  KC_SPC, OS_LSFT,   KC_ENT,  KC_BSPC,   OSL(2)
                                      //`--------------------------'  `--------------------------'
  ),

[1] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                         KC_6,    KC_7,    KC_8,    KC_9,    KC_0,   XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
       XXXXXXX, KC_LCBR, KC_LBRC, KC_LPRN, KC_EQL,  KC_MINS,                     KC_UNDS, KC_PLUS, KC_RPRN, KC_RBRC, KC_RCBR, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
       KC_TILD, KC_DLR,  KC_PERC, KC_ASTR, KC_AMPR, KC_PIPE,                     KC_LT,   KC_GT,   KC_HASH, KC_AT,   KC_CIRC, KC_BSLS,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,       _______, _______, _______
                                      //`--------------------------'  `--------------------------'
  ),

[2] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
       XXXXXXX, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_BRIU,                     KC_VOLU, KC_MPRV, KC_MSTP, KC_MPLY, KC_MNXT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
       XXXXXXX, KC_F5,   KC_F6,   KC_F7,   KC_F8,   RM_TOGG,                     KC_MUTE, KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
       XXXXXXX, KC_F9,   KC_F10,  KC_F11,  KC_F12,  KC_BRID,                     KC_VOLD, KC_HOME, KC_PGDN, KC_PGUP, KC_END,  XXXXXXX,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, KC_PSCR, _______,       _______, KC_DEL, _______
                                      //`--------------------------'  `--------------------------'
  ),

    [3] = LAYOUT_split_3x6_3(
  //,-----------------------------------------------------.                    ,-----------------------------------------------------.
      XXXXXXX,    KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                         KC_6,    KC_7,    KC_8,    KC_9,    KC_0, XXXXXXX,
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,                      XXXXXXX, KC_LEFT, KC_DOWN,   KC_UP, KC_RGHT, XXXXXXX, 
  //|--------+--------+--------+--------+--------+--------|                    |--------+--------+--------+--------+--------+--------|
      _______, XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,                      XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, _______,
  //|--------+--------+--------+--------+--------+--------+--------|  |--------+--------+--------+--------+--------+--------+--------|
                                          _______, _______, _______,     _______, _______, _______
                                      //`--------------------------'  `--------------------------'
  )
};


typedef struct {
    uint8_t h;
    uint8_t s;
    uint8_t v;
} layer_rgb_t;

static const layer_rgb_t layer_colors[] = {
    [0] = { 61, 190, 100},  // springGreen  — muted forest green (alpha)
    [1] = {156, 190, 100},  // crystalBlue  — deep steel blue
    [2] = {241, 195, 100},  // sakuraPink   — dusty rose
    [3] = { 16, 200, 110},  // surimiOrange — warm deep orange
};

static void set_layer_rgb(layer_state_t state) {
#ifdef RGB_MATRIX_ENABLE
    if (!rgb_matrix_is_enabled()) {
        return;
    }
    const uint8_t layer = get_highest_layer(state);
    const layer_rgb_t color = layer_colors[layer < ARRAY_SIZE(layer_colors) ? layer : 0];
    rgb_matrix_mode_noeeprom(RGB_MATRIX_SOLID_COLOR);
    rgb_matrix_sethsv_noeeprom(color.h, color.s, color.v);
#endif
}

layer_state_t layer_state_set_user(layer_state_t state) {
    set_layer_rgb(state);
    return state;
}

void keyboard_post_init_user(void) {
    set_layer_rgb(layer_state);
}

