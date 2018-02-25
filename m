Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3662072-1519556982-2-8685007331249901398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519556981; b=NK24HxnYGJR7Dw/gQIzr15K2Iae27nyPVic/vil5Cyh0neo
    S4tb826IwKvllXEM0Gdvw8GQG1LIomT0otltrBWYe1ZAvYGRX07TbsHC88vDwy9S
    aZpX7tlm24F/gsbmxdgHIeSuNlrZGOiOKpNeCLMogcTlXFH/S4LXgQ2CNWeBe6jc
    VDYPrivGQ/wTZ58qR6tD4Dq8moka5fuZqjAjd6e5uBhN5t2YYHu7MIsEaF6N5HY5
    9DIHePITiHj1APTIyyeD9kU82adb4c8mBcQuV6hh84kT+H5P+SKHc6yMjr429Egi
    0l6Bz4MoWG6raZkM+3MrdQmoYX+T8oDksQmsDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519556981; bh=iV7rNJzeQomJl3Lu1y8Se1vJsCH+8chhFYKVhcPMCuk=; b=h
    Q8Yp33y+CiAk/m8hkCB3Lycy/uhXG8FsnDIMCZCAGb/zUEnyEGLHlNLIHGzwLtLx
    Vc4MR9AfPUdISy7cgNWWeaCvQAsR95OhkYBVsmMM4kNyL3CYjVdiQcCl+m2/ONwt
    aPT9UH1KGFVCiKybiybTvsCO6xGCHi3S8lR3R+CmcuuXKckcz9DTwaEh0W5tDXkc
    JHqbW2oUycUwtUCQ04eDnSvrYsp3T4qBercQdwvpzoeiNYRPGMQuuAClBsLbIxPM
    w7+7fJXsPs3oOZj8kowDRRLjQotwPGA3qduNBDXleXMcfmN0TTVD6qHHL9SjFT+H
    gNhCzD6i1jBNbtxXixVuQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBYLJk (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 06:09:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBYLJL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 06:09:11 -0500
Date: Sun, 25 Feb 2018 12:08:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.84
Message-ID: <20180225110852.GA21661@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.84 kernel.

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

 Makefile                                                      |    8=20
 arch/arm/boot/dts/am4372.dtsi                                 |    6=20
 arch/arm/boot/dts/am437x-cm-t43.dts                           |    4=20
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts              |    3=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                         |   16 -
 arch/arm/boot/dts/omap4.dtsi                                  |    4=20
 arch/arm/common/bL_switcher_dummy_if.c                        |    4=20
 arch/arm/mach-omap2/omap-secure.c                             |   19 +
 arch/arm/mach-omap2/omap-secure.h                             |    4=20
 arch/arm/mach-omap2/pm.h                                      |    4=20
 arch/arm/mach-omap2/pm34xx.c                                  |   13 -
 arch/arm/mach-omap2/prm33xx.c                                 |   12 -
 arch/arm/mach-omap2/sleep34xx.S                               |   26 --
 arch/arm64/Kconfig                                            |    2=20
 arch/arm64/Kconfig.platforms                                  |    2=20
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                      |    2=20
 arch/arm64/crypto/crc32-arm64.c                               |    2=20
 arch/arm64/include/asm/bug.h                                  |   33 +-
 arch/arm64/mm/mmu.c                                           |    2=20
 arch/m68k/kernel/vmlinux-nommu.lds                            |    2=20
 arch/m68k/kernel/vmlinux-std.lds                              |    2=20
 arch/m68k/kernel/vmlinux-sun3.lds                             |    2=20
 arch/powerpc/crypto/crc32c-vpmsum_glue.c                      |    1=20
 arch/powerpc/include/asm/exception-64s.h                      |    2=20
 arch/powerpc/include/asm/paca.h                               |    3=20
 arch/powerpc/kernel/asm-offsets.c                             |    3=20
 arch/powerpc/kernel/entry_64.S                                |    9=20
 arch/powerpc/kernel/exceptions-64s.S                          |   99 ++++-=
---
 arch/powerpc/kernel/idle_book3s.S                             |    7=20
 arch/powerpc/kernel/setup_64.c                                |   13 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S                       |    7=20
 arch/powerpc/kvm/book3s_rmhandlers.S                          |    7=20
 arch/powerpc/kvm/book3s_segment.S                             |    4=20
 arch/powerpc/perf/core-book3s.c                               |    4=20
 arch/s390/crypto/crc32-vx.c                                   |    3=20
 arch/sparc/crypto/crc32c_glue.c                               |    1=20
 arch/x86/Kconfig                                              |    2=20
 arch/x86/Kconfig.debug                                        |    1=20
 arch/x86/boot/Makefile                                        |    5=20
 arch/x86/crypto/crc32-pclmul_glue.c                           |    1=20
 arch/x86/crypto/crc32c-intel_glue.c                           |    1=20
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S                  |  112 +++++=
-----
 arch/x86/events/core.c                                        |    4=20
 arch/x86/include/asm/microcode_amd.h                          |    1=20
 arch/x86/include/asm/vmx.h                                    |    5=20
 arch/x86/kernel/cpu/mcheck/mce-inject.c                       |    5=20
 arch/x86/kernel/cpu/microcode/amd.c                           |   17 -
 arch/x86/kernel/vm86_32.c                                     |    5=20
 arch/x86/kvm/Kconfig                                          |    3=20
 arch/x86/kvm/vmx.c                                            |   36 ++-
 arch/x86/kvm/x86.c                                            |   40 ++-
 arch/x86/math-emu/Makefile                                    |    4=20
 arch/x86/math-emu/reg_compare.c                               |   16 -
 arch/x86/mm/ioremap.c                                         |    4=20
 arch/x86/mm/kmmio.c                                           |   12 -
 block/blk-map.c                                               |    4=20
 crypto/ahash.c                                                |   22 +
 crypto/algif_hash.c                                           |   52 ----
 crypto/crc32_generic.c                                        |    1=20
 crypto/crc32c_generic.c                                       |    1=20
 crypto/cryptd.c                                               |    7=20
 crypto/mcryptd.c                                              |    7=20
 crypto/shash.c                                                |   25 +-
 drivers/Makefile                                              |    1=20
 drivers/android/binder.c                                      |    2=20
 drivers/block/rbd.c                                           |    2=20
 drivers/clk/meson/Kconfig                                     |    1=20
 drivers/clk/sunxi-ng/Kconfig                                  |    1=20
 drivers/crypto/bfin_crc.c                                     |    3=20
 drivers/crypto/s5p-sss.c                                      |   12 -
 drivers/crypto/talitos.c                                      |    5=20
 drivers/dma/at_hdmac.c                                        |    4=20
 drivers/dma/dma-jz4740.c                                      |    4=20
 drivers/dma/ioat/init.c                                       |    2=20
 drivers/dma/zx296702_dma.c                                    |    2=20
 drivers/gpio/gpio-intel-mid.c                                 |    2=20
 drivers/gpio/gpio-xgene.c                                     |   13 -
 drivers/gpu/drm/armada/armada_crtc.c                          |   25 +-
 drivers/gpu/drm/drm_modeset_lock.c                            |    2=20
 drivers/gpu/drm/exynos/exynos_hdmi.c                          |    6=20
 drivers/gpu/drm/i915/intel_drv.h                              |    2=20
 drivers/gpu/drm/i915/intel_panel.c                            |   86 +++--=
--
 drivers/gpu/drm/nouveau/nouveau_gem.c                         |    2=20
 drivers/idle/Kconfig                                          |    1=20
 drivers/infiniband/core/cma.c                                 |    1=20
 drivers/infiniband/hw/i40iw/i40iw_d.h                         |    2=20
 drivers/input/keyboard/tca8418_keypad.c                       |   21 +
 drivers/isdn/hardware/eicon/message.c                         |   16 -
 drivers/media/i2c/s5k6aa.c                                    |    5=20
 drivers/media/i2c/tc358743.c                                  |   46 ++--
 drivers/media/pci/tw5864/tw5864-video.c                       |    6=20
 drivers/media/usb/em28xx/Kconfig                              |    2=20
 drivers/media/usb/go7007/Kconfig                              |    2=20
 drivers/net/Kconfig                                           |    3=20
 drivers/net/ethernet/arc/emac_rockchip.c                      |    7=20
 drivers/net/ethernet/freescale/gianfar.c                      |   11=20
 drivers/net/hippi/rrunner.c                                   |    2=20
 drivers/net/ipvlan/ipvlan_core.c                              |    1=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       |    2=20
 drivers/net/wireless/st/cw1200/wsm.c                          |    8=20
 drivers/pci/host/vmd.c                                        |    2=20
 drivers/perf/xgene_pmu.c                                      |    1=20
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c                    |    2=20
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c                     |    6=20
 drivers/platform/x86/dell-laptop.c                            |   17 +
 drivers/platform/x86/intel_mid_thermal.c                      |    2=20
 drivers/s390/block/dasd_eckd.c                                |   16 -
 drivers/scsi/advansys.c                                       |   24 +-
 drivers/spi/Kconfig                                           |    1=20
 drivers/spi/spi-sun4i.c                                       |    2=20
 drivers/staging/android/ashmem.c                              |   19 -
 drivers/staging/android/ion/ion-ioctl.c                       |    4=20
 drivers/staging/android/ion/ion_system_heap.c                 |    2=20
 drivers/staging/iio/adc/ad7192.c                              |   27 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c               |    4=20
 drivers/staging/lustre/lnet/libcfs/linux/linux-crypto-adler.c |    1=20
 drivers/thermal/Kconfig                                       |    4=20
 drivers/usb/dwc3/dwc3-of-simple.c                             |    4=20
 drivers/usb/dwc3/gadget.c                                     |    2=20
 drivers/usb/musb/musb_core.c                                  |    2=20
 drivers/usb/phy/Kconfig                                       |    1=20
 drivers/usb/usbip/stub_dev.c                                  |    3=20
 drivers/usb/usbip/vhci_hcd.c                                  |    2=20
 drivers/vhost/vhost.c                                         |    2=20
 drivers/video/fbdev/mmp/core.c                                |    5=20
 drivers/video/fbdev/via/viafbdev.c                            |    8=20
 drivers/xen/Kconfig                                           |    2=20
 fs/btrfs/ioctl.c                                              |    2=20
 fs/compat_binfmt_elf.c                                        |    2=20
 fs/reiserfs/lbalance.c                                        |    2=20
 fs/reiserfs/reiserfs.h                                        |    1=20
 include/crypto/hash.h                                         |   34 ++-
 include/linux/crypto.h                                        |    8=20
 include/linux/pci-ecam.h                                      |    2=20
 include/linux/ptr_ring.h                                      |    2=20
 include/linux/string.h                                        |    1=20
 include/net/red.h                                             |   13 +
 include/net/sctp/sctp.h                                       |    3=20
 include/trace/events/clk.h                                    |    4=20
 kernel/kcov.c                                                 |    4=20
 kernel/trace/blktrace.c                                       |   32 +-
 lib/Kconfig.debug                                             |    1=20
 lib/oid_registry.c                                            |    8=20
 mm/early_ioremap.c                                            |    2=20
 mm/shmem.c                                                    |    6=20
 mm/util.c                                                     |   24 ++
 mm/vmscan.c                                                   |    3=20
 net/core/dev.c                                                |    2=20
 net/decnet/af_decnet.c                                        |   62 ++---
 net/ipv4/ip_sockglue.c                                        |   14 -
 net/ipv4/netfilter/ipt_CLUSTERIP.c                            |   16 +
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c                |    6=20
 net/ipv6/ipv6_sockglue.c                                      |   17 -
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c                |   18 +
 net/kcm/kcmsock.c                                             |   25 +-
 net/netfilter/x_tables.c                                      |   10=20
 net/netfilter/xt_RATEEST.c                                    |   22 +
 net/netfilter/xt_cgroup.c                                     |    1=20
 net/rds/tcp.c                                                 |    9=20
 net/rds/tcp.h                                                 |    1=20
 net/sched/sch_choke.c                                         |    3=20
 net/sched/sch_gred.c                                          |    3=20
 net/sched/sch_red.c                                           |    2=20
 net/sched/sch_sfq.c                                           |    3=20
 net/sctp/outqueue.c                                           |    6=20
 net/sctp/socket.c                                             |   29 +-
 net/wireless/core.c                                           |    8=20
 net/xfrm/xfrm_policy.c                                        |   11=20
 net/xfrm/xfrm_user.c                                          |   24 ++
 scripts/kernel-doc                                            |    2=20
 security/keys/Kconfig                                         |    1=20
 security/selinux/ss/services.c                                |   21 -
 sound/pci/hda/patch_ca0132.c                                  |    3=20
 sound/soc/rockchip/rockchip_spdif.c                           |   18 +
 sound/soc/ux500/mop500.c                                      |    4=20
 sound/soc/ux500/ux500_pcm.c                                   |    5=20
 tools/build/Makefile.build                                    |   10=20
 tools/perf/bench/numa.c                                       |   56 ++++-
 tools/perf/builtin-top.c                                      |   15 +
 tools/scripts/Makefile.include                                |   12 -
 180 files changed, 1120 insertions(+), 679 deletions(-)

Adam Ford (2):
      ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
      ARM: dts: logicpd-somlv: Fix wl127x pinmux

Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Andre Przywara (2):
      pinctrl: sunxi: Fix A80 interrupt pin bank
      pinctrl: sunxi: Fix A64 UART mux value

Andreas Platschek (1):
      usb: dwc3: of-simple: fix missing clk_disable_unprepare

Andy Shevchenko (1):
      brcmfmac: Avoid build error with make W=3D1

Arnd Bergmann (39):
      ASoC: ux500: add MODULE_LICENSE tag
      video: fbdev/mmp: add MODULE_LICENSE
      ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
      arm64: dts: add #cooling-cells to CPU nodes
      drm/i915: fix intel_backlight_device_register declaration
      shmem: avoid maybe-uninitialized warning
      vmxnet3: prevent building with 64K pages
      perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
      video: fbdev: via: remove possibly unused variables
      scsi: advansys: fix build warning for PCI=3Dn
      gpio: xgene: mark PM functions as __maybe_unused
      arm64: define BUG() instruction without CONFIG_BUG
      x86/fpu/math-emu: Fix possible uninitialized variable use
      x86/build: Silence the build with "make -s"
      thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
      x86: add MULTIUSER dependency for KVM
      x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
      scsi: advansys: fix uninitialized data access
      ALSA: hda/ca0132 - fix possible NULL pointer use
      reiserfs: avoid a -Wmaybe-uninitialized warning
      cw1200: fix bogus maybe-uninitialized warning
      security/keys: BIG_KEY requires CONFIG_CRYPTO
      drm: exynos: mark pm functions as __maybe_unused
      drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
      Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
      KVM: add X86_LOCAL_APIC dependency
      tc358743: fix register i2c_rd/wr functions
      go7007: add MEDIA_CAMERA_SUPPORT dependency
      em28xx: only use mt9v011 if camera support is enabled
      tw5864: use dev_warn instead of WARN to shut up warning
      ISDN: eicon: reduce stack size of sig_ind function
      kasan: rework Kconfig settings
      drm/i915: hide unused intel_panel_set_backlight function
      arm64: sunxi: always enable reset controller
      binfmt_elf: compat: avoid unused function warning
      spi: bcm-qspi: shut up warning about cfi header inclusion
      idle: i7300: add PCI dependency
      arm64: fix warning about swapper_pg_dir overflow
      usb: phy: msm add regulator dependency

Augusto Mecking Caringi (1):
      gpio: intel-mid: Fix build warning when !CONFIG_PM

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Borislav Petkov (4):
      PCI: vmd: Fix suspend handlers defined-but-not-used warning
      platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
      x86/ras/inject: Make it depend on X86_LOCAL_APIC=3Dy
      x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix=
 preemptibility bug

Branislav Radocaj (1):
      net: ethernet: arc: fix error handling in emac_rockchip_probe

Cai Li (1):
      clk: fix a panic error caused by accessing NULL pointer

Chris Wilson (1):
      drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Christophe JAILLET (1):
      dmaengine: ioat: Fix error handling path

Claudiu Manoil (1):
      gianfar: Disable EEE autoneg by default

Cong Wang (3):
      xfrm: check id proto in validate_tmpl()
      netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dave Young (1):
      mm/early_ioremap: Fix boot hang with earlyprintk=3Defi,keep

David Howells (1):
      Provide a function to create a NUL-terminated string from unterminate=
d data

Dmitry Vyukov (3):
      kcov: detect double association with a single task
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Douglas Gilbert (1):
      blk_rq_map_user_iov: fix error override

Eric Biggers (5):
      crypto: x86/twofish-3way - Fix %rbp usage
      crypto: hash - annotate algorithms taking optional key
      crypto: hash - prevent using keyed hashes without setting key
      binder: check for binder_thread allocation failure in binder_poll()
      509: fix printing uninitialized stack memory when OID is empty

Eric Dumazet (1):
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{ma=
tch|target}

Florian Westphal (1):
      xfrm: skip policies marked as dead while rehashing

Gao Feng (1):
      ipvlan: Add the skb->mark as flow4's member to lookup route

Greg Kroah-Hartman (1):
      Linux 4.9.84

Greg Ungerer (1):
      m68k: add missing SOFTIRQENTRY_TEXT linker section

Gustavo A. R. Silva (1):
      dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_pr=
ep_dma_interleaved

Ilya Dryomov (1):
      rbd: silence bogus -Wmaybe-uninitialized warning

Jan Beulich (1):
      xen: XEN_ACPI_PROCESSOR is Dom0-only

Jan Dakinevich (2):
      KVM: VMX: clean up declaration of VPID/EPT invalidation types
      KVM: nVMX: invvpid handling improvements

Jason Wang (2):
      vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()
      ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE

Jens Axboe (1):
      blktrace: fix unlocked registration of tracepoints

Jia-Ju Bai (1):
      hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jiri Olsa (1):
      perf top: Fix window dimensions change handling

Johannes Berg (1):
      cfg80211: check dev_set_name() return value

Josh Poimboeuf (1):
      tools build: Add tools tree support for 'make -s'

Jun Nie (1):
      dmaengine: zx: fix build warning

J=E9r=E9my Lefaure (2):
      usb: musb: fix compilation warning on unused function
      shmem: fix compilation warnings on unused functions

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Karol Herbst (1):
      x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Keerthy (1):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Kefeng Wang (1):
      arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set

Kirill A. Shutemov (1):
      x86/vm86: Fix unused variable warning if THP is disabled

LEROY Christophe (1):
      crypto: talitos - fix Kernel Oops on hashing an empty file

Laura Abbott (2):
      staging: android: ion: Add __GFP_NOWARN for system contig heap
      staging: android: ion: Switch from WARN to pr_warn

Marc Gonzalez (1):
      PCI: Change pci_host_common_probe() visibility

Mauro Carvalho Chehab (1):
      media: s5k6aa: describe some function parameters

Michael Ellerman (1):
      powerpc/64s: Fix conversion of slb_miss_common to use RFI_TO_USER/KER=
NEL

Moni Shoua (1):
      RDMA/cma: Make sure that PSN is not over max allowed

Mustafa Ismail (1):
      i40iw: Correct ARP index mask

Nicholas Piggin (2):
      powerpc/64s: Simple RFI macro conversions
      powerpc/64s: Improve RFI L1-D cache flush fallback

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel (2):
      net_sched: red: Avoid devision by zero
      net_sched: red: Avoid illegal values

Pali Roh=E1r (1):
      platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitud=
e E6410

Paolo Abeni (2):
      netfilter: on sockopt() acquire sock lock only in the required scope
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Paul Moore (2):
      selinux: ensure the context is NUL terminated in security_context_to_=
sid_core()
      selinux: skip bounded transition processing if the policy isn't loaded

Peter Ujfalusi (2):
      ARM: dts: am4372: Correct the interrupts_properties of McASP
      ARM: dts: am437x-cm-t43: Correct the dmas property of spi0

Randy Dunlap (1):
      usb: build drivers/usb/common/ when USB_SUPPORT is set

Ravi Bangoria (1):
      powerpc/perf: Fix oops when grouping different pmu events

Russell King (1):
      drm/armada: fix leak of crtc structure

Satheesh Rajendran (1):
      perf bench numa: Fixup discontiguous/sparse numa nodes

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Sowmini Varadhan (1):
      rds: tcp: atomically purge entries from rds_tcp_conn_list during netn=
s delete

Stefan Haberland (1):
      s390/dasd: prevent prefix I/O error

Stefan Potyra (1):
      ASoC: rockchip: disable clock on error

Steffen Klassert (2):
      xfrm: Fix stack-out-of-bounds read on socket policy lookup.
      xfrm: Fix stack-out-of-bounds with misconfigured transport mode polic=
ies.

Stephen Boyd (1):
      perf: xgene: Include module.h

Takuo Koguchi (1):
      spi: sun4i: disable clocks in the remove function

Tetsuo Handa (1):
      mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() fa=
iled.

Tobias Jordan (1):
      dmaengine: jz4740: disable/unprepare clk if probe fails

Tobias Regnery (2):
      clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER
      clk: meson: gxbb: fix build error without RESET_CONTROLLER

Tom Herbert (2):
      kcm: Check if sk_user_data already set in kcm_attach
      kcm: Only allow TCP sockets to be attached to a KCM mux

Tony Lindgren (3):
      ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_co=
ntext
      ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen
      ARM: dts: Fix elm interrupt compiler warning

Vincent Pelletier (1):
      usb: dwc3: gadget: Wait longer for controller to end command processi=
ng

Wanpeng Li (2):
      KVM: x86: fix escape of guest dr6 to the host
      KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Rea=
dy" exceptions simultaneously

Will Deacon (1):
      scripts/kernel-doc: Don't fail with status !=3D 0 if error encountere=
d with -none

Willem de Bruijn (1):
      net: avoid skb_warn_bad_offload on IS_ERR

Xin Long (2):
      sctp: set frag_point in sctp_setsockopt_maxseg correctly
      sctp: only update outstanding_bytes for transmitted queue when doing =
prsctp_prune

Zumeng Chen (1):
      gianfar: fix a flooded alignment reports because of padding issue.


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqSmUMACgkQONu9yGCS
aT43XQ//X9slPELykTwET8TB5QYs2EdZuOlaTMXIPMfCsHsx+bEScMzEc9mNTwZn
Y2nr148E3ubumSkoikYXyHHzEqcm/s0PtY89AU4wVQPbkXcgxOaHvgk0zcW/I5Jz
VzZghu6hziFkMKRy7hfatGGzUfo0xixHE/q8DPbD90Og6YKkTqaiAq7LCycjOLls
vAF1SFhfU58vKe86oSiR9i8QVuEq60utpyI8LDjyppZxFTkwTGi7g6xU/LWRNBfo
pDwF7Bb8tiHsxQFNamYrSQbEQGFN7Fl2GF830XA3RWtyUMFaw2N2Hq1Zr1Sew95b
hfuv2QK+PrRU5cCPjhxb2gl1vsbtzEb9vURMatYo/zRC1oii5NnRtQYHWmzIJ8s2
kb84ZrLZ72nueqv0xSwKabhbn4Dab4SNfizAv0dVYwNsWZDtxt9yYgmXLW0xvIpA
rRejl9sJhlR0VoSSEl0c1/FqdJeNJofRoedyiBpqcuO9SkrBRuPijfzn3jhOPE6Y
7XJgZ4njmJPQvmlBlselV+qP9I294yU2QaJgk/kdA5/WFDi+HjRzC4HO3r+4gC8j
1MghnNnko7uvuP2vqcvq1BTd95ZHSTZblSRwxhzNeSZEqF30NB9PVb3Fj84UWbL0
TKBuhGu6HcDqurVixCS8GRXlmMN2cwe+4SLuStobCAUs4EotwjM=
=msxd
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
