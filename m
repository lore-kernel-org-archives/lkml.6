Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252784-1519371277-2-17467510320773988468
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
    t=1519371276; b=GFEu8dt8tWYg62s2SpGFb36VjZ7T3pL24EP19v1hbghHuBw
    foAY+n4L2hxo2jLig8Q4MPA3PunSdbAFpboiiPYFH0/pt8seLFN9UE4foNbci6dH
    MJLl/Bb73+oqm/AYM41nxvhNM3gCjjZoWy6AYiixSppzqv5KarYy6ttqUl8sYCtU
    5qtlHftW8xm6Jy3QTwTcID1Dlj4IcbdTOHD4Ug+QV0rIon28ubH9CDJnFoWYug7y
    4wrp90G8/7iIIiHrPgilmvkfHhQYy/jr0CGP1mh9UDzeI1OPq0oxRrzZaYv555HX
    rwnRslnkUGSQwMxuw2YjDPortCA1H0Syhq74OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519371276; bh=gZFiIhm2/kE1mpO/h5mi6dgMxZLmpZ+57KQX83H/dkU=; b=B
    7Cy4XORt+4/3wGwWSYqF8Iw+ezaIIMsD5uLaqCotrM7026mAun+u6QOaWt8G73F2
    nLIJqhqsE1vnXuir6mKxKsCa599TFBp1Rv4YrGgW6TQ+1eW9mH7GBanWXEr+87kw
    bRMX7DgLkEUxIVxjzRnlMwOUCKdoVJ2SEFKQ9Kh1we6pYpFsBiIeqfRK05e7IOUu
    e3YDlyYX0deTxdCeV2QOPgxpxTQ9Bs64P+a5lZ1ZWnwPZPfFy0nZt8nKA/tm3UcJ
    z2hEhUqL4jFUcWvAYylBaFI3UfQlWWbYAHZVBYCYoNkHf2rt0mhbT6out9jc+n8f
    uXckf3GSPrwkXIBFWZg8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeBWHeb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:34:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49270 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbeBWHeX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:34:23 -0500
