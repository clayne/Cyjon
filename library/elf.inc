;=================================================================================
; Copyright (C) Andrzej Adamczyk (at https://blackdev.org/). All rights reserved.
;=================================================================================

%ifndef	LIB_ELF
	%define	LIB_ELF

	%define	LIB_ELF_HEADER_magic_number		0x464C457F	; 0x7F, 'E, 'L', 'F'

	%define	LIB_ELF_FLAG_execute			00000001b	; segment is executable
	%define	LIB_ELF_FLAG_write			00000010b	; segment is writable

	%define	LIB_ELF_TYPE_unknown			0x00
	%define	LIB_ELF_TYPE_relocatable		0x01
	%define	LIB_ELF_TYPE_executable			0x02
	%define	LIB_ELF_TYPE_shared_object		0x03

	%define	LIB_ELF_HEADER_TYPE_load		1

	%define	LIB_ELF_SECTION_TYPE_null		0x00
	%define	LIB_ELF_SECTION_TYPE_progbits		0x01
	%define	LIB_ELF_SECTION_TYPE_symtab		0x02
	%define	LIB_ELF_SECTION_TYPE_strtab		0x03
	%define	LIB_ELF_SECTION_TYPE_rela		0x04
	%define	LIB_ELF_SECTION_TYPE_hash		0x05
	%define	LIB_ELF_SECTION_TYPE_dynamic		0x06
	%define	LIB_ELF_SECTION_TYPE_note		0x07
	%define	LIB_ELF_SECTION_TYPE_nobits		0x08
	%define	LIB_ELF_SECTION_TYPE_rel		0x09
	%define	LIB_ELF_SECTION_TYPE_shlib		0x0A
	%define	LIB_ELF_SECTION_TYPE_dynsym		0x0B

	%define	LIB_ELF_SECTION_DYNAMIC_TYPE_needed	1

	struc	LIB_ELF_STRUCTURE
		.magic_number		resd	1
		.class			resb	1
		.memory_layout		resb	1
		.header_version		resb	1
		.abi			resb	1
		.abi_version		resb	1
		.padding		resb	7
		.type			resw	1
		.instruction_set	resw	1
		.elf_version		resd	1
		;--------------------------------
		.entry_ptr		resq	1
		.headers_offset		resq	1
		.sections_offset	resq	1
		;--------------------------------
		.flags			resd	1
		.header_size		resw	1
		.header_table_size	resw	1
		.h_entry_count		resw	1
		.section_table_size	resw	1
		.s_entry_count		resw	1
		.correlation		resw	1
	endstruc

	struc	LIB_ELF_STRUCTURE_HEADER
		.type			resd	1
		.flags			resd	1
		.segment_offset		resq	1
		.virtual_address	resq	1
		.physical_address	resq	1
		.segment_size		resq	1
		.memory_size		resq	1
		.alignment		resq	1
		.SIZE:
	endstruc

	struc	LIB_ELF_STRUCTURE_SECTION
		.name			resd	1
		.type			resd	1
		.flags			resq	1
		.virtual_address	resq	1
		.file_offset		resq	1
		.size_byte		resq	1
		.link			resd	1
		.info			resd	1
		.alignment		resq	1
		.entry_count		resq	1
		.SIZE:
	endstruc

	struc	LIB_ELF_STRUCTURE_DYNAMIC_ENTRY
		.type			resq	1
		.name_offset		resq	1
		.SIZE:
	endstruc

	struc	LIB_ELF_STRUCTURE_DYNAMIC_SYMBOL
		.name_offset		resd	1
		.flags			resd	1
		.address		resq	1
		.size_byte		resq	1
		.SIZE:
	endstruc

	struc	LIB_ELF_STRUCTURE_DYNAMIC_RELOCATION
		.offset			resq	1
		.flags			resd	1
		.index			resd	1
		.symbol_value		resq	1
		.SIZE:
	endstruc
%endif