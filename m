Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3662072-1519556951-2-9109332634613486067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519556950; b=wrs9Cg1Zf7K4qElFqlBvrZcINb1zUXo9xA+rDGJoQrFySSi
    fnPKYJK/m/rw91aABEHrZ/DgwsuXViv7KZ4D1B1PnYEg3eb51ejdUytN6H70kGI8
    w0zM6NodAw89XFKi5IJIhQbYeJ8+rCeI8xl1mJniz2lNM+X89zX5wDPMDVKHczJK
    FLUPrZt+UR6zMBNSLJ2t2wNEUvIwycqP6HeNFAY4n/B0/1+j153ip7y7fJES0Gs6
    bM/90u3lyQ4P9sJdvXW1TmRzX0xhphZG8e1PRA0o5HfBiPmKsaHxvcs0zCsWPeQ0
    zv2WzptgBMXO6Zb9qu9l3m+YG+fCfCSzEIjVJfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519556950; bh=Q3azM+lGtgbEkl1uz9Yn6VOo+aCsMfMCQkOPLzLLanc=; b=d
    Yv/a77WBW4yVa2fyd8L1UV2xuNYrf8S87Cfb1haFtPFkbAFx7+E1UVJqnYclxP0e
    p+hgGZLzj2I1IqLC91lfhZ99TeuLBK8zGth33yCQgMX711RfJOrs+Sfy0OTbIjyn
    PMXZK4M0FG87De/pLNgRn6DLbNp0N1qtHGeEtAdFT6nhlA9/Ev/jNfQ7a6Dx2FNM
    Rn/jb1ZUEBs+PcX3J5/Wj9NrsaVJgmgKEOulpbCNFi7hvsxwG9I1MJS/bBvoZ+z0
    9gAGqAvO5Q9d5iJhMjL/aLF/Yj9f2BkgpPslLegPNFESzh/Ub+a8nnAh/hXqUBAQ
    VS6N5f/2zKGKNnIHqAk7g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeBYLIw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 06:08:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbeBYLIi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 06:08:38 -0500
Date: Sun, 25 Feb 2018 12:08:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.118
Message-ID: <20180225110831.GA21576@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.118 kernel.

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

 Documentation/kernel-parameters.txt                 |    2=20
 Documentation/speculation.txt                       |   90 +
 Makefile                                            |    8=20
 arch/arm/boot/dts/am4372.dtsi                       |    6=20
 arch/arm/boot/dts/omap4.dtsi                        |    2=20
 arch/arm/mach-omap2/omap-secure.c                   |   19=20
 arch/arm/mach-omap2/omap-secure.h                   |    4=20
 arch/arm/mach-omap2/pm.h                            |    4=20
 arch/arm/mach-omap2/pm34xx.c                        |   13=20
 arch/arm/mach-omap2/prm33xx.c                       |   12=20
 arch/arm/mach-omap2/sleep34xx.S                     |   26=20
 arch/arm/mach-tegra/Kconfig                         |    2=20
 arch/arm64/Kconfig                                  |    2=20
 arch/arm64/Kconfig.platforms                        |    2=20
 arch/arm64/boot/dts/mediatek/mt8173.dtsi            |    2=20
 arch/arm64/include/asm/bug.h                        |   33=20
 arch/powerpc/perf/core-book3s.c                     |    4=20
 arch/x86/Kconfig                                    |    2=20
 arch/x86/Kconfig.debug                              |    1=20
 arch/x86/boot/Makefile                              |    5=20
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S        |  112 -
 arch/x86/entry/common.c                             |    2=20
 arch/x86/include/asm/asm-prototypes.h               |    1=20
 arch/x86/include/asm/barrier.h                      |   28=20
 arch/x86/include/asm/microcode_amd.h                |    1=20
 arch/x86/include/asm/msr.h                          |    3=20
 arch/x86/include/asm/nospec-branch.h                |    8=20
 arch/x86/include/asm/vmx.h                          |    5=20
 arch/x86/kernel/alternative.c                       |   14=20
 arch/x86/kernel/cpu/bugs.c                          |  122 +
 arch/x86/kernel/cpu/mcheck/mce-inject.c             |    5=20
 arch/x86/kernel/cpu/microcode/amd.c                 |   17=20
 arch/x86/kernel/cpu/perf_event.c                    |    4=20
 arch/x86/kernel/head_32.S                           |    9=20
 arch/x86/kvm/Kconfig                                |    3=20
 arch/x86/kvm/emulate.c                              |    9=20
 arch/x86/kvm/vmx.c                                  |   83=20
 arch/x86/kvm/x86.c                                  |   40=20
 arch/x86/lib/getuser.S                              |   10=20
 arch/x86/lib/retpoline.S                            |    1=20
 arch/x86/math-emu/Makefile                          |    4=20
 arch/x86/math-emu/reg_compare.c                     |   16=20
 arch/x86/mm/ioremap.c                               |    4=20
 arch/x86/mm/kmmio.c                                 |   12=20
 arch/x86/platform/olpc/olpc-xo15-sci.c              |    2=20
 certs/Makefile                                      |   33=20
 drivers/Makefile                                    |    1=20
 drivers/android/binder.c                            |    2=20
 drivers/char/hw_random/exynos-rng.c                 |   10=20
 drivers/crypto/s5p-sss.c                            |   13=20
 drivers/dma/at_hdmac.c                              |    4=20
 drivers/dma/dma-jz4740.c                            |    4=20
 drivers/dma/ioat/init.c                             |    2=20
 drivers/dma/zx296702_dma.c                          |    2=20
 drivers/gpio/gpio-intel-mid.c                       |    2=20
 drivers/gpio/gpio-xgene.c                           |   13=20
 drivers/gpu/drm/armada/armada_crtc.c                |   25=20
 drivers/gpu/drm/drm_modeset_lock.c                  |    2=20
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c              |   10=20
 drivers/gpu/drm/gma500/mdfld_dsi_output.c           |   12=20
 drivers/gpu/drm/nouveau/nouveau_gem.c               |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c              |    7=20
 drivers/hv/hv.c                                     |    5=20
 drivers/i2c/i2c-boardinfo.c                         |    4=20
 drivers/idle/Kconfig                                |    1=20
 drivers/iio/adc/axp288_adc.c                        |    2=20
 drivers/infiniband/core/cma.c                       |    1=20
 drivers/infiniband/hw/cxgb4/device.c                |    5=20
 drivers/input/keyboard/tca8418_keypad.c             |   21=20
 drivers/isdn/hardware/eicon/message.c               |   16=20
 drivers/isdn/icn/icn.c                              |    2=20
 drivers/isdn/sc/init.c                              |    7=20
 drivers/md/md.c                                     |   10=20
 drivers/media/common/b2c2/flexcop-fe-tuner.c        |    4=20
 drivers/media/i2c/s5k6aa.c                          |    5=20
 drivers/media/i2c/tc358743.c                        |   46=20
 drivers/media/usb/em28xx/Kconfig                    |    2=20
 drivers/media/usb/go7007/Kconfig                    |    2=20
 drivers/media/usb/hdpvr/hdpvr-core.c                |    2=20
 drivers/media/usb/pwc/pwc-if.c                      |    2=20
 drivers/media/v4l2-core/Kconfig                     |    1=20
 drivers/message/fusion/mptbase.c                    |    2=20
 drivers/mtd/chips/Kconfig                           |    4=20
 drivers/mtd/maps/ck804xrom.c                        |    4=20
 drivers/mtd/maps/esb2rom.c                          |    4=20
 drivers/mtd/maps/ichxrom.c                          |   10=20
 drivers/mtd/nand/sh_flctl.c                         |    5=20
 drivers/net/Kconfig                                 |    3=20
 drivers/net/ethernet/3com/3c509.c                   |    2=20
 drivers/net/ethernet/3com/3c59x.c                   |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-main.c           |    4=20
 drivers/net/ethernet/dec/tulip/de4x5.c              |    2=20
 drivers/net/ethernet/freescale/gianfar.c            |    6=20
 drivers/net/ethernet/hp/hp100.c                     |   20=20
 drivers/net/ethernet/ti/tlan.c                      |    2=20
 drivers/net/hippi/rrunner.c                         |    2=20
 drivers/net/ipvlan/ipvlan_core.c                    |    1=20
 drivers/net/usb/Kconfig                             |   10=20
 drivers/net/usb/Makefile                            |    2=20
 drivers/net/wireless/cw1200/cw1200_spi.c            |    9=20
 drivers/net/wireless/cw1200/pm.h                    |    9=20
 drivers/net/wireless/cw1200/wsm.c                   |    8=20
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c |    6=20
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c           |    6=20
 drivers/platform/x86/Kconfig                        |    2=20
 drivers/platform/x86/intel_mid_thermal.c            |    2=20
 drivers/platform/x86/tc1100-wmi.c                   |    2=20
 drivers/power/Kconfig                               |    1=20
 drivers/power/bq27xxx_battery.c                     |    6=20
 drivers/s390/block/dasd_eckd.c                      |   16=20
 drivers/scsi/advansys.c                             |   24=20
 drivers/scsi/dpt_i2o.c                              |    3=20
 drivers/scsi/fdomain.c                              |    2=20
 drivers/scsi/g_NCR5380.c                            |    5=20
 drivers/scsi/initio.c                               |   16=20
 drivers/scsi/mvumi.c                                |    4=20
 drivers/scsi/sim710.c                               |    3=20
 drivers/spi/spi-sun4i.c                             |    2=20
 drivers/ssb/main.c                                  |    7=20
 drivers/staging/android/ashmem.c                    |   19=20
 drivers/staging/iio/adc/ad7192.c                    |   27=20
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c       |    7=20
 drivers/staging/unisys/visorinput/Kconfig           |    2=20
 drivers/staging/wilc1000/wilc_wlan_if.h             |    1=20
 drivers/target/target_core_user.c                   |    2=20
 drivers/thermal/Kconfig                             |    4=20
 drivers/thermal/spear_thermal.c                     |    6=20
 drivers/tty/Kconfig                                 |    2=20
 drivers/tty/hvc/hvc_xen.c                           |    2=20
 drivers/tty/serial/8250/Kconfig                     |    2=20
 drivers/usb/host/Kconfig                            |    2=20
 drivers/usb/musb/ux500_dma.c                        |    3=20
 drivers/usb/phy/Kconfig                             |    1=20
 drivers/usb/usbip/stub_dev.c                        |    3=20
 drivers/usb/usbip/vhci_hcd.c                        |    2=20
 drivers/video/fbdev/Kconfig                         |    1=20
 drivers/video/fbdev/auo_k190x.c                     |   11=20
 drivers/video/fbdev/exynos/s6e8ax0.c                |   13=20
 drivers/video/fbdev/intelfb/intelfbdrv.c            |    2=20
 drivers/video/fbdev/mmp/core.c                      |    5=20
 drivers/video/fbdev/sis/init301.c                   |   10=20
 drivers/video/fbdev/sm712fb.c                       |   16=20
 drivers/video/fbdev/via/viafbdev.c                  |    8=20
 drivers/virtio/virtio_balloon.c                     |    2=20
 drivers/xen/Kconfig                                 |    2=20
 fs/btrfs/ioctl.c                                    |    2=20
 fs/compat_binfmt_elf.c                              |    2=20
 fs/ncpfs/dir.c                                      |    3=20
 fs/reiserfs/lbalance.c                              |    2=20
 fs/reiserfs/reiserfs.h                              |    1=20
 include/linux/device.h                              |    7=20
 include/linux/fdtable.h                             |    5=20
 include/linux/init.h                                |    9=20
 include/linux/module.h                              |    9=20
 include/linux/msi.h                                 |   11=20
 include/linux/mtd/sh_flctl.h                        |    1=20
 include/linux/nospec.h                              |   72=20
 include/linux/string.h                              |    1=20
 include/net/dst_cache.h                             |   97 +
 include/net/ip6_tunnel.h                            |   15=20
 include/net/netlink.h                               |   73=20
 include/net/red.h                                   |   13=20
 include/trace/events/clk.h                          |    4=20
 kernel/module.c                                     |   11=20
 kernel/profile.c                                    |    4=20
 kernel/trace/blktrace.c                             |   32=20
 lib/Kconfig.debug                                   |    2=20
 lib/oid_registry.c                                  |    8=20
 mm/early_ioremap.c                                  |    2=20
 mm/util.c                                           |   24=20
 mm/vmscan.c                                         |    3=20
 net/Kconfig                                         |    4=20
 net/core/Makefile                                   |    1=20
 net/core/dev.c                                      |    2=20
 net/core/dst_cache.c                                |  168 +
 net/decnet/af_decnet.c                              |   62=20
 net/ipv4/ip_sockglue.c                              |   14=20
 net/ipv4/ipconfig.c                                 |    4=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                  |   16=20
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c      |    6=20
 net/ipv6/Kconfig                                    |    1=20
 net/ipv6/ip6_gre.c                                  |   12=20
 net/ipv6/ip6_tunnel.c                               |  149 -
 net/ipv6/ip6_vti.c                                  |    2=20
 net/ipv6/ipv6_sockglue.c                            |   17=20
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c      |   18=20
 net/netfilter/ipvs/ip_vs_app.c                      |    8=20
 net/netfilter/ipvs/ip_vs_ctl.c                      |   15=20
 net/netfilter/x_tables.c                            |   10=20
 net/netfilter/xt_RATEEST.c                          |   22=20
 net/sched/sch_choke.c                               |    3=20
 net/sched/sch_gred.c                                |    3=20
 net/sched/sch_red.c                                 |    2=20
 net/sched/sch_sfq.c                                 |    3=20
 net/wireless/core.c                                 |    8=20
 net/wireless/nl80211.c                              |    9=20
 net/xfrm/xfrm_policy.c                              |    8=20
 net/xfrm/xfrm_user.c                                |   24=20
 scripts/genksyms/parse.tab.c_shipped                | 1682 +++++++++------=
-----
 scripts/genksyms/parse.tab.h_shipped                |  133 -
 scripts/genksyms/parse.y                            |    2=20
 scripts/kernel-doc                                  |    2=20
 scripts/mod/modpost.c                               |    9=20
 security/selinux/ss/services.c                      |   21=20
 sound/pci/hda/patch_ca0132.c                        |    3=20
 sound/soc/intel/Kconfig                             |    7=20
 sound/soc/mediatek/Kconfig                          |    4=20
 sound/soc/rockchip/rockchip_spdif.c                 |   22=20
 sound/soc/ux500/mop500.c                            |    4=20
 sound/soc/ux500/ux500_pcm.c                         |    5=20
 tools/build/Makefile.build                          |   10=20
 tools/perf/bench/numa.c                             |   56=20
 tools/perf/builtin-top.c                            |   15=20
 tools/scripts/Makefile.include                      |   12=20
 214 files changed, 2527 insertions(+), 1873 deletions(-)

Alexandru Ardelean (1):
      staging: iio: adc: ad7192: fix external frequency setting

Andi Kleen (1):
      module/retpoline: Warn about missing retpoline in module

Andre Przywara (1):
      pinctrl: sunxi: Fix A80 interrupt pin bank

Andy Lutomirski (1):
      dell-wmi, dell-laptop: depends DMI

Arnd Bergmann (76):
      ASoC: ux500: add MODULE_LICENSE tag
      video: fbdev/mmp: add MODULE_LICENSE
      arm64: dts: add #cooling-cells to CPU nodes
      virtio_balloon: prevent uninitialized variable use
      isdn: icn: remove a #warning
      vmxnet3: prevent building with 64K pages
      video: fbdev: via: remove possibly unused variables
      scsi: advansys: fix build warning for PCI=3Dn
      arm64: define BUG() instruction without CONFIG_BUG
      x86/fpu/math-emu: Fix possible uninitialized variable use
      x86/build: Silence the build with "make -s"
      thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies
      x86: add MULTIUSER dependency for KVM
      x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG
      scsi: advansys: fix uninitialized data access
      ALSA: hda/ca0132 - fix possible NULL pointer use
      reiserfs: avoid a -Wmaybe-uninitialized warning
      ssb: mark ssb_bus_register as __maybe_unused
      thermal: spear: use __maybe_unused for PM functions
      x86/boot: Avoid warning for zero-filling .bss
      profile: hide unused functions when !CONFIG_PROC_FS
      md: avoid warning for 32-bit sector_t
      mtd: ichxrom: maybe-uninitialized with gcc-4.9
      mptfusion: hide unused seq_mpt_print_ioc_summary function
      scsi: fdomain: drop fdomain_pci_tbl when built-in
      staging: ste_rmi4: avoid unused function warnings
      fbdev: sis: enforce selection of at least one backend
      scsi: mvumi: use __maybe_unused to hide pm functions
      SCSI: initio: remove duplicate module device table
      pwc: hide unused label
      usb: musb/ux500: remove duplicate check for dma_is_compatible
      tty: hvc_xen: hide xen_console_remove when unused
      target/user: Fix cast from pointer to phys_addr_t
      driver-core: use 'dev' argument in dev_dbg_ratelimited stub
      fbdev: auo_k190x: avoid unused function warnings
      mtd: sh_flctl: pass FIFO as physical address
      mtd: cfi: enforce valid geometry configuration
      fbdev: s6e8ax0: avoid unused function warnings
      modsign: hide openssl output in silent builds
      fbdev: sm712fb: avoid unused function warnings
      hwrng: exynos - use __maybe_unused to hide pm functions
      USB: cdc_subset: only build when one driver is enabled
      rtlwifi: fix gcc-6 indentation warning
      netfilter: ipvs: avoid unused variable warnings
      ipv4: ipconfig: avoid unused ic_proto_used symbol
      tlan: avoid unused label with PCI=3Dn
      tty: cyclades: cyz_interrupt is only used for PCI
      genirq/msi: Add stubs for get_cached_msi_msg/pci_write_msi_msg
      ASoC: mediatek: add i2c dependency
      infiniband: cxgb4: use %pR format string for printing resources
      b2c2: flexcop: avoid unused function warnings
      tc358743: fix register i2c_rd/wr functions
      drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
      Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning
      KVM: add X86_LOCAL_APIC dependency
      go7007: add MEDIA_CAMERA_SUPPORT dependency
      em28xx: only use mt9v011 if camera support is enabled
      ISDN: eicon: reduce stack size of sig_ind function
      ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume
      hdpvr: hide unused variable
      v4l: remove MEDIA_TUNER dependency for VIDEO_TUNER
      cw1200: fix bogus maybe-uninitialized warning
      wireless: cw1200: use __maybe_unused to hide pm functions_
      perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
      net: hp100: remove unnecessary #ifdefs
      gpio: xgene: mark PM functions as __maybe_unused
      Revert "power: bq27xxx_battery: Remove unneeded dependency in Kconfig"
      power: bq27xxx_battery: mark some symbols __maybe_unused
      isdn: sc: work around type mismatch warning
      binfmt_elf: compat: avoid unused function warning
      idle: i7300: add PCI dependency
      usb: phy: msm add regulator dependency
      ncr5380: shut up gcc indentation warning
      ARM: tegra: select USB_ULPI from EHCI rather than platform
      netlink: fix nla_put_{u8,u16,u32} for KASAN
      kasan: rework Kconfig settings

Augusto Mecking Caringi (1):
      gpio: intel-mid: Fix build warning when !CONFIG_PM

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Borislav Petkov (7):
      platform/x86: intel_mid_thermal: Fix suspend handlers unused warning
      x86/ras/inject: Make it depend on X86_LOCAL_APIC=3Dy
      amd-xgbe: Fix unused suspend handlers build warning
      x86/platform/olpc: Fix resume handler build warning
      x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix=
 preemptibility bug
      x86/nospec: Fix header guards names
      x86/bugs: Drop one "mitigation" from dmesg

Cai Li (1):
      clk: fix a panic error caused by accessing NULL pointer

Chris Wilson (1):
      drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Christophe JAILLET (1):
      dmaengine: ioat: Fix error handling path

Colin Ian King (3):
      tc1100-wmi: fix build warning when CONFIG_PM not enabled
      iio: adc: axp288: remove redundant duplicate const on axp288_adc_chan=
nels
      x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Cong Wang (2):
      xfrm: check id proto in validate_tmpl()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dan Williams (9):
      array_index_nospec: Sanitize speculative array de-references
      x86: Implement array_index_mask_nospec
      x86: Introduce barrier_nospec
      x86/get_user: Use pointer masking to limit speculation
      x86/syscall: Sanitize syscall table de-references under speculation
      vfs, fdtable: Prevent bounds-check bypass via speculative execution
      nl80211: Sanitize array index in parse_txq_params
      x86/spectre: Report get_user mitigation for spectre_v1
      x86/kvm: Update spectre-v1 mitigation