Date: Fri, 23 Feb 2018 08:34:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.5
Message-ID: <20180223073423.GA13001@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.5 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/dma/snps-dma.txt  |    2=20
 Documentation/filesystems/ext4.txt                  |    2=20
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
 arch/arm/mach-pxa/tosa-bt.c                         |    4=20
 arch/arm64/boot/dts/qcom/msm8916.dtsi               |    5=20
 arch/arm64/kernel/cpu_errata.c                      |    9=20
 arch/arm64/kvm/hyp/switch.c                         |    4=20
 arch/arm64/mm/proc.S                                |   14=20
 arch/mips/Kconfig                                   |   12=20
 arch/mips/kernel/cps-vec.S                          |   17=20
 arch/mips/kernel/setup.c                            |   16=20
 arch/powerpc/include/asm/topology.h                 |    5=20
 arch/powerpc/kernel/process.c                       |   15=20
 arch/powerpc/mm/numa.c                              |    5=20
 arch/powerpc/mm/pgtable-radix.c                     |   95 +++-
 arch/powerpc/mm/pgtable_64.c                        |    2=20
 arch/powerpc/mm/tlb-radix.c                         |    2=20
 arch/powerpc/platforms/powernv/vas-window.c         |   16=20
 arch/powerpc/platforms/pseries/hotplug-cpu.c        |    2=20
 arch/powerpc/sysdev/xive/spapr.c                    |   16=20
 arch/s390/kernel/compat_linux.c                     |    8=20
 arch/x86/entry/calling.h                            |  107 ++--
 arch/x86/entry/entry_64.S                           |   92 ----
 arch/x86/entry/entry_64_compat.S                    |   30 +
 arch/x86/events/intel/core.c                        |    2=20
 arch/x86/events/intel/lbr.c                         |    2=20
 arch/x86/events/intel/p6.c                          |    2=20
 arch/x86/include/asm/acpi.h                         |    2=20
 arch/x86/include/asm/barrier.h                      |    2=20
 arch/x86/include/asm/bug.h                          |   19=20
 arch/x86/include/asm/nospec-branch.h                |   14=20
 arch/x86/include/asm/page_64.h                      |    4=20
 arch/x86/include/asm/paravirt.h                     |    4=20
 arch/x86/include/asm/paravirt_types.h               |    2=20
 arch/x86/include/asm/pgtable_32.h                   |    2=20
 arch/x86/include/asm/processor.h                    |    7=20
 arch/x86/include/asm/tlbflush.h                     |   27 -
 arch/x86/kernel/amd_nb.c                            |    2=20
 arch/x86/kernel/apic/apic.c                         |    6=20
 arch/x86/kernel/apm_32.c                            |    1=20
 arch/x86/kernel/asm-offsets_32.c                    |    2=20
 arch/x86/kernel/cpu/amd.c                           |   28 -
 arch/x86/kernel/cpu/bugs.c                          |   34 -
 arch/x86/kernel/cpu/centaur.c                       |    4=20
 arch/x86/kernel/cpu/common.c                        |   10=20
 arch/x86/kernel/cpu/cyrix.c                         |    2=20
 arch/x86/kernel/cpu/intel.c                         |   31 -
 arch/x86/kernel/cpu/intel_rdt.c                     |    2=20
 arch/x86/kernel/cpu/mcheck/mce-internal.h           |   15=20
 arch/x86/kernel/cpu/mcheck/mce.c                    |   17=20
 arch/x86/kernel/cpu/microcode/intel.c               |    6=20
 arch/x86/kernel/cpu/mtrr/generic.c                  |    2=20
 arch/x86/kernel/cpu/mtrr/main.c                     |    4=20
 arch/x86/kernel/cpu/proc.c                          |    8=20
 arch/x86/kernel/early-quirks.c                      |    1=20
 arch/x86/kernel/head_32.S                           |    4=20
 arch/x86/kernel/mpparse.c                           |    2=20
 arch/x86/kernel/paravirt.c                          |    6=20
 arch/x86/kernel/relocate_kernel_64.S                |    8=20
 arch/x86/kernel/smpboot.c                           |    1=20
 arch/x86/kernel/traps.c                             |    2=20
 arch/x86/kvm/mmu.c                                  |   10=20
 arch/x86/kvm/vmx.c                                  |    7=20
 arch/x86/lib/cpu.c                                  |    2=20
 arch/x86/mm/init_64.c                               |    2=20
 arch/x86/mm/ioremap.c                               |    2=20
 arch/x86/mm/kmmio.c                                 |    2=20
 arch/x86/mm/pgtable_32.c                            |    2=20
 arch/x86/mm/tlb.c                                   |    6=20
 arch/x86/platform/uv/tlb_uv.c                       |    2=20
 arch/x86/xen/mmu_pv.c                               |    6=20
 arch/x86/xen/p2m.c                                  |    6=20
 arch/x86/xen/xen-head.S                             |   16=20
 block/blk-wbt.c                                     |   10=20
 drivers/base/core.c                                 |    3=20
 drivers/block/rbd.c                                 |    4=20
 drivers/char/hw_random/via-rng.c                    |    2=20
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
 drivers/gpu/drm/drm_auth.c                          |    6=20
 drivers/gpu/drm/qxl/qxl_display.c                   |   63 ++
 drivers/gpu/drm/qxl/qxl_drv.h                       |    2=20
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
 drivers/mmc/host/bcm2835.c                          |    3=20
 drivers/mmc/host/meson-gx-mmc.c                     |   19=20
 drivers/mmc/host/sdhci-of-esdhc.c                   |    8=20
 drivers/mmc/host/sdhci.c                            |  164 +++++++
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
 drivers/pci/hotplug/pciehp_hpc.c                    |    7=20
 drivers/pci/quirks.c                                |    2=20
 drivers/platform/x86/apple-gmux.c                   |   48 --
 drivers/platform/x86/wmi.c                          |    2=20
 drivers/rtc/rtc-opal.c                              |   12=20
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
 fs/btrfs/inode.c                                    |   41 +
 fs/btrfs/tree-log.c                                 |   32 +
 fs/ext4/inode.c                                     |   16=20
 fs/ext4/super.c                                     |    1=20
 fs/gfs2/bmap.c                                      |   43 +
 fs/jbd2/transaction.c                               |    5=20
 fs/mbcache.c                                        |    1=20
 fs/ocfs2/dlmglue.c                                  |    9=20
 fs/seq_file.c                                       |    5=20
 include/drm/i915_pciids.h                           |    6=20
 include/linux/compiler-gcc.h                        |    7=20
 include/linux/compiler.h                            |    4=20
 include/linux/cpuidle.h                             |    2=20
 include/linux/jbd2.h                                |  431 ++++++++++++---=
