Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72350C04E85
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFF62159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFF62159F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeHXPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:45:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbeHXPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:45:08 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78FF63EE;
        Fri, 24 Aug 2018 12:10:38 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:10:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.152
Message-ID: <20180824121035.GA26426@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.152 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/arc/Makefile                                       |   15 ---
 arch/arc/include/asm/mach_desc.h                        |    2=20
 arch/arc/kernel/irq.c                                   |    2=20
 arch/arm/boot/dts/am3517.dtsi                           |    5 +
 arch/arm/boot/dts/am437x-sk-evm.dts                     |    2=20
 arch/arm/boot/dts/bcm-cygnus.dtsi                       |    4 -
 arch/arm/boot/dts/da850.dtsi                            |    6 -
 arch/arm/configs/imx_v4_v5_defconfig                    |    2=20
 arch/arm/configs/imx_v6_v7_defconfig                    |    2=20
 arch/arm/mach-pxa/irq.c                                 |    4 -
 arch/arm/mm/init.c                                      |    9 ++
 arch/arm64/kernel/smp.c                                 |    2=20
 arch/m68k/include/asm/mcf_pgalloc.h                     |    4 -
 arch/parisc/include/asm/spinlock.h                      |    8 --
 arch/parisc/kernel/syscall.S                            |   24 +++---
 drivers/dma/k3dma.c                                     |    2=20
 drivers/gpu/drm/armada/armada_hw.h                      |    1=20
 drivers/gpu/drm/armada/armada_overlay.c                 |   30 +++++--
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c           |    6 -
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                 |   29 +++++--
 drivers/gpu/drm/exynos/regs-gsc.h                       |    1=20
 drivers/gpu/drm/nouveau/nouveau_gem.c                   |    4 -
 drivers/hid/wacom_wac.c                                 |   10 ++
 drivers/i2c/busses/i2c-imx.c                            |    8 +-
 drivers/md/raid10.c                                     |    7 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h             |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c         |    6 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c        |    6 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               |    4 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c         |    2=20
 drivers/net/ethernet/cisco/enic/enic_clsf.c             |    3=20
 drivers/net/ethernet/cisco/enic/enic_main.c             |    3=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c         |   12 ++-
 drivers/net/ethernet/qlogic/qed/qed_main.c              |   12 ++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c       |    2=20
 drivers/net/ethernet/qualcomm/qca_spi.c                 |   21 +++--
 drivers/net/ethernet/ti/davinci_emac.c                  |    4 +
 drivers/net/hamradio/bpqether.c                         |    8 --
 drivers/net/ieee802154/at86rf230.c                      |   15 +--
 drivers/net/ieee802154/fakelb.c                         |    2=20
 drivers/net/usb/rtl8150.c                               |    2=20
 drivers/net/usb/smsc75xx.c                              |   62 +++++++++++=