Daniel Wagner (1):
      video: Use bool instead int pointer for get_opt_bool() argument

Darren Kenny (1):
      x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

Dave Jones (1):
      Make DST_CACHE a silent config option

Dave Young (1):
      mm/early_ioremap: Fix boot hang with earlyprintk=3Defi,keep

David Hildenbrand (2):
      KVM: nVMX: kmap() can't fail
      KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail

David Howells (1):
      Provide a function to create a NUL-terminated string from unterminate=
d data

David Woodhouse (1):
      x86/retpoline: Avoid retpolines for built-in __init functions

Dmitry Vyukov (2):
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Dou Liyang (1):
      x86/spectre: Check CONFIG_RETPOLINE in command line parser

Eric Biggers (3):
      crypto: x86/twofish-3way - Fix %rbp usage
      binder: check for binder_thread allocation failure in binder_poll()
      509: fix printing uninitialized stack memory when OID is empty

Eric Dumazet (1):
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{ma=
tch|target}

Fabian Frederick (1):
      drivers/net: fix eisa_driver probe section mismatch

Gao Feng (1):
      ipvlan: Add the skb->mark as flow4's member to lookup route

Glen Lee (1):
      staging: wilc1000: fix kbuild test robot error

Greg Kroah-Hartman (1):
      Linux 4.4.118

Gustavo A. R. Silva (1):
      dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_pr=
ep_dma_interleaved

Heikki Krogerus (1):
      serial: 8250_mid: fix broken DMA dependency

Jan Beulich (1):
      xen: XEN_ACPI_PROCESSOR is Dom0-only

Jan Dakinevich (2):
      KVM: VMX: clean up declaration of VPID/EPT invalidation types
      KVM: nVMX: invvpid handling improvements

Jens Axboe (1):
      blktrace: fix unlocked registration of tracepoints

Jia-Ju Bai (1):
      hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jim Mattson (1):
      kvm: nVMX: Fix kernel panics induced by illegal INVEPT/INVVPID types

Jiri Olsa (1):
      perf top: Fix window dimensions change handling

Johannes Berg (1):
      cfg80211: check dev_set_name() return value

Josh Poimboeuf (2):
      tools build: Add tools tree support for 'make -s'
      x86/paravirt: Remove 'noreplace-paravirt' cmdline option

Julia Lawall (1):
      mtd: maps: add __init attribute

Jun Nie (1):
      dmaengine: zx: fix build warning

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

KarimAllah Ahmed (1):
      x86/spectre: Simplify spectre_v2 command line parsing

Karol Herbst (1):
      x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Keerthy (1):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Kefeng Wang (1):
      arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set

Luis R. Rodriguez (1):
      i2c: remove __init from i2c_register_board_info()

Mark Rutland (1):
      Documentation: Document array_index_nospec

Mauro Carvalho Chehab (1):
      media: s5k6aa: describe some function parameters

Michal Marek (1):
      genksyms: Fix segfault with invalid declarations

Miklos Szeredi (1):
      ncpfs: fix unused variable warning

Moni Shoua (1):
      RDMA/cma: Make sure that PSN is not over max allowed

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel (2):
      net_sched: red: Avoid devision by zero
      net_sched: red: Avoid illegal values

Paolo Abeni (4):
      net: add dst_cache support
      net: replace dst_cache ip6_tunnel implementation with the generic one
      netfilter: on sockopt() acquire sock lock only in the required scope
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Paul Bolle (1):
      drm/vmwgfx: use *_32_bits() macros

Paul Moore (2):
      selinux: ensure the context is NUL terminated in security_context_to_=
sid_core()
      selinux: skip bounded transition processing if the policy isn't loaded

Peter Ujfalusi (1):
      ARM: dts: am4372: Correct the interrupts_properties of McASP

