Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2252784-1519371387-2-2043251213520693971
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
    t=1519371367; b=uzgwDj1oqgXUZiqkoCMFCGAyWYC5JpTSqNuiR4EQi7zK8k+
    X0je3KFxnjyjD3dfbAvFCqzO28wfVUUQGVWOCifVUa4VZNEVY29PsZE0rRkZZmTS
    iUNha14D+IRVhzlk71Z1x+KabqWhHMb9iWh+1jefqCPPumK6954B/xjLmahCsin3
    UeP1Aq6cxUMkU6GspLI9kbs/fRdc0se2azyNbeVYUn9lKOCGDX1ryjmDm1N4Yewf
    z3zj3BMz24HKZk/rmiEoiWEHmmxxIu12kl/3vapj2KNSls1EFai0shBXCed5ERkG
    3mraU56KmhtsRY78byL9U0UOPJ6LW5vf8MynrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519371367; bh=WKeOTdAaqAgF2zyqNh9AINnvp14hTeGqQD1agU33xAQ=; b=v
    eb6K+S7KuGXEEoKRLcCRNnycOhKhcM80ZY6lHNLfR+3y/aYgRHzzJX4JuASB58dx
    tesq0Acwy/HuFmnXYcSveTzcYQrxyu8Uonzdb3P9bEmp37pZaS+3VeatfnkJupQJ
    KW2SXaqUHzdbmD0W3gQkqGcNutEgDjaqByPodIRsBCSCDTz1jMYDQUWXDoX2Nyed
    w2g8vGMbObFnqXO1LbmjDOS0wVzlc8MyIAlOH9FeNtrgHKz/QO4R+QjQ4FDMmSyG
    msLQPgVNfu4DXnUiycV+YT2hem/7zgvk5h9i6lsYRq+CYLryEg+Mjait7LCONpcN
    SpX+wHzCJlGGThagdIHIg==
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
        id S1751674AbeBWHd1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:33:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeBWHd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:33:26 -0500
Date: Fri, 23 Feb 2018 08:33:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.83
Message-ID: <20180223073326.GA12752@kroah.com>
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

