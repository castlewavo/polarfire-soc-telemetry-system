savedcmd_pf_dma.mod := printf '%s\n'   pf_dma.o | awk '!x[$$0]++ { print("./"$$0) }' > pf_dma.mod
