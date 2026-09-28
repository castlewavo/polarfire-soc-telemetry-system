savedcmd_pf_regs.mod := printf '%s\n'   pf_regs.o | awk '!x[$$0]++ { print("./"$$0) }' > pf_regs.mod