Peter Zijlstra (2):
      KVM: x86: Make indirect calls in emulator speculation safe
      KVM: VMX: Make indirect call speculation safe

Randy Dunlap (2):
      usb: build drivers/usb/common/ when USB_SUPPORT is set
      staging: unisys: visorinput depends on INPUT

Ravi Bangoria (1):
      powerpc/perf: Fix oops when grouping different pmu events

Russell King (1):
      drm/armada: fix leak of crtc structure

Satheesh Rajendran (1):
      perf bench numa: Fixup discontiguous/sparse numa nodes

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Stefan Haberland (1):
      s390/dasd: prevent prefix I/O error

Stefan Potyra (1):
      ASoC: rockchip: disable clock on error

Steffen Klassert (2):
      xfrm: Fix stack-out-of-bounds read on socket policy lookup.
      xfrm: Fix stack-out-of-bounds with misconfigured transport mode polic=
ies.

Sudip Mukherjee (5):
      scsi: sim710: fix build warning
      dpt_i2o: fix build warning
      video: fbdev: sis: remove unused variable
      Drivers: hv: vmbus: fix build warning
      drm/gma500: remove helper function

Takuo Koguchi (1):
      spi: sun4i: disable clocks in the remove function

Tetsuo Handa (1):
      mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() fa=
iled.

Thierry Reding (1):
      drm/gma500: Sanity-check pipe index

Thomas Gleixner (1):
      x86/cpu/bugs: Make retpoline module warning conditional

Tobias Jordan (1):
      dmaengine: jz4740: disable/unprepare clk if probe fails

Tony Lindgren (2):
      ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_co=
ntext
      ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen

Vinod Koul (1):
      ASoC: Intel: Kconfig: fix build when ACPI is not enabled

Waiman Long (1):
      x86/retpoline: Remove the esp/rsp thunk

Wanpeng Li (2):
      KVM: x86: fix escape of guest dr6 to the host
      KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Rea=
dy" exceptions simultaneously

Will Deacon (1):
      scripts/kernel-doc: Don't fail with status !=3D 0 if error encountere=
d with -none

Willem de Bruijn (1):
      net: avoid skb_warn_bad_offload on IS_ERR

Wu Fengguang (1):
      net: dst_cache_per_cpu_dst_set() can be static

Zumeng Chen (1):
      gianfar: fix a flooded alignment reports because of padding issue.


--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqSmS4ACgkQONu9yGCS
aT7cVhAA1yyWVXjAZCWsIX/2KG6+IdYdvZsOGJW9/5vRCWwlE0vaeTlY750xBfsp
Evwc3wYuVUl+SLJMeouzM/WPQ5QlssMuyxORC5YNYzx+58wHnQZX3eeXDVXbwtzd
GKQ30tzQlVpjyaztjSituXVk+RyFMdlG/wM1Yzfr/AjxCNk1TPmiQgTc+GD0Rt1Z
DBWc0KgUXYUXt9bX7S5Kvsg0QHywaiIpoPbVLp35tf35PSXU5IGAv3uf+vzUdxB0
keJv6oD0F3SQGPTTxmt6MxzFfGkQiWnYJJZ2OnzFDsj2xzZV+zlhL4tnJdhpBq49
79pxEtr9TIaB7wQamg0hQ/bhLjO39xBEuB/uqnoUjLVjVNHJV4UlM/5DflIa7VA4
wqSo3eYgIc34ybVq+tGDVdn7nejiBSiPapC0nNiN+AuZBqxDo5l+o/w4VtqrZG9i
nME18uHrpMLU4Q4LUpK3Anb8BOPzWdD46j35yV7yKT5bRYyAMI20bn201Eywd9j5
n2oPUPi4FnkUvOP8N06OWCBQE8/ZeiHrsAmG+Ljloq/dj0LeFcpr/QsiGbTjGDen
nB6ScvsVpTlFGOUTDWGRdlX4bqXb4Tts8EuebEb5PAsR03GyPjSXnaw2RAqrgjQ6
yT9gHuR9LqONfRDJakNYV4S86VIzNMveXIj0sukqNm4SOCTcH44=
=K0x2
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
