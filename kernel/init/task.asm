;=================================================================================
; Copyright (C) Andrzej Adamczyk (at https://blackdev.org/). All rights reserved.
;=================================================================================

;-------------------------------------------------------------------------------
; void
kernel_init_task:
	; preserve original registers
	push	rax
	push	rbx
	push	rcx
	push	rdi
	push	rsi

	;-----------------------------------------------------------------------
	; assign space for task queue and store it
	mov	ecx,	((KERNEL_TASK_limit * KERNEL_TASK_STRUCTURE.SIZE) + ~STD_PAGE_mask) >> STD_SHIFT_PAGE
	call	kernel_memory_alloc

	; save pointer to task queue
	mov	qword [r8 + KERNEL.task_queue_address],	rdi

	; properties of first job on queue which is the kernel of the system

	; entry seized and processed (by BSP processor)
	mov	word [rdi + KERNEL_TASK_STRUCTURE.flags], KERNEL_TASK_FLAG_secured

	; entry paging array
	mov	rax,	qword [r8 + KERNEL.page_base_address]
	mov	qword [rdi + KERNEL_TASK_STRUCTURE.cr3],	rax

	; kernel memory map
	mov	rax,	qword [r8 + KERNEL.memory_base_address]
	mov	qword [rdi + KERNEL_TASK_STRUCTURE.memory_map],	rax

	; prepare streams for kernel process
	call	kernel_stream

	; as a kernel, both streams are of type null
	or	byte [rsi + KERNEL_STRUCTURE_STREAM.flags],	LIB_SYS_STREAM_FLAG_null

	; assing streams to kernel task entry
	mov	qword [rdi + KERNEL_TASK_STRUCTURE.stream_in],	rsi
	mov	qword [rdi + KERNEL_TASK_STRUCTURE.stream_out],	rsi

	; remember pointer to first task in queue
	push	rdi

	;-----------------------------------------------------------------------
	; assume that only one CPU is available
	mov	ecx,	1

	; SMP specification available?
	cmp	qword [kernel_limine_smp_request + LIMINE_SMP_REQUEST.response],	EMPTY
	je	.one_to_rule_all	; no

	; retrieve available CPUs on host
	mov	rcx,	qword [kernel_limine_smp_request + LIMINE_SMP_REQUEST.response]
	mov	rcx,	qword [rcx + LIMINE_SMP_RESPONSE.cpu_count]

.one_to_rule_all:
	; calculate CPU list size in Pages
	shl	rcx,	STD_SHIFT_8
	add	rcx,	~STD_PAGE_mask
	and	rcx,	STD_PAGE_mask
	shr	rcx,	STD_SHIFT_PAGE

	; assign space for task list and store it
	call	kernel_memory_alloc
	mov	qword [r8 + KERNEL.task_ap_address],	rdi

	; mark in processor task list, BSP processor with its kernel task
	call	kernel_lapic_id
	pop	qword [rdi + rax * STD_SIZE_PTR_byte]

	;-----------------------------------------------------------------------
	; attach task switch interrupt routine handler
	mov	rax,	kernel_task
	mov	bx,	KERNEL_IDT_TYPE_irq
	mov	ecx,	KERNEL_TASK_irq
	call	kernel_idt_mount

	; done, task registered
	inc	qword [r8 + KERNEL.task_count]

	; restore original registers
	pop	rdi
	pop	rsi
	pop	rcx
	pop	rbx
	pop	rax

	; return from routine
	ret