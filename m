Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C86FC41536
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0BD21567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0BD21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeHXPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:44:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51532 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeHXPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:44:48 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 144ED3EE;
        Fri, 24 Aug 2018 12:10:15 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:10:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.124
Message-ID: <20180824121013.GA26358@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.124 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/arc/Makefile                                       |   15 --
 arch/arc/include/asm/mach_desc.h                        |    2=20
 arch/arc/kernel/irq.c                                   |    2=20
 arch/arc/kernel/process.c                               |   47 +++++-
 arch/arm/boot/dts/am3517.dtsi                           |    5=20
 arch/arm/boot/dts/am437x-sk-evm.dts                     |    2=20
 arch/arm/boot/dts/bcm-cygnus.dtsi                       |   24 +--
 arch/arm/boot/dts/bcm-nsp.dtsi                          |   32 ++--
 arch/arm/boot/dts/da850.dtsi                            |    6=20
 arch/arm/configs/imx_v4_v5_defconfig                    |    2=20
 arch/arm/configs/imx_v6_v7_defconfig                    |    2=20
 arch/arm/mach-omap2/omap-smp.c                          |   41 +++++
 arch/arm/mach-pxa/irq.c                                 |    4=20
 arch/arm/mm/init.c                                      |    9 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi                   |    4=20
 arch/arm64/kernel/smp.c                                 |    2=20
 arch/m68k/include/asm/mcf_pgalloc.h                     |    4=20
 arch/parisc/include/asm/spinlock.h                      |    8 -
 arch/parisc/kernel/syscall.S                            |   24 +--
 arch/s390/net/bpf_jit_comp.c                            |    1=20
 arch/x86/entry/entry_64.S                               |   20 --
 drivers/acpi/nfit/core.c                                |    4=20
 drivers/ata/libahci.c                                   |    7 -
 drivers/dma/k3dma.c                                     |    2=20
 drivers/dma/pl330.c                                     |    2=20
 drivers/gpu/drm/arm/malidp_hw.c                         |    3=20
 drivers/gpu/drm/armada/armada_hw.h                      |    1=20
 drivers/gpu/drm/armada/armada_overlay.c                 |   30 +++-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c           |    6=20
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                 |   29 ++--
 drivers/gpu/drm/exynos/regs-gsc.h                       |    1=20
 drivers/gpu/drm/nouveau/nouveau_gem.c                   |    4=20
 drivers/hid/wacom_wac.c                                 |   10 +
 drivers/i2c/busses/i2c-imx.c                            |    8 -
 drivers/iio/pressure/bmp280-core.c                      |    5=20
 drivers/infiniband/hw/mlx5/srq.c                        |   18 +-
 drivers/infiniband/sw/rxe/rxe_req.c                     |    3=20
 drivers/md/raid10.c                                     |    7 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h             |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c         |    6=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c        |    6=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               |    8 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c         |    2=20
 drivers/net/ethernet/cisco/enic/enic_clsf.c             |    3=20
 drivers/net/ethernet/cisco/enic/enic_main.c             |    3=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c         |   12 +
 drivers/net/ethernet/qlogic/qed/qed_main.c              |   12 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c       |    2=20
 drivers/net/ethernet/qualcomm/qca_spi.c                 |   21 +--
 drivers/net/ethernet/renesas/ravb_main.c                |   56 ++------
 drivers/net/ethernet/renesas/sh_eth.c                   |   59 ++------
 drivers/net/ethernet/stmicro/stmmac/Kconfig             |    2=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c     |   18 ++
 drivers/net/ethernet/ti/davinci_emac.c                  |    4=20
 drivers/net/hamradio/bpqether.c                         |    8 -
 drivers/net/ieee802154/at86rf230.c                      |   15 --
 drivers/net/ieee802154/fakelb.c                         |    2=20
 drivers/net/ipvlan/ipvlan_main.c                        |   36 ++++-
 drivers/net/usb/rtl8150.c                               |    2=20
 drivers/net/usb/smsc75xx.c                              |   62 ++++++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    7 +
 drivers/nfc/pn533/usb.c                                 |    4=20
 drivers/nvme/target/core.c                              |    8 +
 drivers/pci/host/pci-host-common.c                      |    2=20
 drivers/pci/host/pci-versatile.c                        |    2=20
 drivers/pci/host/pcie-rcar.c                            |    2=20
 drivers/pci/host/pcie-xilinx-nwl.c                      |    2=20
 drivers/pci/host/pcie-xilinx.c                          |    1=20
 drivers/pci/hotplug/pci_hotplug_core.c                  |    9 +
 drivers/pci/hotplug/pciehp.h                            |    1=20
 drivers/pci/hotplug/pciehp_core.c                       |    7 +
 drivers/pci/hotplug/pciehp_hpc.c                        |   18 --
 drivers/pci/pci.c                                       |   38 +++++
 drivers/pci/probe.c                                     |    4=20
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c                   |    6=20
 drivers/scsi/xen-scsifront.c                            |   33 +++-
 drivers/usb/dwc2/gadget.c                               |    7 -
 drivers/usb/dwc2/hcd_intr.c                             |    3=20
 drivers/usb/dwc3/dwc3-of-simple.c                       |    3=20
 drivers/usb/gadget/composite.c                          |    3=20
 drivers/usb/host/xhci-tegra.c                           |    2=20
 drivers/usb/host/xhci.c                                 |    7 -
 drivers/xen/manage.c                                    |   18 ++
 drivers/xen/xen-scsiback.c                              |   16 +-
 fs/ceph/inode.c                                         |    1=20
 fs/ext4/mballoc.c                                       |    4=20
 fs/reiserfs/xattr.c                                     |    4=20
 include/linux/fsl/guts.h                                |    1=20
 include/linux/pci.h                                     |    2=20
 include/net/ipv6.h                                      |    9 -
 include/net/net_namespace.h                             |    1=20
 include/net/netns/ipv6.h                                |    1=20
 include/net/tc_act/tc_tunnel_key.h                      |    1=20
 include/net/tcp.h                                       |    2=20
 kernel/locking/lockdep.c                                |   12 -
 kernel/trace/trace.c                                    |    5=20
 mm/kasan/kasan.c                                        |    5=20
 net/batman-adv/bat_iv_ogm.c                             |    4=20
 net/batman-adv/bat_v.c                                  |    4=20
 net/core/dev.c                                          |    4=20
 net/ieee802154/6lowpan/core.c                           |    6=20
 net/ipv4/netfilter/ip_tables.c                          |    1=20
 net/ipv4/tcp.c                                          |    4=20
 net/ipv4/tcp_dctcp.c                                    |   25 ---
 net/ipv4/tcp_output.c                                   |    4=20
 net/ipv6/calipso.c                                      |    9 -
 net/ipv6/exthdrs.c                                      |  111 ++++-------=