I'm announcing the release of the 4.9.83 kernel.

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

 Documentation/devicetree/bindings/dma/snps-dma.txt  |    2=20
 Documentation/filesystems/ext4.txt                  |    2=20
 Makefile                                            |    2=20
 arch/arm/boot/dts/arm-realview-eb-mp.dtsi           |    5=20
 arch/arm/boot/dts/exynos5410.dtsi                   |    1=20
 arch/arm/boot/dts/lpc3250-ea3250.dts                |    4=20
 arch/arm/boot/dts/lpc3250-phy3250.dts               |    4=20
 arch/arm/boot/dts/mt2701.dtsi                       |    2=20
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
 arch/mips/Kconfig                                   |   12=20
 arch/powerpc/kernel/entry_64.S                      |    5=20
 arch/s390/kernel/compat_linux.c                     |    8=20
 arch/x86/entry/entry_64_compat.S                    |   30 +
 arch/x86/events/intel/core.c                        |    2=20
 arch/x86/events/intel/lbr.c                         |    2=20
 arch/x86/events/intel/p6.c                          |    2=20
 arch/x86/include/asm/acpi.h                         |    2=20
 arch/x86/include/asm/barrier.h                      |    2=20
 arch/x86/include/asm/nospec-branch.h                |    1=20
 arch/x86/include/asm/processor.h                    |    4=20
 arch/x86/kernel/amd_nb.c                            |    2=20
 arch/x86/kernel/asm-offsets_32.c                    |    2=20
 arch/x86/kernel/cpu/amd.c                           |   26 -
 arch/x86/kernel/cpu/bugs.c                          |   28 -
 arch/x86/kernel/cpu/centaur.c                       |    4=20
 arch/x86/kernel/cpu/common.c                        |   10=20
 arch/x86/kernel/cpu/cyrix.c                         |    2=20
 arch/x86/kernel/cpu/intel.c                         |   31 -
 arch/x86/kernel/cpu/microcode/intel.c               |    6=20
 arch/x86/kernel/cpu/mtrr/generic.c                  |    2=20
 arch/x86/kernel/cpu/mtrr/main.c                     |    4=20
 arch/x86/kernel/cpu/proc.c                          |    8=20
 arch/x86/kernel/head_32.S                           |    4=20
 arch/x86/kernel/mpparse.c                           |    2=20
 arch/x86/kvm/mmu.c                                  |   10=20
 arch/x86/kvm/vmx.c                                  |    4=20
 arch/x86/lib/cpu.c                                  |    2=20
 drivers/char/hw_random/via-rng.c                    |    2=20
 drivers/cpufreq/acpi-cpufreq.c                      |    2=20
 drivers/cpufreq/longhaul.c                          |    6=20
 drivers/cpufreq/p4-clockmod.c                       |    2=20
 drivers/cpufreq/powernow-k7.c                       |    2=20
 drivers/cpufreq/powernv-cpufreq.c                   |    4=20
 drivers/cpufreq/speedstep-centrino.c                |    4=20
 drivers/cpufreq/speedstep-lib.c                     |    6=20
 drivers/crypto/padlock-aes.c                        |    2=20
 drivers/devfreq/devfreq.c                           |    2=20
 drivers/edac/amd64_edac.c                           |    2=20
 drivers/edac/mce_amd.c                              |    2=20
 drivers/gpu/drm/radeon/radeon_uvd.c                 |    2=20
 drivers/gpu/drm/radeon/si_dpm.c                     |    5=20
 drivers/hwmon/coretemp.c                            |    6=20
 drivers/hwmon/hwmon-vid.c                           |    2=20
 drivers/hwmon/k10temp.c                             |    2=20
 drivers/hwmon/k8temp.c                              |    2=20
 drivers/infiniband/hw/mlx4/main.c                   |   13=20
 drivers/infiniband/hw/qib/qib_rc.c                  |    6=20
 drivers/infiniband/sw/rxe/rxe_verbs.c               |    2=20
 drivers/md/dm.c                                     |    3=20
 drivers/media/tuners/r820t.c                        |   13=20
 drivers/mtd/nand/vf610_nfc.c                        |    6=20
 drivers/net/ethernet/marvell/mvpp2.c                |   11=20
 drivers/net/ethernet/mellanox/mlx4/qp.c             |    3=20
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c |    5=20
 drivers/net/wireless/realtek/rtlwifi/wifi.h         |    1=20
 drivers/pci/host/pci-keystone.c                     |    5=20
 drivers/rtc/rtc-opal.c                              |   12=20
 drivers/scsi/smartpqi/Makefile                      |    2=20
 drivers/target/iscsi/iscsi_target_auth.c            |    3=20
 drivers/usb/Kconfig                                 |    8=20
 drivers/usb/host/Kconfig                            |    8=20
 drivers/video/console/dummycon.c                    |    1=20
 drivers/video/fbdev/atmel_lcdfb.c                   |    8=20
 drivers/video/fbdev/geode/video_gx.c                |    2=20
 fs/btrfs/inode.c                                    |    7=20
 fs/btrfs/tree-log.c                                 |   32 +
 fs/ext4/inode.c                                     |   16=20
 fs/ext4/super.c                                     |    1=20
 fs/jbd2/transaction.c                               |    5=20
 fs/mbcache.c                                        |    1=20
 fs/namei.c                                          |    3=20
 fs/ocfs2/dlmglue.c                                  |    9=20
 include/linux/compiler-gcc.h                        |    4=20
 include/linux/compiler.h                            |    4=20
 include/linux/jbd2.h                                |  431 ++++++++++++---=
-----
 include/linux/kaiser.h                              |    2=20
 include/linux/nospec.h                              |   36 -
 kernel/memremap.c                                   |    3=20
 mm/memory.c                                         |    2=20
 net/9p/trans_virtio.c                               |    3=20
 sound/core/seq/seq_clientmgr.c                      |    8=20
 sound/pci/hda/patch_realtek.c                       |   70 +++
 sound/usb/mixer.c                                   |   18=20
 sound/usb/pcm.c                                     |    9=20
 tools/testing/selftests/vm/compaction_test.c        |    2=20
 tools/testing/selftests/x86/Makefile                |    2=20
 tools/testing/selftests/x86/mpx-mini-test.c         |   32 +
 tools/testing/selftests/x86/protection_keys.c       |   28 -
 tools/testing/selftests/x86/single_step_syscall.c   |    5=20
 tools/testing/selftests/x86/test_mremap_vdso.c      |    4=20
 109 files changed, 757 insertions(+), 416 deletions(-)

Alex Deucher (1):
      drm/radeon: Add dpm quirk for Jet PRO (v2)

Alexander Potapenko (1):
      mbcache: initialize entry->e_referenced in mb_cache_entry_create()

Arnd Bergmann (9):
      mm: hide a #warning for COMPILE_TEST
      kselftest: fix OOM in memory compaction test
      ARM: lpc3250: fix uda1380 gpio numbers
      ARM: dts: nomadik: add interrupt-parent for clcd
      x86: fix build warnign with 32-bit PAE
      ARM: dts: exynos: fix RTC interrupt for exynos5410
      ARM: pxa/tosa-bt: add MODULE_LICENSE tag
      ARM: dts: s5pv210: add interrupt-parent for ohci
      media: r820t: fix r820t_write_reg for KASAN

Bart Van Assche (1):
      RDMA/rxe: Fix a race condition related to the QP error state

Bjorn Andersson (3):
      PM / devfreq: Propagate error from devfreq_add_device()
      arm64: dts: msm8916: Correct ipc references for smsm
      arm64: dts: msm8916: Add missing #phy-cells

Corentin Labbe (1):
      MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN

Dan Carpenter (1):
      x86/spectre: Fix an error message

Dan Williams (2):
      x86/entry/64/compat: Clear registers for compat syscalls, to reduce s=
peculation attack surface
      x86/speculation: Fix up array_index_nospec_mask() asm constraint

David Disseldorp (1):
      target/iscsi: avoid NULL dereference in CHAP auth error path

David Woodhouse (3):
      x86/speculation: Update Speculation Control microcode blacklist
      x86/speculation: Correct Speculation Control microcode blacklist again
      KVM/x86: Reduce retpoline performance impact in slot_handle_level_ran=
ge(), by always inlining iterator helper methods

Dominik Brodowski (2):
      selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
      selftests/x86: Do not rely on "int $0x80" in single_step_syscall.c

Ernesto A. Fern=E1ndez (1):
      ext4: correct documentation for grpid mount option

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Gang He (1):
      ocfs2: try a blocking lock before return AOP_TRUNCATED_PAGE

Geert Uytterhoeven (1):
      compiler-gcc.h: Introduce __optimize function attribute

Greg Kroah-Hartman (1):
      Linux 4.9.83

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

Gustavo A. R. Silva (1):
      x86/cpu: Change type of x86_cache_size variable to unsigned int

Harshad Shirwadkar (1):
      ext4: fix a race in the ext4 shutdown path

Hui Wang (1):
      ALSA: hda - Fix headset mic detection problem for two Dell machines

Ingo Molnar (2):
      x86/speculation: Clean up various Spectre related details
      selftests/x86/pkeys: Remove unused functions

Jack Morgenstein (1):
      IB/mlx4: Fix incorrectly releasing steerable UD QPs when have only ET=
H ports

James Hogan (1):
      usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT

Jan H. Sch=F6nherr (1):
      mm: Fix memory size alignment in devm_memremap_pages_release()

Jan-Marek Glogowski (1):
      ALSA: hda/realtek: PCI quirk for Fujitsu U7x7

Jia Zhang (1):
      x86/cpu: Rename cpu_data.x86_mask to cpu_data.x86_stepping

Johan Hovold (2):
      PCI: keystone: Fix interrupt-controller-node lookup
      video: fbdev: atmel_lcdfb: fix display-timings lookup

Julia Lawall (1):
      drm/radeon: adjust tested variable

Kailang Yang (1):
      ALSA: hda/realtek - Enable Thinkpad Dock device for ALC298 platform

