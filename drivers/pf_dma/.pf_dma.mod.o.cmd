savedcmd_pf_dma.mod.o := riscv64-linux-gnu-gcc -Wp,-MMD,./.pf_dma.mod.o.d -nostdinc -I/home/lorenzo/Code/linux4polarfire/arch/riscv/include -I/home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated -I/home/lorenzo/Code/linux4polarfire/include -I/home/lorenzo/Code/linux4polarfire/include -I/home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi -I/home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi -I/home/lorenzo/Code/linux4polarfire/include/uapi -I/home/lorenzo/Code/linux4polarfire/include/generated/uapi -include /home/lorenzo/Code/linux4polarfire/include/linux/compiler-version.h -include /home/lorenzo/Code/linux4polarfire/include/linux/kconfig.h -include /home/lorenzo/Code/linux4polarfire/include/linux/compiler_types.h -D__KERNEL__ -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -mabi=lp64 -march=rv64imac_zicsr_zifencei_zacas_zabha -mno-save-restore -mcmodel=medany -fno-asynchronous-unwind-tables -fno-unwind-tables -mno-riscv-attribute -Wa,-mno-arch-attr -mstrict-align -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-races -fstack-protector-strong -fno-omit-frame-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=zero -fzero-init-padding-bits=all -fno-stack-clash-protection -fmin-function-alignment=4 -fstrict-flex-arrays=3 -fno-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=2048 -Wno-main -Wno-dangling-pointer -Wvla-larger-than=1 -Wno-pointer-sign -Wcast-function-type -Wno-unterminated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wenum-conversion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -DGCC_PLUGINS -mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=1464  -DMODULE -mno-relax  -DKBUILD_BASENAME='"pf_dma.mod"' -DKBUILD_MODNAME='"pf_dma"' -D__KBUILD_MODNAME=kmod_pf_dma -c -o pf_dma.mod.o pf_dma.mod.c  

source_pf_dma.mod.o := pf_dma.mod.c