-----
 net/ipv6/ipv6_sockglue.c                                |   27 ++-
 net/ipv6/mcast.c                                        |    9 -
 net/ipv6/netfilter/ip6_tables.c                         |    1=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                 |    6=20
 net/netfilter/nf_conntrack_core.c                       |    2=20
 net/netfilter/nf_conntrack_proto_dccp.c                 |    8 -
 net/netfilter/nf_log.c                                  |    4=20
 net/packet/af_packet.c                                  |   12 +
 net/qrtr/qrtr.c                                         |    4=20
 net/sched/act_tunnel_key.c                              |    6=20
 net/wireless/nl80211.c                                  |   19 --
 net/xfrm/xfrm_user.c                                    |    8 -
 samples/bpf/parse_varlen.c                              |    6=20
 samples/bpf/test_overhead_user.c                        |   19 ++
 security/smack/smack_lsm.c                              |    1=20
 sound/core/seq/seq_clientmgr.c                          |    3=20
 tools/build/Makefile                                    |    2=20
 tools/objtool/elf.c                                     |   41 ++++-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c       |    2=20
 tools/perf/bench/numa.c                                 |    5=20
 tools/perf/tests/topology.c                             |    1=20
 tools/perf/util/llvm-utils.c                            |    6=20
 tools/testing/selftests/pstore/pstore_post_reboot_tests |    5=20
 tools/testing/selftests/static_keys/test_static_keys.sh |   13 +
 tools/testing/selftests/sync/config                     |    4=20
 tools/testing/selftests/user/test_user_copy.sh          |    7 +
 tools/testing/selftests/x86/sigreturn.c                 |   59 +++++---
 tools/testing/selftests/zram/zram.sh                    |    5=20
 tools/testing/selftests/zram/zram_lib.sh                |    5=20
 virt/kvm/arm/vgic/vgic-v3.c                             |    5=20
 virt/kvm/eventfd.c                                      |   11 -
 139 files changed, 894 insertions(+), 573 deletions(-)