KarimAllah Ahmed (1):
      X86/nVMX: Properly set spec_ctrl and pred_cmd before merging MSRs

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix UAC2 get_ctl request with a RANGE attribute

Larry Finger (1):
      rtlwifi: rtl8821ae: Fix connection lost problem correctly

Lassi Ylikojola (1):
      ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204

Linus Torvalds (1):
      vfs: don't do RCU lookup of empty pathnames

Linus Walleij (1):
      ARM: dts: Delete bogus reference to the charlcd

Liu Bo (5):
      Btrfs: fix deadlock in run_delalloc_nocow
      Btrfs: fix crash due to not cleaning up tree log block's dirty bits
      Btrfs: fix extent state leak from tree log
      Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
      Btrfs: fix unexpected -EEXIST when creating new inode

Matthias Brugger (1):
      arm: dts: mt2701: Add reset-cells

Mike Marciniszyn (1):
      IB/qib: Fix comparison error with qperf compare/swap test

Mikulas Patocka (1):
      mvpp2: fix multicast address filter

NeilBrown (1):
      dm: correctly handle chained bios in dec_pending()

Nicholas Piggin (1):
      powerpc: fix build errors in stable tree

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Patrice Chotard (1):
      ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property

Peter Zijlstra (1):
      x86/speculation: Add <asm/msr-index.h> dependency

Rui Wang (1):
      selftests/x86/mpx: Fix incorrect bounds with old _sigfault

Shilpasri G Bhat (1):
      cpufreq: powernv: Dont assume distinct pstate values for nominal and =
pmin

Stefan Agner (1):
      mtd: nand: vf610: set correct ooblayout

Steffen Weber (1):
      scsi: smartpqi: allow static build ("built-in")

Stewart Smith (1):
      rtc-opal: Fix handling of firmware error codes, prevent busy loops

Takashi Iwai (1):
      ALSA: seq: Fix racy pool initializations

Tobin C. Harding (1):
      jbd2: fix sphinx kernel-doc build warnings

Viresh Kumar (3):
      arm: spear600: Add missing interrupt-parent of rtc
      arm: spear13xx: Fix dmas cells
      arm: spear13xx: Fix spics gpio controller's warning

Will Deacon (1):
      nospec: Move array_index_nospec() parameter checking into separate ma=
cro

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqPw8UACgkQONu9yGCS
aT5NRxAApWY1FDvPlX7vNcOVZZaPyl1BqVoGqslWLcnRJjoVcJlFgoC/LeanIWDU
q19iZQpRkblhQhUGTDCf+sw/XPLG3sYjVy09bFO9p/3s+ZTwcdgx0hL4tsy8yM/h
8Wv96E5L9VlwhratPp1EawDyu8OjXlxio3MyaHy9SwiIOEGZkJ2RVX7AP0SMwPn/
KjLyCJM3IHWKjoIhsASyuVatK/wp8i63ksQ2t82xk5Vr/FHANgzfNeKnaC0oqED3
Qf5DypWK7tBUUAjz9BZLrAagn+Lgg+aW3W/exZj3orjtynqa6HX3RDiGcVwX2Z/L
d19D3B6jSE/bAkyt69/N414tE96atrWrcor48uy4GnE77XyeI7xqQ27bOXg+EAXi
Q2rwzvyWJMkk0AebBoHvgGibTi+pydsskBek5CxvWMNXBUnLMcO30rNaqyxVi1xY
59ZpSUX5ytSQXwwju10gGmw2uUcB2tLSa8StRUap/ARCq49lGVV9D8yVV1IVMM33
ohQpwlWclD0P2AduuO4URMVaBwHmIq4x04wMA8f4brDeTopjBQQZa5Zmn3gJfhxM
0DqrZXqRk/Jxb2H3bGXC/hNB+uXbn/Pgo6J9ZrVDDD1wyQxrs4aiNTDb7U/cjDhv
DE1b0hkDOanN+wgq1uAF+KMWjrY0ixr/gyfATTeMn6x5dCUpkaw=
=Q/rA
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
