Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252784-1519371372-5-9327686960334695768
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519371363; b=ZqEKcO29vbPBSmPv+HOZLTpR72DW83iFYujwwMCXSNGMTxU
    bOsyw7erxjWsbHdsol6av3BgzohkvJAkU/TBUllTGRhVK8EI33NnZvqPCvkmI4PL
    2mbMvuDdhv4Vd9xTLNv5XLCZfem2Pf4cqikCsw+574LOTyLgIC+s3ZX8ZyugScQ+
    61Y1T2t25FxXo3UXiyKU+HHH4CE2F/J2rLmdrJnQBoLat6rHzNC1ZhFWe42g7Nor
    EFwzbTPrL3tuYLB8nGx8FjniZpAgLC8Npm/m1ST9BP9XF6dXMm6mhavsnf0j36P9
    MsWXKW4+pFV2MpFRzhrRnVqqcsY+yUNp/D79UQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519371363; bh=6xKE1a/PZ1indhHG0luTVaYtFd+JuLLyY+Zgd45AwyA=; b=q
    SUhCe6uHwFEBethGT+kaC31MZDQ6oWkVGm0EYTN9PiBCreNf7mh8mzI7U7K5BIAh
    ZfjgEde2Dx1rhJYN21uMMvp2dBqAcoza0d67trkcCPcsH00ORCm2YySLkbGZuxpH
    pY0KmM0+tt0BNJtjNGTt3rLeMQ0zT28bPrH28GkhsAw+XgOvOrtrhyxAOVdg86DQ
    Nrun1WJeuvc22Lahh93lDpbIhhpGCs5davx6a28HcyAZKcmNgHlpsvNtf38WEyr6
    hIPAimUGzkboiwor/ZsXzLHmC4bqysp45UCIh3Xmcp0DcRUb5GvzZ7QrWJoJHyMM
    p7gJuCXWdhZNXLeR2bHdQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbeBWHdx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:33:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeBWHdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:33:52 -0500
Date: Fri, 23 Feb 2018 08:33:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.21
Message-ID: <20180223073351.GA12876@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.21 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/admin-guide/kernel-parameters.txt     |    7=20
 Documentation/dev-tools/index.rst                   |    1=20
 Documentation/dev-tools/kmemcheck.rst               |  733 ---------------=
-----
 Documentation/devicetree/bindings/dma/snps-dma.txt  |    2=20
 Documentation/filesystems/ext4.txt                  |    2=20
 MAINTAINERS                                         |   10=20
 Makefile                                            |    2=20
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi           |    5=20
 arch/arm/boot/dts/exynos5410.dtsi                   |    1=20
 arch/arm/boot/dts/lpc3250-ea3250.dts                |    4=20
 arch/arm/boot/dts/lpc3250-phy3250.dts               |    4=20
 arch/arm/boot/dts/mt2701.dtsi                       |    2=20
 arch/arm/boot/dts/mt7623.dtsi                       |    1=20
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts       |    2=20
 arch/arm/boot/dts/s5pv210.dtsi                      |    1=20
 arch/arm/boot/dts/spear1310-evb.dts                 |    2=20
 arch/arm/boot/dts/spear1340.dtsi                    |    4=20
 arch/arm/boot/dts/spear13xx.dtsi                    |    6=20
 arch/arm/boot/dts/spear600.dtsi                     |    1=20
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi          |    1=20
 arch/arm/boot/dts/stih407.dtsi                      |    3=20
 arch/arm/boot/dts/stih410.dtsi                      |    3=20
 arch/arm/include/asm/dma-iommu.h                    |    1=20
 arch/arm/include/asm/pgalloc.h                      |    2=20
 arch/arm/mach-pxa/tosa-bt.c                         |    4=20
 arch/arm64/boot/dts/qcom/msm8916.dtsi               |    5=20
 arch/arm64/include/asm/pgalloc.h                    |    2=20
 arch/arm64/kernel/cpu_errata.c                      |    9=20
 arch/arm64/kvm/hyp/switch.c                         |    4=20
 arch/arm64/mm/proc.S                                |   14=20
 arch/mips/Kconfig                                   |   12=20
 arch/mips/kernel/setup.c                            |   16=20
 arch/openrisc/include/asm/dma-mapping.h             |    1=20
 arch/powerpc/include/asm/pgalloc.h                  |    2=20
 arch/powerpc/include/asm/topology.h                 |    5=20
 arch/powerpc/kernel/exceptions-64s.S                |    2=20
 arch/powerpc/kernel/head_32.S                       |    2=20
 arch/powerpc/mm/numa.c                              |    5=20
 arch/powerpc/mm/pgtable-radix.c                     |   95 ++
 arch/powerpc/mm/pgtable_64.c                        |    2=20
 arch/powerpc/mm/tlb-radix.c                         |    2=20
 arch/powerpc/platforms/pseries/hotplug-cpu.c        |    2=20
 arch/powerpc/sysdev/xive/spapr.c                    |   16=20
 arch/s390/kernel/compat_linux.c                     |    8=20
 arch/sh/kernel/dwarf.c                              |    4=20
 arch/sh/kernel/process.c                            |    2=20
 arch/sparc/mm/init_64.c                             |    4=20
 arch/unicore32/include/asm/pgalloc.h                |    2=20
 arch/x86/Kconfig                                    |    3=20
 arch/x86/Makefile                                   |    5=20
 arch/x86/entry/calling.h                            |  107 +-
 arch/x86/entry/entry_64.S                           |   92 --
 arch/x86/entry/entry_64_compat.S                    |   30=20
 arch/x86/events/intel/core.c                        |    2=20
 arch/x86/events/intel/lbr.c                         |    2=20
 arch/x86/events/intel/p6.c                          |    2=20
 arch/x86/include/asm/acpi.h                         |    2=20
 arch/x86/include/asm/barrier.h                      |    2=20
 arch/x86/include/asm/bug.h                          |   19=20
 arch/x86/include/asm/dma-mapping.h                  |    1=20
 arch/x86/include/asm/kmemcheck.h                    |   43 -
 arch/x86/include/asm/nospec-branch.h                |   14=20
 arch/x86/include/asm/page_64.h                      |    4=20
 arch/x86/include/asm/paravirt.h                     |    4=20
 arch/x86/include/asm/paravirt_types.h               |    2=20
 arch/x86/include/asm/pgtable.h                      |    5=20
 arch/x86/include/asm/pgtable_32.h                   |    2=20
 arch/x86/include/asm/pgtable_types.h                |   13=20
 arch/x86/include/asm/processor.h                    |    7=20
 arch/x86/include/asm/string_32.h                    |    9=20
 arch/x86/include/asm/string_64.h                    |    8=20
 arch/x86/include/asm/tlbflush.h                     |   27=20
 arch/x86/include/asm/xor.h                          |    5=20
 arch/x86/kernel/acpi/apei.c                         |    2=20
 arch/x86/kernel/amd_nb.c                            |    2=20
 arch/x86/kernel/apic/apic.c                         |    6=20
 arch/x86/kernel/apm_32.c                            |    1=20
 arch/x86/kernel/asm-offsets_32.c                    |    2=20
 arch/x86/kernel/cpu/amd.c                           |   28=20
 arch/x86/kernel/cpu/bugs.c                          |   34=20
 arch/x86/kernel/cpu/centaur.c                       |    4=20
 arch/x86/kernel/cpu/common.c                        |   10=20
 arch/x86/kernel/cpu/cyrix.c                         |    2=20
 arch/x86/kernel/cpu/intel.c                         |   46 -
 arch/x86/kernel/cpu/intel_rdt.c                     |    2=20
 arch/x86/kernel/cpu/mcheck/mce-internal.h           |   15=20
 arch/x86/kernel/cpu/mcheck/mce.c                    |   17=20
 arch/x86/kernel/cpu/microcode/intel.c               |    6=20
 arch/x86/kernel/cpu/mtrr/generic.c                  |    2=20
 arch/x86/kernel/cpu/mtrr/main.c                     |    4=20
 arch/x86/kernel/cpu/proc.c                          |    8=20
 arch/x86/kernel/early-quirks.c                      |    1=20
 arch/x86/kernel/espfix_64.c                         |    2=20
 arch/x86/kernel/head_32.S                           |    4=20
 arch/x86/kernel/mpparse.c                           |    2=20
 arch/x86/kernel/paravirt.c                          |    6=20
 arch/x86/kernel/relocate_kernel_64.S                |    8=20
 arch/x86/kernel/traps.c                             |    7=20
 arch/x86/kvm/mmu.c                                  |   10=20
 arch/x86/kvm/vmx.c                                  |    7=20
 arch/x86/lib/cpu.c                                  |    2=20
 arch/x86/mm/Makefile                                |    2=20
 arch/x86/mm/fault.c                                 |    6=20
 arch/x86/mm/init.c                                  |    8=20
 arch/x86/mm/init_64.c                               |    4=20
 arch/x86/mm/ioremap.c                               |    2=20
 arch/x86/mm/kmemcheck/Makefile                      |    1=20
 arch/x86/mm/kmemcheck/error.c                       |  228 ------
 arch/x86/mm/kmemcheck/error.h                       |   16=20
 arch/x86/mm/kmemcheck/kmemcheck.c                   |  658 ---------------=
--
 arch/x86/mm/kmemcheck/opcode.c                      |  107 --
 arch/x86/mm/kmemcheck/opcode.h                      |   10=20
 arch/x86/mm/kmemcheck/pte.c                         |   23=20
 arch/x86/mm/kmemcheck/pte.h                         |   11=20
 arch/x86/mm/kmemcheck/selftest.c                    |   71 -
 arch/x86/mm/kmemcheck/selftest.h                    |    7=20
 arch/x86/mm/kmemcheck/shadow.c                      |  173 ----
 arch/x86/mm/kmemcheck/shadow.h                      |   19=20
 arch/x86/mm/kmmio.c                                 |    2=20
 arch/x86/mm/pageattr.c                              |   10=20
 arch/x86/mm/pgtable.c                               |    2=20
 arch/x86/mm/pgtable_32.c                            |    2=20
 arch/x86/mm/tlb.c                                   |    6=20
 arch/x86/platform/efi/efi_64.c                      |    2=20
 arch/x86/platform/uv/tlb_uv.c                       |    2=20
 arch/x86/xen/mmu_pv.c                               |    6=20
 arch/x86/xen/p2m.c                                  |    6=20
 arch/x86/xen/xen-head.S                             |   16=20
 block/blk-wbt.c                                     |   10=20
 crypto/xor.c                                        |    7=20
 drivers/base/core.c                                 |    3=20
 drivers/block/rbd.c                                 |    4=20
 drivers/bluetooth/Kconfig                           |    2=20
 drivers/char/hw_random/via-rng.c                    |    2=20
 drivers/char/random.c                               |    1=20
 drivers/cpufreq/acpi-cpufreq.c                      |    2=20
 drivers/cpufreq/longhaul.c                          |    6=20
 drivers/cpufreq/p4-clockmod.c                       |    2=20
 drivers/cpufreq/powernow-k7.c                       |    2=20
 drivers/cpufreq/powernv-cpufreq.c                   |    4=20
 drivers/cpufreq/speedstep-centrino.c                |    4=20
 drivers/cpufreq/speedstep-lib.c                     |    6=20
 drivers/crypto/padlock-aes.c                        |    2=20
 drivers/crypto/sunxi-ss/sun4i-ss-prng.c             |    6=20
 drivers/devfreq/devfreq.c                           |    2=20
 drivers/dma-buf/reservation.c                       |    8=20
 drivers/edac/amd64_edac.c                           |    2=20
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.h    |    2=20
 drivers/gpu/drm/ast/ast_mode.c                      |    1=20
 drivers/gpu/drm/i915/i915_drv.h                     |    1=20
 drivers/gpu/drm/i915/i915_pci.c                     |  193 ++++-
 drivers/gpu/drm/qxl/qxl_cmd.c                       |    6=20
 drivers/gpu/drm/qxl/qxl_display.c                   |  112 ++-
 drivers/gpu/drm/qxl/qxl_drv.h                       |    4=20
 drivers/gpu/drm/qxl/qxl_dumb.c                      |    1=20
 drivers/gpu/drm/radeon/radeon_uvd.c                 |    2=20
 drivers/gpu/drm/radeon/si_dpm.c                     |    5=20
 drivers/gpu/drm/ttm/ttm_bo.c                        |    3=20
 drivers/gpu/drm/ttm/ttm_bo_vm.c                     |    3=20
 drivers/hwmon/coretemp.c                            |    6=20
 drivers/hwmon/hwmon-vid.c                           |    2=20
 drivers/hwmon/k10temp.c                             |    2=20
 drivers/hwmon/k8temp.c                              |    2=20
 drivers/infiniband/core/device.c                    |   20=20
 drivers/infiniband/core/sysfs.c                     |    1=20
 drivers/infiniband/core/user_mad.c                  |    2=20
 drivers/infiniband/core/uverbs_std_types.c          |    2=20
 drivers/infiniband/hw/mlx4/main.c                   |   13=20
 drivers/infiniband/hw/qib/qib_rc.c                  |    6=20
 drivers/infiniband/sw/rxe/rxe_loc.h                 |    1=20
 drivers/infiniband/sw/rxe/rxe_qp.c                  |   12=20
 drivers/infiniband/sw/rxe/rxe_req.c                 |    9=20
 drivers/infiniband/sw/rxe/rxe_resp.c                |    2=20
 drivers/infiniband/sw/rxe/rxe_verbs.c               |    2=20
 drivers/infiniband/sw/rxe/rxe_verbs.h               |    3=20
 drivers/md/dm.c                                     |    3=20
 drivers/media/tuners/r820t.c                        |   13=20
 drivers/misc/c2port/core.c                          |    2=20
 drivers/mmc/host/bcm2835.c                          |    3=20
 drivers/mmc/host/meson-gx-mmc.c                     |   19=20
 drivers/mmc/host/sdhci-of-esdhc.c                   |   64 +
 drivers/mmc/host/sdhci.c                            |  164 ++++
 drivers/mmc/host/sdhci.h                            |    3=20
 drivers/mtd/nand/vf610_nfc.c                        |    6=20
 drivers/net/ethernet/marvell/mvpp2.c                |   11=20
 drivers/net/ethernet/mellanox/mlx4/qp.c             |    3=20
 drivers/net/wireless/marvell/mwifiex/pcie.c         |    5=20
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c |    5=20
 drivers/net/wireless/realtek/rtlwifi/wifi.h         |    1=20
 drivers/pci/dwc/pci-keystone.c                      |    5=20
 drivers/pci/host/pcie-iproc-platform.c              |    7=20
 drivers/pci/host/pcie-iproc.c                       |    8=20
 drivers/pci/host/pcie-iproc.h                       |    2=20
 drivers/pci/quirks.c                                |    2=20
 drivers/platform/x86/apple-gmux.c                   |   48 -
 drivers/rtc/rtc-opal.c                              |   12=20
 drivers/scsi/scsi_sysfs.c                           |    5=20
 drivers/scsi/smartpqi/Makefile                      |    2=20
 drivers/target/iscsi/iscsi_target_auth.c            |    3=20
 drivers/target/iscsi/iscsi_target_nego.c            |    3=20
 drivers/usb/Kconfig                                 |    8=20
 drivers/usb/host/Kconfig                            |    8=20
 drivers/video/console/dummycon.c                    |    1=20
 drivers/video/fbdev/atmel_lcdfb.c                   |    8=20
 drivers/video/fbdev/geode/video_gx.c                |    2=20
 drivers/xen/xenbus/xenbus.h                         |    1=20
 drivers/xen/xenbus/xenbus_comms.c                   |    1=20
 drivers/xen/xenbus/xenbus_xs.c                      |    3=20
 fs/btrfs/inode.c                                    |   41 -
 fs/btrfs/tree-log.c                                 |   32=20
 fs/dcache.c                                         |    2=20
 fs/ext4/inode.c                                     |   16=20
 fs/ext4/super.c                                     |    1=20
 fs/jbd2/transaction.c                               |    5=20
 fs/mbcache.c                                        |    1=20
 fs/ocfs2/dlmglue.c                                  |    9=20
 fs/overlayfs/inode.c                                |   37 -
 fs/overlayfs/super.c                                |    1=20
 fs/overlayfs/util.c                                 |    4=20
 fs/seq_file.c                                       |    5=20
 include/drm/i915_pciids.h                           |  160 ++--
 include/linux/c2port.h                              |    4=20
 include/linux/compiler-gcc.h                        |    7=20
 include/linux/compiler.h                            |    4=20
 include/linux/cpuidle.h                             |    2=20
 include/linux/dma-mapping.h                         |    8=20
 include/linux/filter.h                              |    2=20
 include/linux/gfp.h                                 |    9=20
 include/linux/interrupt.h                           |   15=20
 include/linux/jbd2.h                                |  431 +++++++----
 include/linux/kmemcheck.h                           |  172 ----
 include/linux/mlx5/driver.h                         |    2=20
 include/linux/mm_inline.h                           |    6=20
 include/linux/mm_types.h                            |    8=20
 include/linux/net.h                                 |    3=20
 include/linux/nospec.h                              |   36=20
 include/linux/ring_buffer.h                         |    3=20
 include/linux/skbuff.h                              |    3=20
 include/linux/slab.h                                |    6=20
 include/linux/thread_info.h                         |    5=20
 include/net/inet_sock.h                             |    3=20
 include/net/inet_timewait_sock.h                    |    4=20
 include/net/sock.h                                  |    3=20
 include/rdma/ib_verbs.h                             |    2=20
 include/trace/events/mmflags.h                      |    1=20
 include/trace/events/xen.h                          |    2=20
 init/do_mounts.c                                    |    3=20
 init/main.c                                         |    1=20
 kernel/bpf/core.c                                   |    6=20
 kernel/fork.c                                       |   12=20
 kernel/locking/lockdep.c                            |    3=20
 kernel/memremap.c                                   |    3=20
 kernel/signal.c                                     |    3=20
 kernel/softirq.c                                    |   10=20
 kernel/sysctl.c                                     |   10=20
 kernel/trace/Kconfig                                |    2=20
 kernel/trace/ring_buffer.c                          |    3=20
 kernel/trace/trace_events_filter.c                  |    9=20
 lib/Kconfig.debug                                   |    6=20
 lib/Kconfig.kmemcheck                               |   94 --
 lib/swiotlb.c                                       |   15=20
 mm/Kconfig.debug                                    |    1=20
 mm/Makefile                                         |    2=20
 mm/kmemcheck.c                                      |  126 ---
 mm/kmemleak.c                                       |    9=20
 mm/memory-failure.c                                 |    2=20
 mm/memory.c                                         |    2=20
 mm/page_alloc.c                                     |   14=20
 mm/slab.c                                           |   16=20
 mm/slab.h                                           |    7=20
 mm/slab_common.c                                    |    2=20
 mm/slub.c                                           |   31=20
 net/9p/trans_virtio.c                               |    3=20
 net/core/skbuff.c                                   |    5=20
 net/core/sock.c                                     |    2=20
 net/ipv4/inet_timewait_sock.c                       |    3=20
 net/ipv4/tcp_input.c                                |    1=20
 net/mpls/af_mpls.c                                  |   24=20
 net/socket.c                                        |    1=20
 net/sunrpc/xprtrdma/rpc_rdma.c                      |    2=20
 net/sunrpc/xprtrdma/verbs.c                         |    8=20
 scripts/kernel-doc                                  |    2=20
 sound/core/seq/seq_clientmgr.c                      |    8=20
 sound/pci/hda/patch_realtek.c                       |   72 +
 sound/soc/intel/common/sst-match-acpi.c             |    8=20
 sound/usb/mixer.c                                   |   18=20
 sound/usb/pcm.c                                     |    9=20
 sound/usb/quirks.c                                  |    7=20
 tools/include/linux/kmemcheck.h                     |    9=20
 tools/objtool/check.c                               |   12=20
 tools/perf/builtin-kmem.c                           |    1=20
 tools/testing/selftests/seccomp/seccomp_bpf.c       |    4=20
 tools/testing/selftests/vm/compaction_test.c        |    2=20
 tools/testing/selftests/x86/Makefile                |   22=20
 tools/testing/selftests/x86/mpx-mini-test.c         |   32=20
 tools/testing/selftests/x86/protection_keys.c       |   28=20
 tools/testing/selftests/x86/single_step_syscall.c   |    5=20
 tools/testing/selftests/x86/test_mremap_vdso.c      |    4=20
 tools/testing/selftests/x86/test_vdso.c             |   55 +
 tools/testing/selftests/x86/test_vsyscall.c         |   11=20
 300 files changed, 1958 insertions(+), 3841 deletions(-)

Alex Deucher (1):
      drm/radeon: Add dpm quirk for Jet PRO (v2)

Alexander Potapenko (1):
      mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Alexey Kardashevskiy (1):
      powerpc/mm: Flush radix process translations when setting MMU type

Amir Goldstein (1):
      ovl: hash directory inodes for fsnotify

Anders Roxell (1):
      selftests: seccomp: fix compile error seccomp_bpf

Andrey Grodzovsky (1):
      drm/amd/powerplay: Fix smu_table_entry.handle type

Andy Lutomirski (1):
      x86/mm: Rename flush_tlb_single() and flush_tlb_one() to __flush_tlb_=
one_[user|kernel]()

Anuj Phogat (1):
      drm/i915/kbl: Change a KBL pci id to GT2 from GT1.5

Arnd Bergmann (9):
      kselftest: fix OOM in memory compaction test
      ARM: lpc3250: fix uda1380 gpio numbers
      ARM: dts: nomadik: add interrupt-parent for clcd
      mm: hide a #warning for COMPILE_TEST
      Bluetooth: BT_HCIUART now depends on SERIAL_DEV_BUS
      ARM: dts: exynos: fix RTC interrupt for exynos5410
      ARM: pxa/tosa-bt: add MODULE_LICENSE tag
      ARM: dts: s5pv210: add interrupt-parent for ohci
      media: r820t: fix r820t_write_reg for KASAN

Artem Savkov (2):
      crypto: sun4i_ss_prng - fix return value of sun4i_ss_prng_generate
      crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate

Balbir Singh (1):
      powerpc/mm/radix: Split linear mapping on hot-unplug

Bart Van Assche (4):
      IB/core: Fix two kernel warnings triggered by rxe registration
      RDMA/rxe: Fix a race condition related to the QP error state
      RDMA/rxe: Fix a race condition in rxe_requester()
      RDMA/rxe: Fix rxe_qp_cleanup()

Benjamin Herrenschmidt (1):
      powerpc: Fix DABR match on hash based systems

Bjorn Andersson (3):
      PM / devfreq: Propagate error from devfreq_add_device()
      arm64: dts: msm8916: Correct ipc references for smsm
      arm64: dts: msm8916: Add missing #phy-cells

Bodong Wang (1):
      IB/core: Fix ib_wc structure size to remain in 64 bytes boundary

Borislav Petkov (1):
      x86/entry/64: Remove the unused 'icebp' macro

Brian Norris (1):
      mwifiex: resolve reset vs. remove()/shutdown() deadlocks

Christian K=F6nig (2):
      swiotlb: suppress warning when __GFP_NOWARN is set
      dma-buf: fix reservation_object_wait_timeout_rcu once more v2

Chuck Lever (2):
      xprtrdma: Fix calculation of ri_max_send_sges
      xprtrdma: Fix BUG after a device removal

Corentin Labbe (1):
      MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN

C=E9dric Le Goater (1):
      powerpc/xive: Use hw CPU ids when configuring the CPU queues

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (5):
      x86/entry/64: Clear extra registers beyond syscall arguments, to redu=
ce speculation attack surface
      x86/entry/64/compat: Clear registers for compat syscalls, to reduce s=
peculation attack surface
      x86/entry/64: Clear registers for exceptions/interrupts, to reduce sp=
eculation attack surface
      x86/speculation: Fix up array_index_nospec_mask() asm constraint
      mpls, nospec: Sanitize array index in mpls_label_ok()

Daniel Mack (1):
      ALSA: usb: add more device quirks for USB DSD devices

Daniel Vetter (1):
      drm/ast: Load lut in crtc_commit

David Disseldorp (1):
      target/iscsi: avoid NULL dereference in CHAP auth error path

David Woodhouse (4):
      x86/speculation: Update Speculation Control microcode blacklist
      x86/speculation: Correct Speculation Control microcode blacklist again
      Revert "x86/speculation: Simplify indirect_branch_prediction_barrier(=
)"
      KVM/x86: Reduce retpoline performance impact in slot_handle_level_ran=
ge(), by always inlining iterator helper methods

Dominik Brodowski (12):
      x86/entry/64: Merge SAVE_C_REGS and SAVE_EXTRA_REGS, remove unused ex=
tensions
      x86/entry/64: Merge the POP_C_REGS and POP_EXTRA_REGS macros into a s=
ingle POP_REGS macro
      x86/entry/64: Interleave XOR register clearing with PUSH instructions
      x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
      x86/entry/64: Use PUSH_AND_CLEAN_REGS in more cases
      x86/entry/64: Get rid of the ALLOC_PT_GPREGS_ON_STACK and SAVE_AND_CL=
EAR_REGS macros
      x86/entry/64: Indent PUSH_AND_CLEAR_REGS and POP_REGS properly
      selftests/x86: Fix vDSO selftest segfault for vsyscall=3Dnone
      selftests/x86: Clean up and document sscanf() usage
      selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
      selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c
      selftests/x86: Disable tests requiring 32-bit support on pure 64-bit =
systems

Dongdong Liu (1):
      PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode

Ernesto A. Fern=E1ndez (1):
      ext4: correct documentation for grpid mount option

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Felix Kuehling (1):
      drm/ttm: Don't add swapped BOs to swap-LRU list

Florian Westphal (1):
      iscsi-target: make sure to wake up sleeping login worker

Gang He (1):
      ocfs2: try a blocking lock before return AOP_TRUNCATED_PAGE

Geert Uytterhoeven (2):
      compiler-gcc.h: Introduce __optimize function attribute
      compiler-gcc.h: __nostackprotector needs gcc-4.4 and up

Gerd Hoffmann (1):
      qxl: alloc & use shadow for dumb buffers

Greg Kroah-Hartman (1):
      Linux 4.14.21

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int

Hannes Reinecke (1):
      scsi: core: check for device state in __scsi_remove_target()

Harshad Shirwadkar (1):
      ext4: fix a race in the ext4 shutdown path

Hui Wang (1):
      ALSA: hda - Fix headset mic detection problem for two Dell machines

Ilya Dryomov (1):
      rbd: whitelist RBD_FEATURE_OPERATIONS feature bit

Ingo Molnar (3):
      x86/speculation: Clean up various Spectre related details
      selftests/x86/pkeys: Remove unused functions
      x86/entry/64: Fix CR3 restore in paranoid_exit()

Jack Morgenstein (2):
      IB/umad: Fix use of unprotected device pointer
      IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ET=
H ports

James Hogan (1):
      usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT

Jan H. Sch=F6nherr (1):
      mm: Fix memory size alignment in devm_memremap_pages_release()

Jan-Marek Glogowski (1):
      ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Jens Axboe (1):
      blk-wbt: account flush requests correctly

Jerome Brunet (1):
      Revert "mmc: meson-gx: include tx phase in the tuning process"

Jia Zhang (1):
      x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Joao Martins (1):
      xenbus: track caller request id

Johan Hovold (2):
      PCI: keystone: Fix interrupt-controller-node lookup
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Josh Poimboeuf (3):
      x86/entry/64: Fix paranoid_entry() frame pointer warning
      objtool: Fix segfault in ignore_unreachable_insn()
      x86/debug, objtool: Annotate WARN()-related UD2 as reachable

Juergen Gross (1):
      x86/xen: init %gs very early to avoid page faults with stack protector

Julia Lawall (1):
      drm/radeon: adjust tested variable

Kailang Yang (2):
      ALSA: hda/realtek - Add headset mode support for Dell laptop
      ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform

KarimAllah Ahmed (2):
      X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs
      KVM/nVMX: Set the CPU_BASED_USE_MSR_BITMAPS if we have a valid L02 MS=
R bitmap

Kirill A. Shutemov (1):
      x86/kexec: Make kexec (mostly) work in 5-level paging mode

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Larry Finger (1):
      rtlwifi: rtl8821ae: Fix connection lost problem correctly

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Levin, Alexander (Sasha Levin) (4):
      kmemcheck: remove annotations
      kmemcheck: stop using GFP_NOTRACK and SLAB_NOTRACK
      kmemcheck: remove whats left of NOTRACK flags
      kmemcheck: rip it out

Linus Walleij (2):
      mmc: sdhci: Implement an SDHCI-specific bounce buffer
      ARM: dts: Delete bogus reference to the charlcd

Lionel Landwerlin (1):
      drm/i915: add GT number to intel_device_info

Liu Bo (6):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix extent state leak from tree log
      Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
      Btrfs: fix use-after-free on root->orphan_block_rsv
      Btrfs: fix unexpected -EEXIST when creating new inode

Lucas De Marchi (1):
      x86/gpu: add CFL to early quirks

Lukas Wunner (2):
      PM / runtime: Update links_count also if !CONFIG_SRCU
      Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"

Mahesh Salgaonkar (1):
      powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all

Marcin Nowakowski (1):
      MIPS: Fix incorrect mem=3DX@Y handling

Matthias Brugger (2):
      arm: dts: mt7623: Update ethsys binding
      arm: dts: mt2701: Add reset-cells

Michael J. Ruhl (1):
      IB/core: Avoid a potential OOPs for an unused optional parameter

Michal Hocko (1):
      kmemcheck: rip it out for real

Mike Marciniszyn (1):
      IB/qib: Fix comparison error with qperf compare/swap test

Miklos Szeredi (1):
      seq_file: fix incomplete reset on read from zero offset

Mikulas Patocka (1):
      mvpp2: fix multicast address filter

Nadav Amit (1):
      x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()

Nathan Fontenot (1):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove

NeilBrown (1):
      dm: correctly handle chained bios in dec_pending()

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Patrice Chotard (1):
      ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Peter Zijlstra (2):
      x86/debug: Use UD2 for WARN()
      x86/speculation: Add <asm/msr-index.h> dependency

Phil Elwell (1):
      mmc: bcm2835: Don't overwrite max frequency unconditionally

Pierre-Louis Bossart (1):
      ASoC: acpi: fix machine driver selection based on quirk

Rafael J. Wysocki (2):
      x86: PM: Make APM idle driver initialize polling state
      PM: cpuidle: Fix cpuidle_poll_state_init() prototype

Randy Dunlap (1):
      tracing: Prevent PROFILE_ALL_BRANCHES when FORTIFY_SOURCE=3Dy

Ray Jui (1):
      PCI: iproc: Fix NULL pointer dereference for BCMA

Ray Strode (2):
      drm/qxl: unref cursor bo when finished with it
      drm/qxl: reapply cursor after resetting primary

Rui Wang (1):
      selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Sagi Grimberg (1):
      mlx5: fix mlx5_get_vector_affinity to start from completion vector 0

Sean Wang (1):
      arm: dts: mt7623: fix card detection issue on bananapi-r2

Shanker Donthineni (1):
      arm64: Add missing Falkor part number for branch predictor hardening

Shilpasri G Bhat (1):
      cpufreq: powernv: Dont assume distinct pstate values for nominal and =
pmin

Simon Gaiser (1):
      xen: Fix {set,clear}_foreign_p2m_mapping on autotranslating guests

Stefan Agner (1):
      mtd: nand: vf610: set correct ooblayout

Steffen Weber (1):
      scsi: smartpqi: allow static build ("built-in")

Steven Rostedt (VMware) (1):
      tracing: Fix parsing of globs with a wildcard at the beginning

Stewart Smith (1):
      rtc-opal: Fix handling of firmware error codes, prevent busy loops

Takashi Iwai (1):
      ALSA: seq: Fix racy pool initializations

Tobin C. Harding (1):
      jbd2: fix sphinx kernel-doc build warnings

Tom St Denis (1):
      drm/ttm: Fix 'buf' pointer update in ttm_bo_vm_access_kmap() (v2)

Tony Luck (1):
      x86/mm, mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages

Viresh Kumar (3):
      arm: spear600: Add missing interrupt-parent of rtc
      arm: spear13xx: Fix dmas cells
      arm: spear13xx: Fix spics gpio controller's warning

Will Deacon (2):
      nospec: Move array_index_nospec() parameter checking into separate ma=
cro
      arm64: proc: Set PTE_NG for table entries to avoid traversing them tw=
ice

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()

yangbo lu (1):
      mmc: sdhci-of-esdhc: disable SD clock for clock value 0

yinbo.zhu (2):
      mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
      mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqPw94ACgkQONu9yGCS
aT6HIw//dJNFy4UkB/+S2FBf4d9iFdEJfi1G/6Bs+KHAOS8EAyaGW1dUPFeIGf4K
isJCABS3RJFlMGflXTYrQp766PwphhpHUWZumoxHkCsRXZ5fTw2EgJRrotWEReAm
crPEjJeHG4xRWvr7bFJOrikxMR9Y64OX9gh4cnVKBwKGg1aipJnPd6zLiQNpiclJ
tRpLUIfBuOQoqOq0e14Y51loyafTDlxJPDCfsdguFL6qEigvAcL2tEmOG5KR/uKW
SdVho7UnB3FAeT3Zv8K6YcuXUcOwUIP0+2gfpQZsMcppWa1lK7TcxgrKqk9jIs8W
l7Q8XUaIEXwF/uyatb3ZzNEvt8nPBd41XWegybYWELYr8rkR6M2JuUsKfv/bHuav
bULR3eOGf+9RSYIuxPnb/3RtIu2+7M2h8rScMPvwh6SdlJqMZkvVTH9OpFe0UrXG
R2zD7ZUlSI92cYUZwgXaK8ccVEQvPP8vaqzY4fhJZYDQgtGIJJzQh99WhVROYBhS
jJFTamLIHawxAmgNhBQx4F+DuhBE1Bku2z63sbeI+qnj/GbnZichrwTr19gjIZje
8tMC80e0UnzPA3g/aCqp6GBVT/3ka9zhzKxq12b5e2Xw7H89eJi4MwmDoxn97nlh
efHFjO6FvLdr8dBI5s1WtLW8k9+HDJiqPAZGrzV227IvWi5CImE=
=7ZsR
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