Adam Ford (1):
      ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Ajay Gupta (1):
      usb: xhci: increase CRS timeout value

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexey Brodkin (2):
      ARC: Explicitly add -mmedium-calls to CFLAGS
      ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP

Alison Wang (1):
      drm: mali-dp: Enable Global SE interrupts mask for DP500

Andrey Ryabinin (1):
      netfilter: nf_conntrack: Fix possible possible crash on module loadin=
g.

Andy Lutomirski (3):
      x86/entry/64: Remove %ebx handling from error_entry/exit
      selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs
      selftests/x86/sigreturn: Do minor cleanups

Ard Biesheuvel (1):
      KVM: arm/arm64: Drop resource size check for GICV window

Arun Kumar Neelakantam (1):
      net: qrtr: Broadcast messages only from control port

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible if po=
ssible

BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reasse=
mble

Bob Copeland (1):
      nl80211: relax ht operation checks for mesh

Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when set_in=
terface

Dan Carpenter (4):
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
      qlogic: check kstrtoul() for errors
      pinctrl: nsp: off by ones in nsp_pinmux_enable()
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Daniel Borkmann (1):
      bpf, s390: fix potential memleak when later bpf_jit_prog fails

Daniel Mack (2):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Dave Jiang (2):
      acpi/nfit: fix cmd_rc for acpi_nfit_ctl to always return a value
      nfit: fix unchecked dereference in acpi_nfit_ctl

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

Davide Caratti (1):
      net/sched: act_tunnel_key: fix NULL dereference when 'goto chain' is =
used

Dinh Nguyen (1):
      net: stmmac: socfpga: add additional ocp reset line for Stratix10

Dongjiu Geng (1):
      usb: xhci: remove the code build warning

Eric Dumazet (2):
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
      xfrm_user: prevent leaking 2 bytes of kernel memory

Esben Haabendal (1):
      i2c: imx: Fix race condition in dma read

Fabio Estevam (2):
      ARM: imx_v6_v7_defconfig: Select ULPI support
      ARM: imx_v4_v5_defconfig: Select ULPI support

Fathi Boudra (1):
      selftests: sync: add config fragment for testing sync framework

Florian Fainelli (2):
      ARM: dts: NSP: Fix i2c controller interrupt type
      ARM: dts: NSP: Fix PCIe controllers interrupt types

Florian Westphal (2):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior=
 state

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Govindarajulu Varadarajan (1):
      enic: initialize enic->rfs_h.lock in enic_probe

Greg Kroah-Hartman (1):
      Linux 4.9.124

Greg Ungerer (1):
      m68k: fix "bad page state" oops on ColdFire boot

Grigor Tovmasyan (1):
      usb: gadget: dwc2: fix memory leak in gadget_init()

Hangbin Liu (2):
      ipv6: mcast: fix unsolicited report interval after receiving querys
      ipvlan: call dev_change_flags when ipvlan mode is reset

Hans de Goede (1):
      NFC: pn533: Fix wrong GFP flag usage

Jann Horn (2):
      netfilter: nf_log: fix uninit read in nf_log_proc_dostring
      reiserfs: fix broken xattr handling (heap corruption, bad retval)

Jason Gerecke (1):
      HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

Jeremy Cline (1):
      ext4: fix spectre gadget in ext4_mb_regular_allocator()

Jiri Olsa (1):
      perf bench: Fix numa report output code

Johan Hovold (1):
      usb: dwc3: of-simple: fix use-after-free on remove

John David Anglin (2):
      parisc: Remove ordered stores from syscall.S
      parisc: Remove unnecessary barriers from spinlock.h

John Garry (1):
      libahci: Fix possible Spectre-v1 pmp indexing in ahci_led_store()

Josh Poimboeuf (1):
      objtool: Support GCC 8 '-fnoreorder-functions'

Kamal Heib (1):
      RDMA/mlx5: Fix memory leak in mlx5_ib_create_srq() error path

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kim Phillips (1):
      perf llvm-utils: Remove bashism from kernel include fetch script

Laura Abbott (1):
      tools: build: Use HOSTLDFLAGS with fixdep

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Lubomir Rintel (1):
      ieee802154: 6lowpan: set IFLA_LINK

Lukas Wunner (3):
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug
      PCI: pciehp: Fix unprotected list iteration in IRQ handler

Marek Szyprowski (4):
      dmaengine: pl330: report BURST residue granularity
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des
      drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
      drm/exynos: decon5433: Fix WINCONx reset value

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Max Gurtuvoy (1):
      nvmet: reset keep alive timer in controller enable

Michael Chan (1):
      bnxt_en: Always set output parameters in bnxt_get_max_rings().

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Myron Stowe (1):
      PCI: Skip MPS logic for Virtual Functions (VFs)

Nicholas Mc Guire (2):
      PCI: xilinx: Add missing of_node_put()
      PCI: xilinx-nwl: Add missing of_node_put()

Nishanth Menon (1):
      ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB) for seco=
ndary cores

Paolo Bonzini (1):
      KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Paul Moore (1):
      ipv6: make ipv6_renew_options() interrupt/kernel safe

Peter Zijlstra (1):
      ARC: Improve cmpxchg syscall implementation

Randy Dunlap (2):
      net/ethernet/freescale/fman: fix cross-build error
      tcp: identify cryptic messages as TCP seq # bugs

Ray Jui (3):
      ARM: dts: Cygnus: Fix I2C controller interrupt type
      ARM: dts: Cygnus: Fix PCIe controller interrupt type
      arm64: dts: ns2: Fix I2C controller interrupt type

Russell King (1):
      drm/armada: fix colorkey mode property

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

Sergei Shtylyov (2):
      PCI: OF: Fix I/O space page leak
      PCI: versatile: Fix I/O space page leak

Shuah Khan (Samsung OSG) (4):
      selftests: pstore: return Kselftest Skip code for skipped tests
      selftests: static_keys: return Kselftest Skip code for skipped tests
      selftests: user: return Kselftest Skip code for skipped tests
      selftests: zram: return Kselftest Skip code for skipped tests

Stefan Agner (1):
      net: hamradio: use eth_broadcast_addr

Stefan Schmidt (3):
      ieee802154: at86rf230: switch from BUG_ON() to WARN_ON() on problem
      ieee802154: at86rf230: use __func__ macro for debug messages
      ieee802154: fakelb: switch from BUG_ON() to WARN_ON() on problem

Stefan Wahren (3):
      net: qca_spi: Avoid packet drop during initial sync
      net: qca_spi: Make sure the QCA7000 reset is triggered
      net: qca_spi: Fix log level if probe fails

