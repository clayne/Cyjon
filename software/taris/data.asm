;===============================================================================
; Copyright (C) Andrzej Adamczyk (at https://blackdev.org/). All rights reserved.
; GPL-3.0 License
;
; Main developer:
;	Andrzej Adamczyk
;===============================================================================

align	STATIC_QWORD_SIZE_byte,			db	STATIC_NOTHING
taris_ipc_data:
	times KERNEL_IPC_STRUCTURE.SIZE		db	STATIC_EMPTY

taris_limit					dq	(taris_bricks_end - taris_bricks) / STATIC_QWORD_SIZE_byte
taris_seed					dd	0x681560BA

align	STATIC_QWORD_SIZE_byte,			db	STATIC_NOTHING
;===============================================================================
taris_window					dw	STATIC_EMPTY	; pozycja na osi X
						dw	STATIC_EMPTY	; pozycja na osi Y
						dw	TARIS_WINDOW_WIDTH_pixel	; szerokość okna
						dw	TARIS_WINDOW_HEIGHT_pixel	; wysokość okna
						dq	STATIC_EMPTY	; wskaźnik do przestrzeni danych okna (uzupełnia Bosu)
.extra:						dd	STATIC_EMPTY	; rozmiar przestrzeni danych okna w Bajtach (uzupełnia Bosu)
						dw	LIBRARY_BOSU_WINDOW_FLAG_visible | LIBRARY_BOSU_WINDOW_FLAG_header | LIBRARY_BOSU_WINDOW_FLAG_border | LIBRARY_BOSU_WINDOW_FLAG_BUTTON_close
						dq	STATIC_EMPTY	; identyfikator okna (uzupełnia Bosu)
						db	5
						db	"Taris                          "	; wypełnij do 31 Bajtów znakami STATIC_SCANCODE_SPACE
						dq	STATIC_EMPTY	; szerokość okna w Bajtach (uzupełnia Bosu)
.elements:					;-------------------------------
.element_button_close:				; element "window close"
						;-------------------------------
						db	LIBRARY_BOSU_ELEMENT_TYPE_button_close
						dw	.element_button_close_end - .element_button_close
						dq	taris.close
.element_button_close_end:			;-------------------------------
						; element "playground"
						;-------------------------------
.element_playground:				db	LIBRARY_BOSU_ELEMENT_TYPE_draw
						dw	.element_playground_end - .element_playground
						dw	0	; pozycja na osi X względem przestrzeni danych okna
						dw	LIBRARY_BOSU_HEADER_HEIGHT_pixel
						dw	TARIS_PLAYGROUND_WIDTH_pixel
						dw	TARIS_WINDOW_HEIGHT_pixel
						dq	STATIC_EMPTY	; wskaźnik przestrzeni danych (uzupełnia Bosu)
.element_playground_end:				;-------------------------------
						; koniec elementów okna
						;-------------------------------
						db	STATIC_EMPTY
taris_window_end:

align	STATIC_QWORD_SIZE_byte,			db	STATIC_NOTHING
taris_bricks					dq	0x44440F00222200F0
						dq	0x0660066006600660
						dq	0xC4401700022300E8
						dq	0x64400710022608E0
						dq	0x4E002320007204C4
						dq	0x2640318000990066
						dq	0x8C4036000231006C
taris_bricks_end:
