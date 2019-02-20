Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC96DC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB2F2089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656485;
	bh=XF2Whfp3BhK52a9Zwv9pEKG+NQbhhpEhhtFOt0jVY84=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mcbXybFliuHBtBjOn69H1/yRWAAHCbkZMhzsN3e5SZTpVDBe+nhPP87d13BIl0VZv
	 qf/BkmmK+weAREOPKWMwinyXUS57Qk27dBetkpzsFmU/Met+HN1RhMFxjSLAiR9x0e
	 w/M0Xo/GY+hhFF2+KfgTGqqZpMlStlokN2rKVqZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBTJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfBTJyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:54:43 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5692089F;
        Wed, 20 Feb 2019 09:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656482;
        bh=XF2Whfp3BhK52a9Zwv9pEKG+NQbhhpEhhtFOt0jVY84=;
        h=Date:From:To:Cc:Subject:From;
        b=UcbKqmN2Suu5J22blUEzEs8oDg/pAD1GQXh/Qe7l2lNCgBamg8sN1ppUUHp4usyVo
         mdXdNTY4rKOor1CC90HvATaAy7mrqio2DnJYCjF1My76VIRYom1f7pWqVF/l+osrIq
         4ejUhhn/rPONhJakAJ/lyRlWAh5vhTBy/yRZJ688=
Date:   Wed, 20 Feb 2019 10:54:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.135
Message-ID: <20190220095438.GA14903@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.135 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    2=20
 arch/alpha/include/asm/irq.h                        |    6=20
 arch/alpha/mm/fault.c                               |    2=20
 arch/arm/boot/dts/da850-evm.dts                     |    2=20
 arch/arm/boot/dts/kirkwood-dnskw.dtsi               |    4=20
 arch/arm/boot/dts/omap4-sdp.dts                     |    1=20
 arch/arm/kernel/smp.c                               |   15 ++
 arch/arm/kvm/mmio.c                                 |   11 -
 arch/arm/mach-imx/clk-imx6sl.c                      |    6=20
 arch/arm/mach-integrator/impd1.c                    |    6=20
 arch/arm/mach-iop32x/n2100.c                        |    3=20
 arch/arm/mach-omap2/omap_hwmod.c                    |    6=20
 arch/arm/mach-pxa/cm-x300.c                         |    2=20
 arch/arm/mach-pxa/littleton.c                       |    2=20
 arch/arm/mach-pxa/zeus.c                            |    2=20
 arch/arm64/kernel/entry-ftrace.S                    |    1=20
 arch/mips/include/uapi/asm/inst.h                   |    2=20
 arch/mips/pci/pci-octeon.c                          |   10 -
 arch/powerpc/include/asm/uaccess.h                  |    2=20
 arch/powerpc/platforms/pseries/dlpar.c              |    2=20
 arch/um/include/asm/pgtable.h                       |    9 +
 arch/x86/ia32/ia32_aout.c                           |    6=20
 arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c |    4=20
 arch/x86/kvm/vmx.c                                  |    1=20
 arch/x86/kvm/x86.c                                  |    7 +
 arch/x86/pci/broadcom_bus.c                         |    4=20
 drivers/ata/sata_rcar.c                             |    4=20
 drivers/block/drbd/drbd_nl.c                        |   15 +-
 drivers/block/drbd/drbd_receiver.c                  |   13 +-
 drivers/block/swim3.c                               |    6=20
 drivers/cdrom/gdrom.c                               |    1=20
 drivers/cpuidle/cpuidle-big_little.c                |    7 -
 drivers/crypto/ux500/cryp/cryp_core.c               |    4=20
 drivers/crypto/ux500/hash/hash_core.c               |    2=20
 drivers/dma/imx-dma.c                               |    8 -
 drivers/gpu/drm/drm_modes.c                         |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                 |    9 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c             |    2=20
 drivers/hid/hid-debug.c                             |  121 +++++++--------=
-----
 drivers/hwmon/lm80.c                                |   26 +++-
 drivers/input/misc/bma150.c                         |    9 -
 drivers/input/mouse/elantech.c                      |    9 +
 drivers/isdn/hisax/hfc_pci.c                        |    2=20
 drivers/media/platform/davinci/vpbe.c               |    7 -
 drivers/memstick/core/memstick.c                    |    3=20
 drivers/misc/vexpress-syscfg.c                      |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c               |   15 +-
 drivers/net/ethernet/broadcom/bcmsysport.c          |   25 +---
 drivers/net/ethernet/broadcom/bcmsysport.h          |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c         |    2=20
 drivers/net/ethernet/intel/igb/igb_main.c           |    8 -
 drivers/net/ethernet/marvell/skge.c                 |    6=20
 drivers/net/ethernet/sun/niu.c                      |   10 +
 drivers/net/usb/kaweth.c                            |   18 --
 drivers/net/usb/smsc95xx.c                          |   12 -
 drivers/pinctrl/qcom/pinctrl-msm.c                  |   23 ++-
 drivers/soc/tegra/common.c                          |    6=20
 drivers/staging/iio/adc/ad7280a.c                   |   17 ++
 drivers/staging/iio/adc/ad7780.c                    |    6=20
 drivers/staging/iio/resolver/ad2s90.c               |    7 -
 drivers/thermal/thermal_hwmon.h                     |    4=20
 drivers/tty/serial/fsl_lpuart.c                     |    4=20
 drivers/usb/core/hub.c                              |   10 +
 drivers/usb/dwc2/hcd.c                              |    1=20
 drivers/usb/gadget/udc/net2272.c                    |    2=20
 drivers/usb/host/ehci-msm.c                         |    6=20
 drivers/usb/phy/phy-am335x.c                        |    5=20
 drivers/video/console/fbcon.c                       |    2=20
 drivers/video/fbdev/clps711x-fb.c                   |    5=20
 drivers/video/fbdev/core/fbmem.c                    |    8 -
 fs/cifs/file.c                                      |    8 +
 fs/cifs/readdir.c                                   |    9 +
 fs/cifs/smb2file.c                                  |    4=20
 fs/debugfs/inode.c                                  |    7 +
 fs/dlm/ast.c                                        |   10 +
 fs/eventpoll.c                                      |    2=20
 fs/f2fs/file.c                                      |    3=20
 fs/fuse/dev.c                                       |    5=20
 fs/fuse/file.c                                      |    2=20
 fs/nfs/super.c                                      |    3=20
 fs/nfsd/nfsctl.c                                    |    2=20
 fs/ocfs2/buffer_head_io.c                           |    2=20
 fs/udf/inode.c                                      |    6=20
 include/linux/genl_magic_struct.h                   |    5=20
 include/linux/hid-debug.h                           |    9 -
 include/sound/compress_driver.h                     |    6=20
 kernel/events/ring_buffer.c                         |    3=20
 kernel/hung_task.c                                  |    8 -
 kernel/signal.c                                     |   61 +++++++++-
 kernel/time/timekeeping.c                           |    4=20
 kernel/trace/trace_uprobe.c                         |    9 +
 net/batman-adv/hard-interface.c                     |    4=20
 net/batman-adv/soft-interface.c                     |    2=20
 net/ceph/messenger.c                                |    5=20
 net/dccp/ccid.h                                     |    4=20
 net/dsa/slave.c                                     |   12 +
 net/ipv6/xfrm6_tunnel.c                             |    3=20
 net/xfrm/xfrm_user.c                                |   13 +-
 scripts/decode_stacktrace.sh                        |    2=20
 scripts/mod/modpost.c                               |   50 ++++----
 security/smack/smack_lsm.c                          |   12 +
 sound/soc/fsl/Kconfig                               |    2=20
 sound/usb/pcm.c                                     |    9 +
 tools/perf/arch/x86/util/kvm-stat.c                 |    2=20
 tools/perf/tests/evsel-tp-sched.c                   |    2=20
 105 files changed, 570 insertions(+), 294 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Alexey Khoroshilov (2):
      media: DaVinci-VPBE: fix error handling in vpbe_initialize()
      video: clps711x-fb: release disp device node in probe()

Andreas Ziegler (1):
      tracing/uprobes: Fix output for multiple string arguments

Andrzej Hajda (1):
      usb: host: ehci-msm: fix handling platform_get_irq result

Andy Duan (1):
      serial: fsl_lpuart: clear parity enable bit when disable parity

Anson Huang (1):
      clk: imx6sl: ensure MMDC CH0 handshake is bypassed

Anton Ivanov (1):
      um: Avoid marking pages with "changed protection"

Arnd Bergmann (1):
      ARM: pxa: avoid section mismatch warning

Bart Van Assche (1):
      timekeeping: Use proper seqcount initializer

Bin Liu (1):
      usb: phy: am335x: fix race condition in _probe

Bob Peterson (1):
      dlm: Don't swamp the CPU with callbacks queued during recovery

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Charles Keepax (1):
      ALSA: compress: Fix stop handling on compressed capture streams

Chris Perl (1):
      NFS: nfs_compare_mount_options always compare auth flavors.

Christian Lamparter (1):
      pinctrl: msm: fix gpio-hog related boot issues

Christophe Leroy (1):
      powerpc/uaccess: fix warning/error with access_ok()

Colin Ian King (1):
      x86/PCI: Fix Broadcom CNB20LE unintended sign extension (redux)

Dan Carpenter (2):
      skge: potential memory corruption in skge_get_regs()
      misc: vexpress: Off by one in vexpress_syscfg_exec()

Davidlohr Bueso (1):
      fs/epoll: drop ovflist branch prediction

Eduardo Valentin (1):
      thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Eric Dumazet (2):
      dccp: fool proof ccid_hc_[rt]x_parse_options()
      kaweth: use skb_cow_head() to deal with cloned skbs

Eric W. Biederman (3):
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals
      signal: Restore the stop PTRACE_EVENT_EXIT

Fabio Estevam (1):
      ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build error on i.MX8M

Finn Thain (1):
      block/swim3: Fix -EBUSY error when re-opening device after unmount

Florian Fainelli (1):
      net: systemport: Fix WoL with password after deep sleep

Florian Westphal (1):
      xfrm: refine validation of template and selector families

Frank Rowand (1):
      powerpc/pseries: add of_node_put() in dlpar_detach_node()

Govindarajulu Varadarajan (1):
      enic: fix checksum validation for IPv6

Greg Kroah-Hartman (2):
      debugfs: fix debugfs_rename parameter checking
      Linux 3.18.135

Gustavo A. R. Silva (2):
      usb: gadget: udc: net2272: Fix bitwise and boolean operations
      perf tests evsel-tp-sched: Fix bitwise operator

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

J. Bruce Fields (1):
      nfsd4: fix crash on writing v4_end_grace before nfsd startup

James Hughes (1):
      smsc95xx: Use skb_cow_head to deal with cloned skbs

Jan Kara (1):
      udf: Fix BUG on corrupted inode

Jann Horn (1):
      fuse: call pipe_buf_release() under pipe lock

Jia-Ju Bai (1):
      isdn: hisax: hfc_pci: Fix a possible concurrency use-after-free bug i=
n HFCPCI_l1hw()

Jiong Wang (1):
      mips: bpf: fix encoding bug for mm_srlv32_op

John Youn (1):
      usb: dwc2: Remove unnecessary kfree

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data

Junxiao Bi (1):
      ocfs2: don't clear bh uptodate for block read

Kai-Heng Feng (2):
      memstick: Prevent memstick host from getting runtime suspended during=
 card detection
      igb: Fix an issue that PME is not enabled during runtime suspend

Kan Liang (1):
      perf/x86/intel/uncore: Add Node ID mask

Kangjie Lu (3):
      hwmon: (lm80) fix a missing check of the status of SMBus read
      hwmon: (lm80) fix a missing check of bus read in lm80 probe
      niu: fix missing checks of niu_pci_eeprom_read

Lars Ellenberg (2):
      drbd: disconnect, if the wrong UUIDs are attached on a connected peer
      drbd: skip spurious timeout (ping-timeo) when failing promote

Leonid Iziumtsev (1):
      dmaengine: imx-dma: fix wrong callback invoke

Linus Torvalds (1):
      Revert "exec: load_script: don't blindly truncate shebang string"

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Marc Zyngier (1):
      scripts/decode_stacktrace: only strip base path when a prefix of the =
path

Mark Rutland (3):
      arm64: ftrace: don't adjust the LR value
      arm64: KVM: Skip MMIO insn after emulation
      perf/core: Don't WARN() for impossible ring-buffer sizes

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Matheus Tavares (1):
      staging:iio:ad2s90: Make probe handle spi_setup failure

Mathias Nyman (1):
      usb: hub: delay hub autosuspend if USB3 port is still link training

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Miklos Szeredi (2):
      fuse: decrement NR_WRITEBACK_TEMP on the right page
      fuse: handle zero sized retrieve correctly

Nathan Chancellor (4):
      ARM: OMAP2+: hwmod: Fix some section annotations
      drbd: Avoid Clang warning about pointless switch statment
      crypto: ux500 - Use proper enum in cryp_set_dma_transfer
      crypto: ux500 - Use proper enum in hash_set_dma_transfer

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Noralf Tr=F8nnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Oleg Nesterov (1):
      exec: load_script: don't blindly truncate shebang string

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-=
7222)

Peter Rosin (1):
      fbdev: fbmem: behave better with small rotated displays and many CPUs

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CV=
E-2019-7221)

Peter Ujfalusi (1):
      ARM: dts: da850-evm: Correct the sound card name

Pu Wen (1):
      perf tools: Add Hygon Dhyana support

Renato Lui Geh (1):
      staging: iio: ad7780: update voltage on read

Roland Kammerer (1):
      drbd: narrow rcu_read_lock in drbd_sync_handshake

Ronnie Sahlberg (1):
      cifs: check ntwrk_buf_start for NULL before dereferencing it

Ross Lagerwall (1):
      cifs: Limit memory used by lock request calls to a page

Rundong Ge (1):
      net: dsa: slave: Don't propagate flag changes on down slave interfaces

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Russell King - ARM Linux (1):
      ARM: dts: Fix OMAP4430 SDP Ethernet startup

Sami Tolvanen (1):
      modpost: validate symbol names also in find_elf_symbol

Sergei Shtylyov (1):
      sata_rcar: fix deferred probing

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Slawomir Stepien (1):
      staging: iio: adc: ad7280a: handle error from __ad7280_read32()

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Tetsuo Handa (1):
      kernel/hung_task.c: break RCU locks based on jiffies

Thomas Hellstrom (2):
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

Wenwen Wang (1):
      gdrom: fix a memory leak bug

Yangtao Li (2):
      soc/tegra: Don't leak device tree node reference
      cpuidle: big.LITTLE: fix refcount leak

YueHaibing (1):
      xfrm6_tunnel: Fix spi check in __xfrm6_tunnel_alloc_spi

Yufen Wang (1):
      ARM: 8808/1: kexec:offline panic_smp_self_stop CPU

Yunlei He (1):
      f2fs: move dir data flush to write checkpoint process

Zoran Markovic (1):
      smack: fix access permissions for keyring


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxtI9sACgkQONu9yGCS
aT6KPA/8DvKLo8u1G01BItM9CPLlH81lHjmA8T7UvQ1CLQeUIFDg4+flVAZK6bWK
hcNdZCZhj9hl1CGG+i9WYvYLqzUIsP/gBgX+s8eMmu/aQckR4RW+muhpyZdExzM/
4bLxfJ+ZAyIu37gp95iX3+x8zp1MQ4modZIz04cbrF7bctifBId0H0VarPz8v/s7
4lqOlpzLAXcix7GJ5AyFZwetWq/L1NpCXvNpOrSYWoAEoKGLg6/xysOpGQmRU7Ub
hlH2BhtDI/h8LCToeeBTJhf9Qeofri6pu0yNKVcOO4DUbPhLIuHwM3S7mUs9vZEB
xZKL40394SjqOhc07Ztiyt+4YaqLQhCrXN5eVroyYXJ5GY0dZNo+byQXtfQz5XuX
3IG81SM4yyNE0IrnqMx5sTBEeFI77/4nxUSPH/avLM4PuK5m3AcVRL7xAVpfQyZF
u017+KB+7L40b2kWr2mQxOdl13n3q+OlLm7nBXKsjTYOmGu0mF/v3jFFVVTeECxn
hfzOMjrfb19bdgX9q0iyLdl4E80BWNxRCbI7ijULnTxBBkyUHZqocTJzjI1PCPAv
lb0eKec+3WMoCCehX45cgvX2xBJI7qKs3qFZjZ74Eb2pzMyD4jjUFberiQWDkJAn
fK4menl9QBcj8sRjcYr2JdqtkAgqP0LWqii4jerWbN2zb33mKHY=
=TkqX
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