deps_pf_dma.mod.o := \
    $(wildcard include/config/MODULE_UNLOAD) \
  /home/lorenzo/Code/linux4polarfire/include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  /home/lorenzo/Code/linux4polarfire/include/generated/gcc-plugins.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  /home/lorenzo/Code/linux4polarfire/include/linux/compiler_types.h \
    $(wildcard include/config/DEBUG_INFO_BTF) \
    $(wildcard include/config/PAHOLE_HAS_BTF_TAG) \
    $(wildcard include/config/FUNCTION_ALIGNMENT) \
    $(wildcard include/config/CC_HAS_SANE_FUNCTION_ALIGNMENT) \
    $(wildcard include/config/X86_64) \
    $(wildcard include/config/ARM64) \
    $(wildcard include/config/LD_DEAD_CODE_DATA_ELIMINATION) \
    $(wildcard include/config/LTO_CLANG) \
    $(wildcard include/config/HAVE_ARCH_COMPILER_H) \
    $(wildcard include/config/KCSAN) \
    $(wildcard include/config/CC_HAS_ASSUME) \
    $(wildcard include/config/CC_HAS_COUNTED_BY) \
    $(wildcard include/config/CC_HAS_MULTIDIMENSIONAL_NONSTRING) \
    $(wildcard include/config/UBSAN_INTEGER_WRAP) \
    $(wildcard include/config/CFI) \
    $(wildcard include/config/ARCH_USES_CFI_GENERIC_LLVM_PASS) \
    $(wildcard include/config/CC_HAS_ASM_INLINE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/compiler_attributes.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/compiler-gcc.h \
    $(wildcard include/config/ARCH_USE_BUILTIN_BSWAP) \
    $(wildcard include/config/SHADOW_CALL_STACK) \
    $(wildcard include/config/KCOV) \
    $(wildcard include/config/CC_HAS_TYPEOF_UNQUAL) \
  /home/lorenzo/Code/linux4polarfire/include/linux/module.h \
    $(wildcard include/config/MODULES) \
    $(wildcard include/config/SYSFS) \
    $(wildcard include/config/MODULES_TREE_LOOKUP) \
    $(wildcard include/config/LIVEPATCH) \
    $(wildcard include/config/STACKTRACE_BUILD_ID) \
    $(wildcard include/config/ARCH_USES_CFI_TRAPS) \
    $(wildcard include/config/MODULE_SIG) \
    $(wildcard include/config/GENERIC_BUG) \
    $(wildcard include/config/KALLSYMS) \
    $(wildcard include/config/SMP) \
    $(wildcard include/config/TRACEPOINTS) \
    $(wildcard include/config/TREE_SRCU) \
    $(wildcard include/config/BPF_EVENTS) \
    $(wildcard include/config/DEBUG_INFO_BTF_MODULES) \
    $(wildcard include/config/JUMP_LABEL) \
    $(wildcard include/config/TRACING) \
    $(wildcard include/config/EVENT_TRACING) \
    $(wildcard include/config/DYNAMIC_FTRACE) \
    $(wildcard include/config/KPROBES) \
    $(wildcard include/config/HAVE_STATIC_CALL_INLINE) \
    $(wildcard include/config/KUNIT) \
    $(wildcard include/config/PRINTK_INDEX) \
    $(wildcard include/config/CONSTRUCTORS) \
    $(wildcard include/config/FUNCTION_ERROR_INJECTION) \
    $(wildcard include/config/DYNAMIC_DEBUG_CORE) \
    $(wildcard include/config/MITIGATION_RETPOLINE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/list.h \
    $(wildcard include/config/LIST_HARDENED) \
    $(wildcard include/config/DEBUG_LIST) \
  /home/lorenzo/Code/linux4polarfire/include/linux/container_of.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/build_bug.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/compiler.h \
    $(wildcard include/config/TRACE_BRANCH_PROFILING) \
    $(wildcard include/config/PROFILE_ALL_BRANCHES) \
    $(wildcard include/config/OBJTOOL) \
    $(wildcard include/config/64BIT) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/rwonce.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/rwonce.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kasan-checks.h \
    $(wildcard include/config/KASAN_GENERIC) \
    $(wildcard include/config/KASAN_SW_TAGS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/types.h \
    $(wildcard include/config/HAVE_UID16) \
    $(wildcard include/config/UID16) \
    $(wildcard include/config/ARCH_DMA_ADDR_T_64BIT) \
    $(wildcard include/config/PHYS_ADDR_T_64BIT) \
    $(wildcard include/config/ARCH_32BIT_USTAT_F_TINODE) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/types.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/types.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/types.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/int-ll64.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/int-ll64.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/bitsperlong.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitsperlong.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/bitsperlong.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/posix_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/stddef.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/stddef.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/posix_types.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/posix_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kcsan-checks.h \
    $(wildcard include/config/KCSAN_WEAK_MEMORY) \
    $(wildcard include/config/KCSAN_IGNORE_ATOMICS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/poison.h \
    $(wildcard include/config/ILLEGAL_POINTER_VALUE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/const.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/const.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/const.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/barrier.h \
    $(wildcard include/config/RISCV_ISA_ZAWRS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/cmpxchg.h \
    $(wildcard include/config/RISCV_ISA_ZABHA) \
    $(wildcard include/config/RISCV_ISA_ZACAS) \
    $(wildcard include/config/TOOLCHAIN_HAS_ZACAS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/bug.h \
    $(wildcard include/config/PRINTK) \
    $(wildcard include/config/BUG_ON_DATA_CORRUPTION) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/bug.h \
    $(wildcard include/config/GENERIC_BUG_RELATIVE_POINTERS) \
    $(wildcard include/config/DEBUG_BUGVERBOSE) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/asm.h \
    $(wildcard include/config/AS_HAS_INSN) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bug.h \
    $(wildcard include/config/BUG) \
  /home/lorenzo/Code/linux4polarfire/include/linux/instrumentation.h \
    $(wildcard include/config/NOINSTR_VALIDATION) \
  /home/lorenzo/Code/linux4polarfire/include/linux/once_lite.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/panic.h \
    $(wildcard include/config/PANIC_TIMEOUT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/stdarg.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/printk.h \
    $(wildcard include/config/MESSAGE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_QUIET) \
    $(wildcard include/config/EARLY_PRINTK) \
    $(wildcard include/config/DYNAMIC_DEBUG) \
  /home/lorenzo/Code/linux4polarfire/include/linux/init.h \
    $(wildcard include/config/MEMORY_HOTPLUG) \
    $(wildcard include/config/HAVE_ARCH_PREL32_RELOCATIONS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/stringify.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kern_levels.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/linkage.h \
    $(wildcard include/config/ARCH_USE_SYM_ANNOTATIONS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/export.h \
    $(wildcard include/config/MODVERSIONS) \
    $(wildcard include/config/GENDWARFKSYMS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/linkage.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/ratelimit_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bits.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/bits.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/bits.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/overflow.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/limits.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/limits.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/limits.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/param.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/param.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/param.h \
    $(wildcard include/config/HZ) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/param.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/spinlock_types_raw.h \
    $(wildcard include/config/DEBUG_SPINLOCK) \
    $(wildcard include/config/DEBUG_LOCK_ALLOC) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/spinlock_types.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/spinlock_types.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/qspinlock_types.h \
    $(wildcard include/config/NR_CPUS) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/qrwlock_types.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/byteorder.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/byteorder/little_endian.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/byteorder/little_endian.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/swab.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/swab.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/swab.h \
    $(wildcard include/config/TOOLCHAIN_HAS_ZBB) \
    $(wildcard include/config/RISCV_ISA_ZBB) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/cpufeature-macros.h \
    $(wildcard include/config/RISCV_ALTERNATIVE) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/hwcap.h \
    $(wildcard include/config/RISCV_M_MODE) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/hwcap.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/alternative-macros.h \
    $(wildcard include/config/k) \
    $(wildcard include/config/k_1) \
    $(wildcard include/config/k_2) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/swab.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/byteorder/generic.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/lockdep_types.h \
    $(wildcard include/config/PROVE_RAW_LOCK_NESTING) \
    $(wildcard include/config/LOCKDEP) \
    $(wildcard include/config/LOCK_STAT) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/fence.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/insn-def.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/processor.h \
    $(wildcard include/config/MMU) \
    $(wildcard include/config/RISCV_ISA_ZICBOP) \
    $(wildcard include/config/RISCV_ISA_V) \
    $(wildcard include/config/RISCV_ISA_SUPM) \
  /home/lorenzo/Code/linux4polarfire/include/linux/cache.h \
    $(wildcard include/config/ARCH_HAS_CACHE_LINE_SIZE) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/kernel.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/sysinfo.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/cache.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/cache.h \
    $(wildcard include/config/RISCV_DMA_NONCOHERENT) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/prctl.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/processor.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/vdso/processor.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/errata_list.h \
    $(wildcard include/config/ERRATA_SIFIVE_CIP_453) \
    $(wildcard include/config/ERRATA_SIFIVE_CIP_1200) \
    $(wildcard include/config/ERRATA_MIPS_P8700_PAUSE_OPCODE) \
    $(wildcard include/config/RISCV_ISA_SVPBMT) \
    $(wildcard include/config/ERRATA_THEAD_MAE) \
    $(wildcard include/config/RISCV_ISA_ZICBOM) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/csr.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/vendorid_list.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/errata_list_vendors.h \
    $(wildcard include/config/ERRATA_ANDES) \
    $(wildcard include/config/ERRATA_SIFIVE) \
    $(wildcard include/config/ERRATA_THEAD) \
    $(wildcard include/config/ERRATA_MIPS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/vendor_extensions/mips.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/ptrace.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/ptrace.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/barrier.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/stat.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/stat.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/stat.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/stat.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/time.h \
    $(wildcard include/config/POSIX_TIMERS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/math64.h \
    $(wildcard include/config/ARCH_SUPPORTS_INT128) \
  /home/lorenzo/Code/linux4polarfire/include/linux/math.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/div64.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/div64.h \
    $(wildcard include/config/CC_OPTIMIZE_FOR_PERFORMANCE) \
  /home/lorenzo/Code/linux4polarfire/include/vdso/math64.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/time64.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/time64.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/time.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/time_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/time32.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timex.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/timex.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/timex.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/time32.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/time.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/uidgid.h \
    $(wildcard include/config/MULTIUSER) \
    $(wildcard include/config/USER_NS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/uidgid_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/highuid.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/buildid.h \
    $(wildcard include/config/VMCORE_INFO) \
  /home/lorenzo/Code/linux4polarfire/include/linux/cleanup.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/err.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/errno.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/errno.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/errno-base.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/args.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kmod.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/umh.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/gfp.h \
    $(wildcard include/config/HIGHMEM) \
    $(wildcard include/config/ZONE_DMA) \
    $(wildcard include/config/ZONE_DMA32) \
    $(wildcard include/config/ZONE_DEVICE) \
    $(wildcard include/config/NUMA) \
    $(wildcard include/config/COMPACTION) \
    $(wildcard include/config/CONTIG_ALLOC) \
  /home/lorenzo/Code/linux4polarfire/include/linux/gfp_types.h \
    $(wildcard include/config/KASAN_HW_TAGS) \
    $(wildcard include/config/SLAB_OBJ_EXT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/mmzone.h \
    $(wildcard include/config/ARCH_FORCE_MAX_ORDER) \
    $(wildcard include/config/PAGE_BLOCK_MAX_ORDER) \
    $(wildcard include/config/CMA) \
    $(wildcard include/config/MEMORY_ISOLATION) \
    $(wildcard include/config/ZSMALLOC) \
    $(wildcard include/config/UNACCEPTED_MEMORY) \
    $(wildcard include/config/IOMMU_SUPPORT) \
    $(wildcard include/config/SWAP) \
    $(wildcard include/config/NUMA_BALANCING) \
    $(wildcard include/config/HUGETLB_PAGE) \
    $(wildcard include/config/TRANSPARENT_HUGEPAGE) \
    $(wildcard include/config/LRU_GEN) \
    $(wildcard include/config/LRU_GEN_STATS) \
    $(wildcard include/config/LRU_GEN_WALKS_MMU) \
    $(wildcard include/config/MEMCG) \
    $(wildcard include/config/SPARSEMEM) \
    $(wildcard include/config/MEMORY_FAILURE) \
    $(wildcard include/config/FLATMEM) \
    $(wildcard include/config/PAGE_EXTENSION) \
    $(wildcard include/config/DEFERRED_STRUCT_PAGE_INIT) \
    $(wildcard include/config/HAVE_MEMORYLESS_NODES) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP) \
    $(wildcard include/config/SPARSEMEM_EXTREME) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP_PREINIT) \
    $(wildcard include/config/HAVE_ARCH_PFN_VALID) \
  /home/lorenzo/Code/linux4polarfire/include/linux/spinlock.h \
    $(wildcard include/config/PREEMPTION) \
    $(wildcard include/config/PREEMPT_RT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/typecheck.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/preempt.h \
    $(wildcard include/config/PREEMPT_COUNT) \
    $(wildcard include/config/DEBUG_PREEMPT) \
    $(wildcard include/config/TRACE_PREEMPT_TOGGLE) \
    $(wildcard include/config/PREEMPT_NOTIFIERS) \
    $(wildcard include/config/PREEMPT_DYNAMIC) \
    $(wildcard include/config/PREEMPT_NONE) \
    $(wildcard include/config/PREEMPT_VOLUNTARY) \
    $(wildcard include/config/PREEMPT) \
    $(wildcard include/config/PREEMPT_LAZY) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/preempt.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/preempt.h \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_KEY) \
  /home/lorenzo/Code/linux4polarfire/include/linux/thread_info.h \
    $(wildcard include/config/THREAD_INFO_IN_TASK) \
    $(wildcard include/config/GENERIC_ENTRY) \
    $(wildcard include/config/ARCH_HAS_PREEMPT_LAZY) \
    $(wildcard include/config/HAVE_ARCH_WITHIN_STACK_FRAMES) \
    $(wildcard include/config/SH) \
  /home/lorenzo/Code/linux4polarfire/include/linux/restart_block.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/errno.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/errno.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/current.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bitops.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/generic-non-atomic.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/bitops.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/irqflags.h \
    $(wildcard include/config/PROVE_LOCKING) \
    $(wildcard include/config/TRACE_IRQFLAGS) \
    $(wildcard include/config/IRQSOFF_TRACER) \
    $(wildcard include/config/PREEMPT_TRACER) \
    $(wildcard include/config/DEBUG_IRQFLAGS) \
    $(wildcard include/config/TRACE_IRQFLAGS_SUPPORT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/irqflags_types.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/irqflags.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/percpu.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/percpu.h \
    $(wildcard include/config/HAVE_SETUP_PER_CPU_AREA) \
  /home/lorenzo/Code/linux4polarfire/include/linux/threads.h \
    $(wildcard include/config/BASE_SMALL) \
  /home/lorenzo/Code/linux4polarfire/include/linux/percpu-defs.h \
    $(wildcard include/config/ARCH_MODULE_NEEDS_WEAK_PER_CPU) \
    $(wildcard include/config/DEBUG_FORCE_WEAK_PER_CPU) \
    $(wildcard include/config/AMD_MEM_ENCRYPT) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/__ffs.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/__fls.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/ffs.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/fls.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/ffz.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/fls64.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/sched.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/arch_hweight.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/const_hweight.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/instrumented-atomic.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/instrumented.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kmsan-checks.h \
    $(wildcard include/config/KMSAN) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/instrumented-lock.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/non-atomic.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/non-instrumented-non-atomic.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/le.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/bitops/ext2-atomic.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/thread_info.h \
    $(wildcard include/config/KASAN) \
    $(wildcard include/config/THREAD_SIZE_ORDER) \
    $(wildcard include/config/VMAP_STACK) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/page.h \
    $(wildcard include/config/XIP_KERNEL) \
    $(wildcard include/config/RISCV_ISA_ZICBOZ) \
    $(wildcard include/config/DEBUG_VIRTUAL) \
  /home/lorenzo/Code/linux4polarfire/include/linux/pfn.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/page.h \
    $(wildcard include/config/PAGE_SHIFT) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/memory_model.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/getorder.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/log2.h \
    $(wildcard include/config/ARCH_HAS_ILOG2_U32) \
    $(wildcard include/config/ARCH_HAS_ILOG2_U64) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sizes.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/thread_info_tif.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bottom_half.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/instruction_pointer.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/lockdep.h \
    $(wildcard include/config/DEBUG_LOCKING_API_SELFTESTS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/smp.h \
    $(wildcard include/config/UP_LATE_INIT) \
    $(wildcard include/config/CSD_LOCK_WAIT_DEBUG) \
  /home/lorenzo/Code/linux4polarfire/include/linux/cpumask.h \
    $(wildcard include/config/FORCE_NR_CPUS) \
    $(wildcard include/config/HOTPLUG_CPU) \
    $(wildcard include/config/DEBUG_PER_CPU_MAPS) \
    $(wildcard include/config/CPUMASK_OFFSTACK) \
  /home/lorenzo/Code/linux4polarfire/include/linux/kernel.h \
    $(wildcard include/config/PREEMPT_VOLUNTARY_BUILD) \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_CALL) \
    $(wildcard include/config/PREEMPT_) \
    $(wildcard include/config/DEBUG_ATOMIC_SLEEP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/align.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/align.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/array_size.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/hex.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kstrtox.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/minmax.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sprintf.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/static_call_types.h \
    $(wildcard include/config/HAVE_STATIC_CALL) \
  /home/lorenzo/Code/linux4polarfire/include/linux/util_macros.h \
    $(wildcard include/config/FOO_SUSPEND) \
  /home/lorenzo/Code/linux4polarfire/include/linux/wordpart.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bitmap.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/find.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/string.h \
    $(wildcard include/config/BINARY_PRINTF) \
    $(wildcard include/config/FORTIFY_SOURCE) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/string.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/string.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bitmap-str.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/cpumask_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/atomic.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/atomic.h \
    $(wildcard include/config/GENERIC_ATOMIC64) \
  /home/lorenzo/Code/linux4polarfire/include/linux/atomic/atomic-arch-fallback.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/atomic/atomic-long.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/atomic/atomic-instrumented.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/numa.h \
    $(wildcard include/config/NUMA_KEEP_MEMINFO) \
    $(wildcard include/config/HAVE_ARCH_NODE_DEV_GROUP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/nodemask.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/nodemask_types.h \
    $(wildcard include/config/NODES_SHIFT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/random.h \
    $(wildcard include/config/VMGENID) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/random.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/ioctl.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/ioctl.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/ioctl.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/ioctl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/irqnr.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/irqnr.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/smp_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/llist.h \
    $(wildcard include/config/ARCH_HAVE_NMI_SAFE_CMPXCHG) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/smp.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/irqreturn.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/jump_label.h \
    $(wildcard include/config/HAVE_ARCH_JUMP_LABEL_RELATIVE) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/jump_label.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/mmiowb.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/mmiowb.h \
    $(wildcard include/config/MMIOWB) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/mmiowb_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/spinlock_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rwlock_types.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/spinlock.h \
    $(wildcard include/config/QUEUED_SPINLOCKS) \
    $(wildcard include/config/RISCV_COMBO_SPINLOCKS) \
    $(wildcard include/config/RISCV_QUEUED_SPINLOCKS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/ticket_spinlock.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/ticket_spinlock.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/qspinlock.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/qspinlock.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/qrwlock.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/qrwlock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rwlock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/INLINE_SPIN_LOCK) \
    $(wildcard include/config/INLINE_SPIN_LOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK_BH) \
    $(wildcard include/config/UNINLINE_SPIN_UNLOCK) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/GENERIC_LOCKBREAK) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/INLINE_READ_LOCK) \
    $(wildcard include/config/INLINE_WRITE_LOCK) \
    $(wildcard include/config/INLINE_READ_LOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_LOCK_BH) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_READ_TRYLOCK) \
    $(wildcard include/config/INLINE_WRITE_TRYLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_BH) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQRESTORE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/list_nulls.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/wait.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/seqlock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/mutex.h \
    $(wildcard include/config/DEBUG_MUTEXES) \
  /home/lorenzo/Code/linux4polarfire/include/linux/osq_lock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/debug_locks.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/mutex_types.h \
    $(wildcard include/config/MUTEX_SPIN_ON_OWNER) \
  /home/lorenzo/Code/linux4polarfire/include/linux/seqlock_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/pageblock-flags.h \
    $(wildcard include/config/HUGETLB_PAGE_SIZE_VARIABLE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/page-flags-layout.h \
  /home/lorenzo/Code/linux4polarfire/include/generated/bounds.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/sparsemem.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/mm_types.h \
    $(wildcard include/config/HAVE_ALIGNED_STRUCT_PAGE) \
    $(wildcard include/config/HUGETLB_PMD_PAGE_TABLE_SHARING) \
    $(wildcard include/config/SLAB_FREELIST_HARDENED) \
    $(wildcard include/config/USERFAULTFD) \
    $(wildcard include/config/ANON_VMA_NAME) \
    $(wildcard include/config/PER_VMA_LOCK) \
    $(wildcard include/config/SCHED_MM_CID) \
    $(wildcard include/config/HAVE_ARCH_COMPAT_MMAP_BASES) \
    $(wildcard include/config/MEMBARRIER) \
    $(wildcard include/config/FUTEX_PRIVATE_HASH) \
    $(wildcard include/config/ARCH_HAS_ELF_CORE_EFLAGS) \
    $(wildcard include/config/AIO) \
    $(wildcard include/config/MMU_NOTIFIER) \
    $(wildcard include/config/SPLIT_PMD_PTLOCKS) \
    $(wildcard include/config/ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) \
    $(wildcard include/config/IOMMU_MM_DATA) \
    $(wildcard include/config/KSM) \
    $(wildcard include/config/MM_ID) \
    $(wildcard include/config/CORE_DUMP_DEFAULT_ELF_HEADERS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/mm_types_task.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/tlbbatch.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/auxvec.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/auxvec.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/auxvec.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kref.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/refcount.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/refcount_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rbtree.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rbtree_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcupdate.h \
    $(wildcard include/config/PREEMPT_RCU) \
    $(wildcard include/config/TINY_RCU) \
    $(wildcard include/config/RCU_STRICT_GRACE_PERIOD) \
    $(wildcard include/config/RCU_LAZY) \
    $(wildcard include/config/RCU_STALL_COMMON) \
    $(wildcard include/config/NO_HZ_FULL) \
    $(wildcard include/config/VIRT_XFER_TO_GUEST_WORK) \
    $(wildcard include/config/RCU_NOCB_CPU) \
    $(wildcard include/config/TASKS_RCU_GENERIC) \
    $(wildcard include/config/TASKS_RCU) \
    $(wildcard include/config/TASKS_TRACE_RCU) \
    $(wildcard include/config/TASKS_RUDE_RCU) \
    $(wildcard include/config/TREE_RCU) \
    $(wildcard include/config/DEBUG_OBJECTS_RCU_HEAD) \
    $(wildcard include/config/PROVE_RCU) \
    $(wildcard include/config/ARCH_WEAK_RELEASE_ACQUIRE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched.h \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_NATIVE) \
    $(wildcard include/config/SCHED_INFO) \
    $(wildcard include/config/SCHEDSTATS) \
    $(wildcard include/config/SCHED_CORE) \
    $(wildcard include/config/FAIR_GROUP_SCHED) \
    $(wildcard include/config/RT_GROUP_SCHED) \
    $(wildcard include/config/RT_MUTEXES) \
    $(wildcard include/config/UCLAMP_TASK) \
    $(wildcard include/config/UCLAMP_BUCKETS_COUNT) \
    $(wildcard include/config/KMAP_LOCAL) \
    $(wildcard include/config/MEM_ALLOC_PROFILING) \
    $(wildcard include/config/SCHED_CLASS_EXT) \
    $(wildcard include/config/CGROUP_SCHED) \
    $(wildcard include/config/CFS_BANDWIDTH) \
    $(wildcard include/config/BLK_DEV_IO_TRACE) \
    $(wildcard include/config/MEMCG_V1) \
    $(wildcard include/config/COMPAT_BRK) \
    $(wildcard include/config/CGROUPS) \
    $(wildcard include/config/BLK_CGROUP) \
    $(wildcard include/config/PSI) \
    $(wildcard include/config/PAGE_OWNER) \
    $(wildcard include/config/EVENTFD) \
    $(wildcard include/config/ARCH_HAS_CPU_PASID) \
    $(wildcard include/config/X86_BUS_LOCK_DETECT) \
    $(wildcard include/config/TASK_DELAY_ACCT) \
    $(wildcard include/config/STACKPROTECTOR) \
    $(wildcard include/config/ARCH_HAS_SCALED_CPUTIME) \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_GEN) \
    $(wildcard include/config/POSIX_CPUTIMERS) \
    $(wildcard include/config/POSIX_CPU_TIMERS_TASK_WORK) \
    $(wildcard include/config/KEYS) \
    $(wildcard include/config/SYSVIPC) \
    $(wildcard include/config/DETECT_HUNG_TASK) \
    $(wildcard include/config/IO_URING) \
    $(wildcard include/config/AUDIT) \
    $(wildcard include/config/AUDITSYSCALL) \
    $(wildcard include/config/DETECT_HUNG_TASK_BLOCKER) \
    $(wildcard include/config/UBSAN) \
    $(wildcard include/config/UBSAN_TRAP) \
    $(wildcard include/config/TASK_XACCT) \
    $(wildcard include/config/CPUSETS) \
    $(wildcard include/config/X86_CPU_RESCTRL) \
    $(wildcard include/config/FUTEX) \
    $(wildcard include/config/COMPAT) \
    $(wildcard include/config/PERF_EVENTS) \
    $(wildcard include/config/RSEQ) \
    $(wildcard include/config/DEBUG_RSEQ) \
    $(wildcard include/config/FAULT_INJECTION) \
    $(wildcard include/config/LATENCYTOP) \
    $(wildcard include/config/FUNCTION_GRAPH_TRACER) \
    $(wildcard include/config/UPROBES) \
    $(wildcard include/config/BCACHE) \
    $(wildcard include/config/SECURITY) \
    $(wildcard include/config/BPF_SYSCALL) \
    $(wildcard include/config/KSTACK_ERASE) \
    $(wildcard include/config/KSTACK_ERASE_METRICS) \
    $(wildcard include/config/X86_MCE) \
    $(wildcard include/config/KRETPROBES) \
    $(wildcard include/config/RETHOOK) \
    $(wildcard include/config/ARCH_HAS_PARANOID_L1D_FLUSH) \
    $(wildcard include/config/RV) \
    $(wildcard include/config/RV_PER_TASK_MONITORS) \
    $(wildcard include/config/USER_EVENTS) \
    $(wildcard include/config/UNWIND_USER) \
    $(wildcard include/config/SCHED_PROXY_EXEC) \
    $(wildcard include/config/MEM_ALLOC_PROFILING_DEBUG) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/sched.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/pid_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sem_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/shm.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/shmparam.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/shmparam.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kmsan_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/plist_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/hrtimer_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timerqueue_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timer_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/seccomp_types.h \
    $(wildcard include/config/SECCOMP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/resource.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/resource.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/resource.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/resource.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/resource.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/latencytop.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/prio.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/signal_types.h \
    $(wildcard include/config/OLD_SIGACTION) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/signal.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/signal.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/signal.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/signal.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/signal-defs.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/sigcontext.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/siginfo.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/siginfo.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/syscall_user_dispatch_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/netdevice_xmit.h \
    $(wildcard include/config/NET_EGRESS) \
    $(wildcard include/config/NET_ACT_MIRRED) \
    $(wildcard include/config/NF_DUP_NETDEV) \
  /home/lorenzo/Code/linux4polarfire/include/linux/task_io_accounting.h \
    $(wildcard include/config/TASK_IO_ACCOUNTING) \
  /home/lorenzo/Code/linux4polarfire/include/linux/posix-timers_types.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/rseq.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kcsan.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rv.h \
    $(wildcard include/config/RV_LTL_MONITOR) \
    $(wildcard include/config/RV_REACTORS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/tracepoint-defs.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/static_key.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/unwind_deferred_types.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/asm/kmap_size.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/kmap_size.h \
    $(wildcard include/config/DEBUG_KMAP_LOCAL) \
  /home/lorenzo/Code/linux4polarfire/include/generated/rq-offsets.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/ext.h \
    $(wildcard include/config/EXT_GROUP_SCHED) \
  /home/lorenzo/Code/linux4polarfire/include/linux/context_tracking_irq.h \
    $(wildcard include/config/CONTEXT_TRACKING_IDLE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcutree.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/maple_tree.h \
    $(wildcard include/config/MAPLE_RCU_DISABLED) \
    $(wildcard include/config/DEBUG_MAPLE_TREE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rwsem.h \
    $(wildcard include/config/RWSEM_SPIN_ON_OWNER) \
    $(wildcard include/config/DEBUG_RWSEMS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/completion.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/swait.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/uprobes.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timer.h \
    $(wildcard include/config/DEBUG_OBJECTS_TIMERS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/ktime.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/jiffies.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/jiffies.h \
  /home/lorenzo/Code/linux4polarfire/include/generated/timeconst.h \
  /home/lorenzo/Code/linux4polarfire/include/vdso/ktime.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timekeeping.h \
    $(wildcard include/config/POSIX_AUX_CLOCKS) \
    $(wildcard include/config/GENERIC_CMOS_UPDATE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/clocksource_ids.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/debugobjects.h \
    $(wildcard include/config/DEBUG_OBJECTS) \
    $(wildcard include/config/DEBUG_OBJECTS_FREE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/workqueue.h \
    $(wildcard include/config/DEBUG_OBJECTS_WORK) \
    $(wildcard include/config/FREEZER) \
    $(wildcard include/config/WQ_WATCHDOG) \
  /home/lorenzo/Code/linux4polarfire/include/linux/alloc_tag.h \
    $(wildcard include/config/MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT) \
  /home/lorenzo/Code/linux4polarfire/include/linux/codetag.h \
    $(wildcard include/config/CODE_TAGGING) \
  /home/lorenzo/Code/linux4polarfire/include/linux/workqueue_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/percpu_counter.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/percpu.h \
    $(wildcard include/config/RANDOM_KMALLOC_CACHES) \
    $(wildcard include/config/PAGE_SIZE_4KB) \
    $(wildcard include/config/NEED_PER_CPU_PAGE_FIRST_CHUNK) \
  /home/lorenzo/Code/linux4polarfire/include/linux/mmdebug.h \
    $(wildcard include/config/DEBUG_VM) \
    $(wildcard include/config/DEBUG_VM_IRQSOFF) \
    $(wildcard include/config/DEBUG_VM_PGFLAGS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/mmu.h \
    $(wildcard include/config/BINFMT_ELF_FDPIC) \
  /home/lorenzo/Code/linux4polarfire/include/linux/page-flags.h \
    $(wildcard include/config/PAGE_IDLE_FLAG) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_2) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_3) \
    $(wildcard include/config/MIGRATION) \
    $(wildcard include/config/HUGETLB_PAGE_OPTIMIZE_VMEMMAP) \
    $(wildcard include/config/DEBUG_KMAP_LOCAL_FORCE_MAP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/local_lock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/local_lock_internal.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/zswap.h \
    $(wildcard include/config/ZSWAP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/memory_hotplug.h \
    $(wildcard include/config/ARCH_HAS_ADD_PAGES) \
    $(wildcard include/config/MEMORY_HOTREMOVE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/notifier.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/srcu.h \
    $(wildcard include/config/TINY_SRCU) \
    $(wildcard include/config/NEED_SRCU_NMI_SAFE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcu_segcblist.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/srcutree.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcu_node_tree.h \
    $(wildcard include/config/RCU_FANOUT) \
    $(wildcard include/config/RCU_FANOUT_LEAF) \
  /home/lorenzo/Code/linux4polarfire/include/linux/topology.h \
    $(wildcard include/config/USE_PERCPU_NUMA_NODE_ID) \
    $(wildcard include/config/SCHED_SMT) \
    $(wildcard include/config/GENERIC_ARCH_TOPOLOGY) \
  /home/lorenzo/Code/linux4polarfire/include/linux/arch_topology.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/topology.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/topology.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sysctl.h \
    $(wildcard include/config/SYSCTL) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/sysctl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/elf.h \
    $(wildcard include/config/ARCH_HAVE_EXTRA_ELF_NOTES) \
    $(wildcard include/config/ARCH_USE_GNU_PROPERTY) \
    $(wildcard include/config/ARCH_HAVE_ELF_PROT) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/elf.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/elf.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/elf-em.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/compat.h \
    $(wildcard include/config/ARCH_HAS_SYSCALL_WRAPPER) \
    $(wildcard include/config/X86_X32_ABI) \
    $(wildcard include/config/COMPAT_OLD_SIGACTION) \
    $(wildcard include/config/HARDENED_USERCOPY) \
    $(wildcard include/config/ODD_RT_SIGACTION) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sem.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/sem.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/ipc.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rhashtable-types.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/ipc.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/ipcbuf.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/ipcbuf.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/sembuf.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/sembuf.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/socket.h \
    $(wildcard include/config/PROC_FS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/socket.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/socket.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/sockios.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/sockios.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/sockios.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/uio.h \
    $(wildcard include/config/ARCH_HAS_UACCESS_FLUSHCACHE) \
    $(wildcard include/config/ARCH_HAS_COPY_MC) \
  /home/lorenzo/Code/linux4polarfire/include/linux/ucopysize.h \
    $(wildcard include/config/HARDENED_USERCOPY_DEFAULT_ON) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/uio.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/socket.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/if.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/libc-compat.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/hdlc/ioctl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/fs.h \
    $(wildcard include/config/FANOTIFY_ACCESS_PERMISSIONS) \
    $(wildcard include/config/READ_ONLY_THP_FOR_FS) \
    $(wildcard include/config/FS_POSIX_ACL) \
    $(wildcard include/config/CGROUP_WRITEBACK) \
    $(wildcard include/config/IMA) \
    $(wildcard include/config/FILE_LOCKING) \
    $(wildcard include/config/FSNOTIFY) \
    $(wildcard include/config/EPOLL) \
    $(wildcard include/config/UNICODE) \
    $(wildcard include/config/FS_ENCRYPTION) \
    $(wildcard include/config/FS_VERITY) \
    $(wildcard include/config/QUOTA) \
    $(wildcard include/config/FS_DAX) \
    $(wildcard include/config/BLOCK) \
  /home/lorenzo/Code/linux4polarfire/include/linux/vfsdebug.h \
    $(wildcard include/config/DEBUG_VFS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/wait_bit.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kdev_t.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/kdev_t.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/dcache.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rculist.h \
    $(wildcard include/config/PROVE_RCU_LIST) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rculist_bl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/list_bl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/bit_spinlock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/lockref.h \
    $(wildcard include/config/ARCH_USE_CMPXCHG_LOCKREF) \
  /home/lorenzo/Code/linux4polarfire/include/linux/stringhash.h \
    $(wildcard include/config/DCACHE_WORD_ACCESS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/hash.h \
    $(wildcard include/config/HAVE_ARCH_HASH) \
  /home/lorenzo/Code/linux4polarfire/include/linux/path.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/list_lru.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/shrinker.h \
    $(wildcard include/config/SHRINKER_DEBUG) \
  /home/lorenzo/Code/linux4polarfire/include/linux/xarray.h \
    $(wildcard include/config/XARRAY_MULTI) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/mm.h \
    $(wildcard include/config/MMU_LAZY_TLB_REFCOUNT) \
    $(wildcard include/config/ARCH_HAS_MEMBARRIER_CALLBACKS) \
    $(wildcard include/config/ARCH_HAS_SYNC_CORE_BEFORE_USERMODE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sync_core.h \
    $(wildcard include/config/ARCH_HAS_PREPARE_SYNC_CORE_CMD) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/sync_core.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/coredump.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/membarrier.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/radix-tree.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/pid.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/capability.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/capability.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/semaphore.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/fcntl.h \
    $(wildcard include/config/ARCH_32BIT_OFF_T) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/fcntl.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/fcntl.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/asm-generic/fcntl.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/openat2.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/migrate_mode.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/percpu-rwsem.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcuwait.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/signal.h \
    $(wildcard include/config/SCHED_AUTOGROUP) \
    $(wildcard include/config/BSD_PROCESS_ACCT) \
    $(wildcard include/config/TASKSTATS) \
    $(wildcard include/config/STACK_GROWSUP) \
  /home/lorenzo/Code/linux4polarfire/include/linux/signal.h \
    $(wildcard include/config/DYNAMIC_SIGFRAME) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/jobctl.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/task.h \
    $(wildcard include/config/HAVE_EXIT_THREAD) \
    $(wildcard include/config/ARCH_WANTS_DYNAMIC_TASK_STRUCT) \
    $(wildcard include/config/HAVE_ARCH_THREAD_STRUCT_WHITELIST) \
  /home/lorenzo/Code/linux4polarfire/include/linux/uaccess.h \
    $(wildcard include/config/ARCH_HAS_SUBPAGE_FAULTS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/fault-inject-usercopy.h \
    $(wildcard include/config/FAULT_INJECTION_USERCOPY) \
  /home/lorenzo/Code/linux4polarfire/include/linux/nospec.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/uaccess.h \
    $(wildcard include/config/CC_HAS_ASM_GOTO_OUTPUT) \
    $(wildcard include/config/HAVE_EFFICIENT_UNALIGNED_ACCESS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/asm-extable.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/gpr-num.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/cpufeature.h \
    $(wildcard include/config/RISCV_SCALAR_MISALIGNED) \
    $(wildcard include/config/RISCV_MISALIGNED) \
    $(wildcard include/config/RISCV_VECTOR_MISALIGNED) \
    $(wildcard include/config/RISCV_PROBE_UNALIGNED_ACCESS) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/pgtable.h \
    $(wildcard include/config/RELOCATABLE) \
    $(wildcard include/config/PHYS_RAM_BASE) \
    $(wildcard include/config/XIP_PHYS_ADDR) \
    $(wildcard include/config/RISCV_ISA_SVNAPOT) \
    $(wildcard include/config/ARCH_SUPPORTS_PMD_PFNMAP) \
    $(wildcard include/config/ARCH_SUPPORTS_PUD_PFNMAP) \
    $(wildcard include/config/PAGE_TABLE_CHECK) \
    $(wildcard include/config/ARCH_ENABLE_THP_MIGRATION) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/pgtable-bits.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/tlbflush.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/compat.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/compat.h \
    $(wildcard include/config/COMPAT_FOR_U64_ALIGNMENT) \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/pgtable-64.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/page_table_check.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/extable.h \
    $(wildcard include/config/BPF_JIT) \
    $(wildcard include/config/ARCH_RV64I) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/access_ok.h \
    $(wildcard include/config/ALTERNATE_USER_ADDRESS_SPACE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/cred.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/key.h \
    $(wildcard include/config/KEY_NOTIFICATIONS) \
    $(wildcard include/config/NET) \
  /home/lorenzo/Code/linux4polarfire/include/linux/assoc_array.h \
    $(wildcard include/config/ASSOCIATIVE_ARRAY) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/user.h \
    $(wildcard include/config/VFIO_PCI_ZDEV_KVM) \
    $(wildcard include/config/IOMMUFD) \
    $(wildcard include/config/WATCH_QUEUE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/ratelimit.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/posix-timers.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/alarmtimer.h \
    $(wildcard include/config/RTC_CLASS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/hrtimer.h \
    $(wildcard include/config/HIGH_RES_TIMERS) \
    $(wildcard include/config/TIME_LOW_RES) \
    $(wildcard include/config/TIMERFD) \
  /home/lorenzo/Code/linux4polarfire/include/linux/hrtimer_defs.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/timerqueue.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcuref.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rcu_sync.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/delayed_call.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/uuid.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/errseq.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/ioprio.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/sched/rt.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/iocontext.h \
    $(wildcard include/config/BLK_ICQ) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/ioprio.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/fs_types.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/mount.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/mnt_idmapping.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/slab.h \
    $(wildcard include/config/FAILSLAB) \
    $(wildcard include/config/KFENCE) \
    $(wildcard include/config/SLUB_TINY) \
    $(wildcard include/config/SLUB_DEBUG) \
    $(wildcard include/config/SLAB_BUCKETS) \
    $(wildcard include/config/KVFREE_RCU_BATCHED) \
  /home/lorenzo/Code/linux4polarfire/include/linux/percpu-refcount.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kasan.h \
    $(wildcard include/config/KASAN_STACK) \
    $(wildcard include/config/KASAN_VMALLOC) \
  /home/lorenzo/Code/linux4polarfire/include/linux/kasan-enabled.h \
    $(wildcard include/config/ARCH_DEFER_KASAN) \
  /home/lorenzo/Code/linux4polarfire/include/linux/kasan-tags.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/rw_hint.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/file_ref.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/unicode.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/fs.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/quota.h \
    $(wildcard include/config/QUOTA_NETLINK_INTERFACE) \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/dqblk_xfs.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/dqblk_v1.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/dqblk_v2.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/dqblk_qtree.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/projid.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/quota.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/aio_abi.h \
  /home/lorenzo/Code/linux4polarfire/include/uapi/linux/unistd.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/unistd.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/unistd.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/generated/uapi/asm/unistd_64.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/syscall_wrapper.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/uapi/asm/elf.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/cacheinfo.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/cacheinfo.h \
    $(wildcard include/config/ACPI_PPTT) \
    $(wildcard include/config/ARM) \
    $(wildcard include/config/ARCH_HAS_CPU_CACHE_ALIASING) \
  /home/lorenzo/Code/linux4polarfire/include/linux/cpuhplock.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kobject.h \
    $(wildcard include/config/UEVENT_HELPER) \
    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
  /home/lorenzo/Code/linux4polarfire/include/linux/sysfs.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kernfs.h \
    $(wildcard include/config/KERNFS) \
  /home/lorenzo/Code/linux4polarfire/include/linux/idr.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/kobject_ns.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/moduleparam.h \
    $(wildcard include/config/ALPHA) \
    $(wildcard include/config/PPC64) \
  /home/lorenzo/Code/linux4polarfire/include/linux/rbtree_latch.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/error-injection.h \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/error-injection.h \
  /home/lorenzo/Code/linux4polarfire/include/linux/dynamic_debug.h \
  /home/lorenzo/Code/linux4polarfire/arch/riscv/include/asm/module.h \
    $(wildcard include/config/MODULE_SECTIONS) \
  /home/lorenzo/Code/linux4polarfire/include/asm-generic/module.h \
    $(wildcard include/config/HAVE_MOD_ARCH_SPECIFIC) \
  /home/lorenzo/Code/linux4polarfire/include/linux/export-internal.h \
    $(wildcard include/config/PARISC) \

pf_dma.mod.o: $(deps_pf_dma.mod.o)

$(deps_pf_dma.mod.o):