-----
 include/linux/mlx5/driver.h                         |    2=20
 include/linux/mm_inline.h                           |    6=20
 include/linux/nospec.h                              |   36 -
 include/rdma/ib_verbs.h                             |    2=20
 include/trace/events/xen.h                          |    2=20
 kernel/memremap.c                                   |    3=20
 kernel/trace/trace_events_filter.c                  |    9=20
 kernel/trace/trace_uprobe.c                         |    2=20
 lib/swiotlb.c                                       |   15=20
 mm/memory-failure.c                                 |    2=20
 mm/memory.c                                         |    2=20
 mm/page_alloc.c                                     |   22 -
 net/9p/trans_virtio.c                               |    3=20
 net/mpls/af_mpls.c                                  |   24 -
 net/sunrpc/xprtrdma/rpc_rdma.c                      |    2=20
 net/sunrpc/xprtrdma/verbs.c                         |    8=20
 sound/core/seq/seq_clientmgr.c                      |    8=20
 sound/pci/hda/patch_realtek.c                       |   72 +++
 sound/usb/mixer.c                                   |   18=20
 sound/usb/pcm.c                                     |    9=20
 sound/usb/quirks.c                                  |    7=20
 tools/objtool/check.c                               |   12=20
 tools/testing/selftests/seccomp/seccomp_bpf.c       |    4=20
 tools/testing/selftests/vm/compaction_test.c        |    2=20
 tools/testing/selftests/x86/Makefile                |   24 -
 tools/testing/selftests/x86/mpx-mini-test.c         |   32 +
 tools/testing/selftests/x86/protection_keys.c       |   28 -
 tools/testing/selftests/x86/single_step_syscall.c   |    5=20
 tools/testing/selftests/x86/test_mremap_vdso.c      |    4=20
 tools/testing/selftests/x86/test_vdso.c             |   55 ++
 tools/testing/selftests/x86/test_vsyscall.c         |   11=20
 207 files changed, 1624 insertions(+), 896 deletions(-)

Alex Deucher (1):
      drm/radeon: Add dpm quirk for Jet PRO (v2)

Alexander Potapenko (1):
      mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Alexey Kardashevskiy (1):
      powerpc/mm: Flush radix process translations when setting MMU type

Anders Roxell (1):
      selftests: seccomp: fix compile error seccomp_bpf

Andreas Gruenbacher (1):
      gfs2: Fixes to "Implement iomap for block_map"

Andrey Grodzovsky (1):
      drm/amd/powerplay: Fix smu_table_entry.handle type

Andrey Ryabinin (1):
      platform/x86: wmi: fix off-by-one write in wmi_dev_probe()

Andy Lutomirski (1):
      x86/mm: Rename flush_tlb_single() and flush_tlb_one() to __flush_tlb_=
one_[user|kernel]()

Arnd Bergmann (8):
      kselftest: fix OOM in memory compaction test
      ARM: lpc3250: fix uda1380 gpio numbers
      ARM: dts: nomadik: add interrupt-parent for clcd
      mm: hide a #warning for COMPILE_TEST
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

Dominik Brodowski (13):
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
      selftests/x86: Fix build bug caused by the 5lvl test which has been m=
oved to the VM directory
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

Greg Kroah-Hartman (1):
      Linux 4.15.5

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int

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

James Hogan (2):
      MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout
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

Keith Packard (1):
      drm: Check for lessee in DROP_MASTER ioctl

