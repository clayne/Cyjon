;===============================================================================
;Copyright (C) Andrzej Adamczyk (at https://blackdev.org/). All rights reserved.
;===============================================================================

kernel_environment_base_address	dq	EMPTY

; align table
align	0x08,	db	0x00
kernel_gdt_header		dw	STATIC_PAGE_SIZE_byte
				dq	EMPTY

; align table
align	0x08,	db	0x00
kernel_idt_header		dw	STATIC_PAGE_SIZE_byte
				dq	EMPTY