Steven Rostedt (VMware) (2):
      locking/lockdep: Do not record IRQ state within lockdep code
      ARM: 8780/1: ftrace: Only set kernel memory back to read-only after b=
oot

Sudarsana Reddy Kalluru (2):
      qed: Add sanity check for SIMD fastpath handler.
      bnx2x: Fix receiving tx-timeout in error or recovery state.

Sven Eckelmann (2):
      batman-adv: Fix bat_ogm_iv best gw refcnt after netlink dump
      batman-adv: Fix bat_v best gw refcnt after netlink dump

Taeung Song (2):
      samples/bpf: add missing <linux/if_vlan.h>
      samples/bpf: Check the error of write() and read()

Takashi Iwai (1):
      ALSA: seq: Fix UBSAN warning at SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioc=
tl

Thomas Richter (1):
      perf test session topology: Fix test on s390

Tomasz Duszynski (1):
      iio: pressure: bmp280: fix relative humidity unit

Vijay Immanuel (1):
      IB/rxe: Fix missing completion for mem_reg work requests

Vikas Gupta (1):
      bnxt_en: Fix for system hang if request_irq fails

Vladimir Zapolskiy (4):
      sh_eth: fix invalid context bug while calling auto-negotiation by eth=
tool
      sh_eth: fix invalid context bug while changing link options by ethtool
      ravb: fix invalid context bug while calling auto-negotiation by ethto=
ol
      ravb: fix invalid context bug while changing link options by ethtool

Wei Yongjun (1):
      pinctrl: nsp: Fix potential NULL dereference

Willem de Bruijn (2):
      packet: reset network header if packet shorter than ll reserved space
      packet: refine ring v3 block size test to hold one frame

William Wu (1):
      usb: dwc2: fix isoc split in transfer with no data

Yan, Zheng (1):
      ceph: fix dentry leak in splice_dentry()

Yuchung Cheng (1):
      tcp: remove DELAYED ACK events in DCTCP

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

Zhen Lei (1):
      kasan: fix shadow_size calculation error in kasan_module_alloc

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

Zhouyang Jia (3):
      xen: add error handling for xenbus_printf
      scsi: xen-scsifront: add error handling for xenbus_printf
      xen/scsiback: add error handling for xenbus_printf


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt/9aUACgkQONu9yGCS
aT4kIg/+JyKB7GwNp7x8/GW1GCOJyFsclE1d8EHtQXfkPh9DArB6iTQJzjdpw29x
h2vRBa4yM/noLiViHi9hJJitRnuwaSSC18Dm2eBbsSo0wAOAjcciajie6YKCF5PQ
l7qEXyjCr/udtrKRB6KU7bq/eMBLGNoNxqWi64YjRPzixj44I2CiFBslbcr1u3NG
ZKtYNYicDsxIhVsnvzbX3Tgj4XaGZNo8HBW9wXvzFWGdrqbF/mKRLuJ0c8XRAxKG
j9qU/bQUnnL3x0nCTfD0t50snkjmIB0tFxOfcwE/RA/c884Vo6eqNtSWydEv5ytM
ZEP0LvodOufmWRDlMJ41/PVMxumV5nAp1JAdg7H2k4FbtvQipTANrz2UXtRqeIUT
a/fWWGdYZ7ncACPoceX8rI9QkKSSxeI23h/4bJl9PPMhpWNJlwjWNE4+5oNczQ6R
Tp06I9Td6PnYsMQhZ9kIGj+8SAvGSZeK8ag427/azq8K0xtZebEjx/7+W1ePM7pw
SMWLWiY9t12PWXWpi0mPv1c79TstLzagUHXFvGNBX2IJraoxPAKKeK0+lgihl/uw
0kwh6qGqFMD1szk9D0wiWJ2weDCjADIb28kNPi5qDiqmdBFkAzsre3e1Ivz3P81Q
GSKW/NApdXMd1ExbsR3UnQe8j3zENVE7qFBh266gc/5aKHRui6k=
=cgm6
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