Kirill A. Shutemov (1):
      x86/kexec: Make kexec (mostly) work in 5-level paging mode

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Larry Finger (1):
      rtlwifi: rtl8821ae: Fix connection lost problem correctly

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Linus Walleij (2):
      mmc: sdhci: Implement an SDHCI-specific bounce buffer
      ARM: dts: Delete bogus reference to the charlcd

Liu Bo (6):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix extent state leak from tree log
      Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
      Btrfs: fix use-after-free on root->orphan_block_rsv
      Btrfs: fix unexpected -EEXIST when creating new inode

Lucas De Marchi (1):
      x86/gpu: add CFL to early quirks

Lukas Wunner (3):
      PM / runtime: Update links_count also if !CONFIG_SRCU
      Revert "apple-gmux: lock iGP IO to protect from vgaarb changes"
      PCI: pciehp: Assume NoCompl+ for Thunderbolt ports

Mahesh Salgaonkar (1):
      powerpc/radix: Remove trace_tlbie call from radix__flush_tlb_all

Marcin Nowakowski (1):
      MIPS: Fix incorrect mem=3DX@Y handling

Masayoshi Mizuma (1):
      x86/smpboot: Fix uncore_pci_remove() indexing bug when hot-removing a=
 physical CPU

Matthias Brugger (2):
      arm: dts: mt7623: Update ethsys binding
      arm: dts: mt2701: Add reset-cells

Michael J. Ruhl (1):
      IB/core: Avoid a potential OOPs for an unused optional parameter

Michal Hocko (1):
      mm, memory_hotplug: fix memmap initialization

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

Nicholas Piggin (1):
      powerpc/vas: Don't set uses_vas for kernel windows

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Patrice Chotard (1):
      ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Peter Zijlstra (2):
      x86/debug: Use UD2 for WARN()
      x86/speculation: Add <asm/msr-index.h> dependency

Phil Elwell (1):
      mmc: bcm2835: Don't overwrite max frequency unconditionally

Rafael J. Wysocki (2):
      x86: PM: Make APM idle driver initialize polling state
      PM: cpuidle: Fix cpuidle_poll_state_init() prototype

Ravi Bangoria (1):
      trace_uprobe: Display correct offset in uprobe_events

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

Sukadev Bhattiprolu (1):
      powerpc/kernel: Block interrupts when updating TIDR

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

yinbo.zhu (2):
      mmc: sdhci-of-esdhc: fix eMMC couldn't work after kexec
      mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqPw/8ACgkQONu9yGCS
aT7kaxAA0MzXrTL/5QFVOyGA3zT9beCaD8i6pk7GIqUBdnuKBZp8F14ZsK7W79R3
8zraCUme8TGA2lNRJci/g1FxffMDuGkMO6yYugsHgS91gJg4hJ6fO6zntCsHfL5e
AgTPf+xL5CvedL+tip8r7cWe3I9GKVPp3WCEuTwrl8muTmqad54jsIur+V3S2Hkq
u8jJRV122M6HGqsvxgbgrJtKJExX3yOB8P1r/ck0y0tT8WxFYHPzQrBKEpnPTgSF
zGJcbUXxlzILy1YqThrhOpGHKpBafDjgxLsIrj6ikr9Hx2EM4nFfjs0h9V/sC5de
AcfC2bYGrR25CnIH1zQEIG97h/UjTnPY2RQGSJ1ko42vSR1cFfuuadoLekKzhzEX
rLo2ju2eqt+DcUsoqw/06quHhAS+9So+hY66h/vm95AdUdVcbSzYHQegl44CA9Nr
AbrQKyLoa544lSk5d+o/Uuq0PmmzMrzrUd/MWaz0be9BUnPOQx+HhAG3KIqmbL5Z
QZhTQQEZ5+kBxvJSWYBWHYKyLomTyOA1fU/IrMipVq8DjbRgz6lYrkibGkniQaN7
u+wNp07/Ilmf5izPf7RPd/ptfIqqdhT5yQikw/XAffzIaqP00nPBCWy6f6VwqFRa
otaGo1fiZMPzVl81KrmKlm8BnLV4x4ZamGU8wubPwBinteNRMHQ=
=jqJ0
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