+++++
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c          |    7 +
 drivers/pci/hotplug/pci_hotplug_core.c                  |    9 ++
 drivers/pci/hotplug/pciehp.h                            |    1=20
 drivers/pci/hotplug/pciehp_core.c                       |    7 +
 drivers/pci/hotplug/pciehp_hpc.c                        |    5 -
 drivers/pci/probe.c                                     |    4 +
 drivers/scsi/xen-scsifront.c                            |   33 ++++++--
 drivers/staging/android/ion/ion.c                       |   17 +++-
 drivers/usb/dwc2/gadget.c                               |    7 +
 drivers/usb/dwc2/hcd_intr.c                             |    3=20
 drivers/usb/gadget/composite.c                          |    3=20
 drivers/usb/host/xhci.c                                 |    7 +
 fs/ext4/mballoc.c                                       |    4 -
 fs/reiserfs/xattr.c                                     |    4 -
 include/linux/fsl/guts.h                                |    1=20
 include/net/net_namespace.h                             |    1=20
 include/net/netns/ipv6.h                                |    1=20
 include/net/tcp.h                                       |    2=20
 kernel/locking/lockdep.c                                |   12 +--
 kernel/trace/trace.c                                    |    5 +
 mm/kasan/kasan.c                                        |    5 -
 net/bridge/br_if.c                                      |   11 ++
 net/core/dev.c                                          |    4 -
 net/ipv4/netfilter/ip_tables.c                          |    1=20
 net/ipv4/tcp.c                                          |    4 -
 net/ipv4/tcp_dctcp.c                                    |   25 ------
 net/ipv4/tcp_output.c                                   |    4 -
 net/ipv6/mcast.c                                        |    9 +-
 net/ipv6/netfilter/ip6_tables.c                         |    1=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                 |    6 -
 net/netfilter/nf_conntrack_proto_dccp.c                 |    8 +-
 net/packet/af_packet.c                                  |   12 ++-
 net/xfrm/xfrm_user.c                                    |    8 +-
 security/smack/smack_lsm.c                              |    1=20
 tools/perf/arch/powerpc/util/skip-callchain-idx.c       |    2=20
 tools/perf/tests/topology.c                             |    1=20
 tools/perf/util/llvm-utils.c                            |    6 -
 tools/testing/selftests/pstore/pstore_post_reboot_tests |    5 +
 tools/testing/selftests/static_keys/test_static_keys.sh |   13 +++
 tools/testing/selftests/sync/config                     |    4 +
 tools/testing/selftests/user/test_user_copy.sh          |    7 +
 tools/testing/selftests/x86/sigreturn.c                 |   46 +++++++----
 tools/testing/selftests/zram/zram.sh                    |    5 +
 tools/testing/selftests/zram/zram_lib.sh                |    5 +
 virt/kvm/eventfd.c                                      |   11 +-
 88 files changed, 471 insertions(+), 222 deletions(-)

Adam Ford (1):
      ARM: dts: am3517.dtsi: Disable reference to OMAP3 OTG controller

Ajay Gupta (1):
      usb: xhci: increase CRS timeout value

Alexander Duyck (1):
      ixgbe: Be more careful when modifying MAC filters

Alexey Brodkin (2):
      ARC: Explicitly add -mmedium-calls to CFLAGS
      ARC: Enable machine_desc->init_per_cpu for !CONFIG_SMP

Andy Lutomirski (1):
      selftests/x86/sigreturn/64: Fix spurious failures on AMD CPUs

Bartosz Golaszewski (1):
      net: davinci_emac: match the mdio device against its compatible if po=
ssible

BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reasse=
mble

Casey Schaufler (1):
      Smack: Mark inode instant in smack_task_to_inode

Chunfeng Yun (1):
      usb: gadget: composite: fix delayed_status race condition when set_in=
terface

Dan Carpenter (3):
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
      qlogic: check kstrtoul() for errors
      drm/nouveau/gem: off by one bugs in nouveau_gem_pushbuf_reloc_apply()

Daniel Mack (2):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source
      ARM: pxa: irq: fix handling of ICMR registers in suspend/resume

Daniel Rosenberg (1):
      staging: android: ion: check for kref overflow

David Lechner (1):
      net: usb: rtl8150: demote allmulti message to dev_dbg()

Elad Raz (1):
      bridge: Propagate vlan add failure to user

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

Florian Westphal (2):
      netfilter: x_tables: set module owner for icmp(6) matches
      netfilter: conntrack: dccp: treat SYNC/SYNCACK as invalid if no prior=
 state

Ganesh Goudar (1):
      cxgb4: when disabling dcb set txq dcb priority to 0

Govindarajulu Varadarajan (1):
      enic: initialize enic->rfs_h.lock in enic_probe

Greg Kroah-Hartman (1):
      Linux 4.4.152

Greg Ungerer (1):
      m68k: fix "bad page state" oops on ColdFire boot

Grigor Tovmasyan (1):
      usb: gadget: dwc2: fix memory leak in gadget_init()

Hangbin Liu (1):
      ipv6: mcast: fix unsolicited report interval after receiving querys

Jann Horn (1):
      reiserfs: fix broken xattr handling (heap corruption, bad retval)

Jason Gerecke (1):
      HID: wacom: Correct touch maximum XY of 2nd-gen Intuos

Jeremy Cline (1):
      ext4: fix spectre gadget in ext4_mb_regular_allocator()

John David Anglin (2):
      parisc: Remove ordered stores from syscall.S
      parisc: Remove unnecessary barriers from spinlock.h

Keerthy (1):
      ARM: dts: da850: Fix interrups property for gpio

Kim Phillips (1):
      perf llvm-utils: Remove bashism from kernel include fetch script

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Lukas Wunner (2):
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug

Marek Szyprowski (3):
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des
      drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
      drm/exynos: decon5433: Fix WINCONx reset value

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Michael Trimarchi (1):
      brcmfmac: stop watchdog before detach and free everything

Myron Stowe (1):
      PCI: Skip MPS logic for Virtual Functions (VFs)

Paolo Bonzini (1):
      KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Randy Dunlap (2):
      net/ethernet/freescale/fman: fix cross-build error
      tcp: identify cryptic messages as TCP seq # bugs

Ray Jui (1):
      ARM: dts: Cygnus: Fix I2C controller interrupt type

Russell King (1):
      drm/armada: fix colorkey mode property

Sandipan Das (1):
      perf report powerpc: Fix crash if callchain is empty

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

Thomas Richter (1):
      perf test session topology: Fix test on s390

Vikas Gupta (1):
      bnxt_en: Fix for system hang if request_irq fails

Willem de Bruijn (2):
      packet: reset network header if packet shorter than ll reserved space
      packet: refine ring v3 block size test to hold one frame

William Wu (1):
      usb: dwc2: fix isoc split in transfer with no data

Yuchung Cheng (1):
      tcp: remove DELAYED ACK events in DCTCP

Yuiko Oshino (1):
      smsc75xx: Add workaround for gigabit link up hardware errata.

Zhen Lei (1):
      kasan: fix shadow_size calculation error in kasan_module_alloc

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

Zhouyang Jia (1):
      scsi: xen-scsifront: add error handling for xenbus_printf


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt/9bsACgkQONu9yGCS
aT6ATxAAqh4k96XYJ8r5RrmQyNT/k3Oo8k5o3bN/GFRqsi/ksX+hvZJA2XGdZdfd
xwgCzBbPPJfJZuERhIsCHSf2J1y9HQSF/5k1zceJLT/VhUqxc4zc/cN11NDxrg7h
jKOUqTvIQ+Ve/b+/IELerU8X1TC2BPghP6KdYkH2JeQYY26tMWZ0mEki8OVgiDX6
QjR5KRR8eBvurfQUloCDDcOjoSZytp6x7jQ6AwQnfcnxzW2CmoniOtL6iz4O4VAu
HEn4XL3r18iV/I0eHG38tnuND0TW17UFVinHCCd1wAILCY5JgvCZ1hAVbQms3Q51
QIBhppKAoylz+rw3FwMpK9KVJl0J3PojM8dG87uN2NwwblpTE5ULyot14Bqxb3JJ
Sh0y89DG8zSAdgDnmv/6ue5sQEkoJdAmVPhNbkD6m7h8L6Fha0/WXxlvPOI7l7Wz
eFg1vX6nEXsPVnUjjo+bpeOiFGDkA1HMA1QzNkVv9WBlzDTdu5ZllTZv8Caenn1l
IeY33RzffqHyGuvwYEPLoPyi36p2VGNAT0F5fJDAW6bNJw5/iipz4AIyPTIJNE4x
FXHF4WbjVx2h+aDMhjFGi3CoLM3l0AzCVxPw5fNhVXwhEdsvVxRGJkE7h8yiTJMp
KQGwD1dkeq3TYVvYX6KH5wkQH+JBRZxRa+omg/vdS0MqdKITwT4=
=08hY
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
