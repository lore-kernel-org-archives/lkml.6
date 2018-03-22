Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2313652-1521709776-2-3720025230607471003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
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
    t=1521709771; b=LJzFpROKmb+rrEhW3t604p7oDNUljyuthn5CEP1pO32mkRl
    cmIttObNND/WpWUCLBQpgy5jeEtCtIKE+0I8gNMqApZ/x+xroITMdDKURGSRxnsf
    kuY7eyZNoDExu/gePXx6j67JgEZlOyy6IXhDQUE7O0Yf3VVPCOvmYBOk/TdwgXyJ
    zCdVe6jeH98QdtEF2WtnTwLK42tg0mjOxNT/66F+Wyd1K1S8RGqhVD7M9VD6Il6n
    n6Q5kBtFPF5rD7h3XzyLZD1/OHMeOMcaLJRHcy8L+r9kjsGVKsKE734Ogsrs0Lob
    T/s+uOZo0DQ1U7OsNXeUIUL6g9SmKRJdlYpzjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521709771; bh=yoplK+Lk4zkC1VAe14YBVWWfWaJlPykVOybCLdQOuyw=; b=g
    rlNHnxSYIrXObqVVYqBdJy6KlIy9zhwbN+R/vpCu0KAbhl+wJI9ExO3U25NLcF1m
    wiX2tbNK8JpOJXLnNWJ4UqHaJQtRaabY1FJuiMpac5P7XUlHtl1y06XWSqJ8edeR
    t4ucbCsmZ/g1DBPLV9HfzpPQwYFYj5KtUngq1cEHE4vyDVcuCspZtm0zSend83vi
    uIgGwAKl64/bKX8un+El9OQbPTc8Eg2/qwG440xEhaBt9BO5998tLzzOMsdhDcdq
    opvk9vMGNRiUAnD4jP7yuOLcS8rejkubUgx6Bf5WkDKKvOwbPMgjweIkmI5+OdCR
    AEwXgKcuGdLjqzpLQntyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeCVJGz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 05:06:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753637AbeCVJDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 05:03:22 -0400
Date: Thu, 22 Mar 2018 10:03:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.123
Message-ID: <20180322090319.GA18536@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.123 kernel.

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

 Makefile                                             |    2=20
 arch/arm/boot/dts/am335x-pepper.dts                  |    2=20
 arch/arm/boot/dts/exynos4412-trats2.dts              |    2=20
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi           |    8 +
 arch/arm/boot/dts/moxart-uc7112lx.dts                |    2=20
 arch/arm/boot/dts/moxart.dtsi                        |   17 +-
 arch/arm/boot/dts/omap3-n900.dts                     |    4=20
 arch/arm/boot/dts/r8a7790.dtsi                       |    7 -
 arch/arm/boot/dts/r8a7791-koelsch.dts                |    2=20
 arch/arm/boot/dts/r8a7791.dtsi                       |    7 -
 arch/mips/kernel/mips-r2-to-r6-emul.c                |   16 ++
 arch/mips/net/bpf_jit.c                              |   16 +-
 arch/mips/net/bpf_jit_asm.S                          |   23 +--
 arch/powerpc/mm/fault.c                              |    2=20
 arch/x86/kernel/kprobes/core.c                       |    6=20
 arch/x86/kernel/kprobes/opt.c                        |    3=20
 arch/x86/kernel/vm86_32.c                            |    3=20
 arch/x86/mm/fault.c                                  |    6=20
 block/blk-cgroup.c                                   |    4=20
 block/blk-throttle.c                                 |   11 +
 drivers/char/agp/intel-gtt.c                         |    2=20
 drivers/clk/qcom/gcc-msm8916.c                       |    1=20
 drivers/cpufreq/cpufreq.c                            |    6=20
 drivers/dma/imx-sdma.c                               |   17 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c       |   31 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c          |    6=20
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c            |   10 +
 drivers/gpu/drm/drm_edid.c                           |    9 +
 drivers/gpu/drm/drm_irq.c                            |   14 +-
 drivers/gpu/drm/qxl/qxl_fb.c                         |    9 +
 drivers/gpu/drm/radeon/radeon_display.c              |    6=20
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                   |    4=20
 drivers/hid/hid-elo.c                                |    6=20
 drivers/hid/hid-input.c                              |   20 ++-
 drivers/hwmon/pmbus/adm1275.c                        |    4=20
 drivers/hwtracing/coresight/of_coresight.c           |    2=20
 drivers/input/keyboard/qt1070.c                      |    9 +
 drivers/input/touchscreen/tsc2007.c                  |    8 +
 drivers/iommu/iova.c                                 |    2=20
 drivers/irqchip/irq-gic-v3-its.c                     |    9 -
 drivers/md/raid5.c                                   |   13 +-
 drivers/media/i2c/soc_camera/ov6650.c                |    2=20
 drivers/media/pci/solo6x10/solo6x10-v4l2.c           |   11 +
 drivers/media/usb/cpia2/cpia2_v4l.c                  |    4=20
 drivers/misc/enclosure.c                             |    7 -
 drivers/mtd/nand/nand_base.c                         |    9 +
 drivers/net/bonding/bond_main.c                      |   11 +
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c       |    1=20
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h       |    1=20
 drivers/net/ethernet/faraday/ftgmac100.c             |    1=20
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c     |    2=20
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c       |    5=20
 drivers/net/ethernet/intel/i40e/i40e_nvm.c           |   12 -
 drivers/net/ipvlan/ipvlan_core.c                     |    4=20
 drivers/net/veth.c                                   |    3=20
 drivers/net/vxlan.c                                  |    5=20
 drivers/net/wireless/ath/ath10k/debug.c              |    9 +
 drivers/net/wireless/ath/ath10k/mac.c                |   12 +
 drivers/net/wireless/ath/ath10k/wmi.h                |    3=20
 drivers/net/wireless/ath/wil6210/main.c              |   20 ++-
 drivers/net/wireless/mac80211_hwsim.c                |   17 +-
 drivers/nfc/nfcmrvl/fw_dnld.c                        |    2=20
 drivers/nfc/nfcmrvl/spi.c                            |    5=20
 drivers/of/device.c                                  |    2=20
 drivers/pci/pci-driver.c                             |    2=20
 drivers/perf/arm_pmu.c                               |   12 +
 drivers/pwm/pwm-tegra.c                              |    7 -
 drivers/scsi/ipr.c                                   |   16 +-
 drivers/scsi/scsi_devinfo.c                          |    9 -
 drivers/scsi/scsi_dh.c                               |    5=20
 drivers/scsi/ses.c                                   |    1=20
 drivers/scsi/sg.c                                    |   35 +++--
 drivers/spi/spi-omap2-mcspi.c                        |    9 -
 drivers/spi/spi-sun6i.c                              |    2=20
 drivers/staging/speakup/kobjects.c                   |    8 -
 drivers/staging/wilc1000/host_interface.c            |    2=20
 drivers/usb/dwc2/hcd.c                               |    1=20
 drivers/usb/gadget/udc/bdc/bdc_core.c                |    2=20
 drivers/usb/gadget/udc/bdc/bdc_pci.c                 |    1=20
 drivers/usb/gadget/udc/dummy_hcd.c                   |   20 +--
 drivers/video/fbdev/amba-clcd.c                      |    4=20
 drivers/video/hdmi.c                                 |   51 +++++---
 fs/aio.c                                             |   44 ++++---
 fs/btrfs/volumes.c                                   |   12 +
 fs/dcache.c                                          |   11 +
 fs/f2fs/gc.c                                         |    6=20
 fs/namei.c                                           |    5=20
 fs/nfs/super.c                                       |    2=20
 fs/reiserfs/journal.c                                |    2=20
 fs/reiserfs/reiserfs.h                               |    1=20
 fs/reiserfs/super.c                                  |   21 ++-
 include/linux/fs.h                                   |    1=20
 include/linux/pagemap.h                              |    4=20
 include/linux/platform_data/isl9305.h                |    2=20
 include/net/tcp.h                                    |    8 -
 kernel/bpf/verifier.c                                |    3=20
 kernel/printk/braille.c                              |   15 +-
 kernel/printk/braille.h                              |   13 +-
 kernel/sched/core.c                                  |    3=20
 kernel/sched/rt.c                                    |    2=20
 kernel/time/sched_clock.c                            |    5=20
 kernel/time/timer_list.c                             |    6=20
 net/8021q/vlan_dev.c                                 |    3=20
 net/batman-adv/bridge_loop_avoidance.c               |   20 ++-
 net/mac80211/iface.c                                 |    2=20
 net/sched/act_csum.c                                 |   12 +
 net/xfrm/xfrm_policy.c                               |    2=20
 net/xfrm/xfrm_state.c                                |    7 +
 security/apparmor/lsm.c                              |    2=20
 security/integrity/ima/ima_appraise.c                |    3=20
 security/selinux/hooks.c                             |    8 +
 sound/core/oss/pcm_oss.c                             |   10 -
 sound/core/seq/seq_clientmgr.c                       |    4=20
 sound/core/seq/seq_prioq.c                           |   28 ++--
 sound/core/seq/seq_prioq.h                           |    6=20
 sound/core/seq/seq_queue.c                           |   28 +---
 sound/firewire/digi00x/amdtp-dot.c                   |   55 ++++++--
 sound/pci/hda/hda_intel.c                            |    9 -
 sound/soc/nuc900/nuc900-ac97.c                       |    4=20
 sound/soc/sh/rcar/ssi.c                              |    9 +
 tools/perf/builtin-probe.c                           |    6=20
 tools/perf/util/event.c                              |    4=20
 tools/perf/util/ordered-events.c                     |    3=20
 tools/perf/util/session.c                            |   17 ++
 tools/perf/util/sort.c                               |    5=20
 tools/testing/selftests/firmware/fw_filesystem.sh    |    5=20
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2=20
 tools/testing/selftests/x86/entry_from_vm86.c        |  117 ++++++++++++++=
++++-
 tools/usb/usbip/src/usbipd.c                         |    2=20
 129 files changed, 868 insertions(+), 337 deletions(-)

Aaron Salter (1):
      i40e: Acquire NVM lock before reads on all devices

Adam Ford (1):
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Adiel Aloni (1):
      mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED

Akinobu Mita (1):
      spi: omap2-mcspi: poll OMAP2_MCSPI_CHSTAT_RXS for PIO transfer

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Aleksandar Markovic (1):
      MIPS: r2-on-r6-emu: Clear BLTZALL and BGEZALL debugfs counters

Alexander Potapenko (1):
      selinux: check for address length in selinux_socket_bind()

Andreas Pape (1):
      batman-adv: handle race condition for claims between gateways

Andrew F. Davis (2):
      ARM: dts: am335x-pepper: Fix the audio CODEC's reset pin
      ARM: dts: omap3-n900: Fix the audio CODEC's reset pin

Andrew Lunn (1):
      net/faraday: Add missing include of of.h

Andrey Vagin (1):
      net/8021q: create device with all possible features in wanted_features

Andy Lutomirski (3):
      selftests/x86/entry_from_vm86: Exit with 1 if we fail
      selftests/x86/entry_from_vm86: Add test cases for POPF
      x86/vm86/32: Fix POPF emulation

Anton Blanchard (1):
      powerpc: Avoid taking a data miss on every userspace instruction miss

Anton Sviridenko (1):
      solo6x10: release vb2 buffers in solo_stop_streaming()

Ard Biesheuvel (1):
      irqchip/gic-v3-its: Ensure nr_ites >=3D nr_lpis

Bart Van Assche (1):
      scsi: core: scsi_get_device_flags_keyed(): Always return device flags

Ben Greear (1):
      ath10k: fix invalid STS_CAP_OFFSET_MASK

Brian King (1):
      scsi: ipr: Fix missed EH wakeup

Changbin Du (1):
      perf sort: Fix segfault with basic block 'cycles' sort dimension

Chris Wilson (2):
      drm: Defer disabling the vblank IRQ until the next interrupt (for ins=
tant-off)
      agp/intel: Flush all chipset writes after updating the GGTT

Christopher James Halse Rogers (2):
      drm/radeon: Fail fb creation from imported dma-bufs.
      drm/amdgpu: Fail fb creation from imported dma-bufs. (v2)

Colin Ian King (1):
      staging: wilc1000: add check for kmalloc allocation failure.

Dan Carpenter (3):
      NFC: nfcmrvl: double free on error path
      media: cpia2: Fix a couple off by one bugs
      ASoC: nuc900: Fix a loop timeout test

David Carrillo-Cisneros (2):
      perf inject: Copy events when reordering events in pipe mode
      perf session: Don't rely on evlist in pipe mode

David Daney (2):
      MIPS: BPF: Quit clobbering callee saved registers in JIT code.
      MIPS: BPF: Fix multiple problems in JIT skb access helpers.

David Engraf (1):
      timers, sched_clock: Update timeout for clock wrap

Davide Caratti (1):
      sched: act_csum: don't mangle TCP and UDP GSO packets

Dedy Lansky (1):
      wil6210: fix memory access violation in wil_memcpy_from/toio_32

Eric Dumazet (1):
      bonding: refine bond_fold_stats() wrap detection

Eric W. Biederman (1):
      fs: Teach path_connected to handle nfs filesystems with multiple root=
s.

Felix Manlunas (1):
      vxlan: vxlan dev should inherit lowerdev's gso_max_size

Gabriel Krisman Bertazi (1):
      drm: qxl: Don't alloc fbdev if emulation is not supported

Gao Feng (1):
      tcp: sysctl: Fix a race to avoid unexpected 0 window from space

Geert Uytterhoeven (3):
      ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
      ARM: dts: koelsch: Correct clock frequency of X2 DU clock input

Greg Kroah-Hartman (1):
      Linux 4.4.123

H. Nikolaus Schaller (1):
      Input: tsc2007 - check for presence and power down tsc2007 during pro=
be

Hannes Reinecke (1):
      scsi: sg: close race condition in sg_remove_sfp_usercontext()

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling

Hou Tao (1):
      blkcg: fix double free of new_blkg in blkcg_init_queue

Jaegeuk Kim (1):
      f2fs: relax node version check for victim data in gc

Jan Kara (1):
      reiserfs: Make cancel_old_flush() reliable

Jani Nikula (1):
      drm/edid: set ELD connector type in drm_edid_to_eld()

Jann Horn (1):
      bpf: fix incorrect sign extension in check_alu_op()

Janusz Krzysztofik (1):
      media: i2c/soc_camera: fix ov6650 sensor getting wrong clock

Javier Martinez Canillas (1):
      Input: qt1070 - add OF device ID table

Jiada Wang (1):
      dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped

Jiri Kosina (1):
      HID: elo: clear BTN_LEFT mapping

Johannes Thumshirn (4):
      scsi: sg: check for valid direction before starting the request
      scsi: sg: fix SG_DXFER_FROM_DEV transfers
      scsi: sg: fix static checker warning in sg_is_valid_dxfer
      scsi: sg: only check for dxfer_len greater than 256M

John Johansen (1):
      apparmor: Make path_max parameter readonly

John Stultz (1):
      usb: dwc2: Make sure we disconnect the gadget state

Julien BOIBESSOT (1):
      tools/usbip: fixes build with musl libc toolchain

Kefeng Wang (1):
      perf probe: Return errno when not hitting any event

Kirill A. Shutemov (1):
      mm: Fix false-positive VM_BUG_ON() in page_cache_{get,add}_speculativ=
e()

Kuninori Morimoto (1):
      ASoC: rcar: ssi: don't set SSICR.CKDV =3D 000 with SSIWSR.CONT

Laxman Dewangan (1):
      pwm: tegra: Increase precision in PWM rate calculation

Leonid Yegoshin (1):
      MIPS: r2-on-r6-emu: Fix BLEZL and BGTZL identification

Liam Beguin (1):
      video: ARM CLCD: fix dma allocation size

Lihong Yang (1):
      i40e: fix ethtool to get EEPROM data from X722 interface

Linus Walleij (1):
      ARM: dts: Adjust moxart IRQ controller and flags

Lorenzo Colitti (1):
      net: xfrm: allow clearing socket xfrm policies.

Luca Coelho (1):
      mac80211: remove BUG() when interface type is invalid

Luis R. Rodriguez (1):
      test_firmware: fix setting old custom fw path back on exit

Mahesh Bandewar (1):
      ipvlan: add L2 check for packets arriving via virtual devices

Manikanta Pubbisetty (1):
      ath10k: update tdls teardown state to target

Mark Rutland (1):
      drivers/perf: arm_pmu: handle no platform_device

Masami Hiramatsu (2):
      kprobes/x86: Fix kprobe-booster not to boost far call instructions
      kprobes/x86: Set kprobes pages read-only

Mauricio Faria de Oliveira (1):
      scsi: ses: don't get power status of SES device slot on probe

Michel D=E4nzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

Mike Leach (1):
      coresight: Fixes coresight DT parse to get correct output port ID.

Mimi Zohar (1):
      ima: relax requiring a file signature for new files with zero length

Miquel Raynal (1):
      mtd: nand: fix interpretation of NAND_CMD_NONE in nand_command[_lp]()

Mohammed Shafi Shajakhan (2):
      ath10k: fix a warning during channel switch with multiple vaps
      ath10k: disallow DFS simulation if DFS channel is not enabled

Nate Watterson (1):
      iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range

NeilBrown (1):
      md/raid6: Fix anomily when recovering a single device in RAID6.

Nikolay Borisov (1):
      btrfs: Fix use-after-free when cleaning up fs_devs with a single stal=
e device

Paul E. McKenney (2):
      sched: Stop switched_to_rt() from sending IPIs to offline CPUs
      sched: Stop resched_cpu() from sending IPIs to offline CPUs

Phil Turnbull (1):
      fm10k: correctly check if interface is removed

Prarit Bhargava (1):
      PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()

Quan Nguyen (1):
      drivers: net: xgene: Fix hardware checksum setting

Rafael J. Wysocki (1):
      cpufreq: Fix governor module removal race

Ricardo Neri (2):
      selftests/x86: Add tests for User-Mode Instruction Prevention
      selftests/x86: Add tests for the STR and SLDT instructions

Rob Herring (1):
      of: fix of_device_get_modalias returned length when truncating buffers

Samuel Thibault (1):
      braille-console: Fix value returned by _braille_console_setup

SeongJae Park (1):
      rcutorture/configinit: Fix build directory error message

Shaohua Li (1):
      blk-throttle: make sure expire time isn't too big

Shikhar Dogra (1):
      driver: (adm1275) set the m,b and R coefficients correctly for power

Simon Shields (1):
      ARM: dts: exynos: Correct Trats2 panel reset line

Sinclair Yeh (1):
      drm/vmwgfx: Fixes to vmwgfx_fb

Srinath Mannam (1):
      usb: gadget: bdc: 64-bit pointer capability check

Srinivas Kandagatla (1):
      clk: qcom: msm8916: fix mnd_width for codec_digcodec

Stephane Eranian (1):
      perf tools: Make perf_event__synthesize_mmap_events() scale

Stephen Hemminger (1):
      veth: set peer GSO values

Takashi Iwai (4):
      ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
      ALSA: hda - Revert power_save option default value
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing

Takashi Sakamoto (1):
      ALSA: firewire-digi00x: handle all MIDI messages on streaming packets

Tejun Heo (2):
      fs/aio: Add explicit RCU grace period when freeing kioctx
      fs/aio: Use RCU accessors for kioctx_table->table[]

Tobias Jordan (1):
      spi: sun6i: disable/unprepare clocks on remove

Tobias Klauser (1):
      NFC: nfcmrvl: Include unaligned.h instead of access_ok.h

Tom Hromatka (1):
      sysrq: Reset the watchdog timers while displaying high-resolution tim=
ers

Tomasz Kramkowski (1):
      HID: clamp input to logical range if no null state

Toshi Kani (1):
      x86/mm: Fix vmalloc_fault to use pXd_large

Valtteri Heikkil=E4 (1):
      HID: reject input outside logical range only if null state is set

Varsha Rao (1):
      staging: speakup: Replace BUG_ON() with WARN_ON().

Ville Syrj=E4l=E4 (1):
      video/hdmi: Allow "empty" HDMI infoframes

Vincent Stehl=E9 (1):
      regulator: isl9305: fix array size

Wei Yongjun (1):
      USB: gadget: udc: Add missing platform_device_put() on error in bdc_p=
ci_probe()

Xose Vazquez Perez (2):
      scsi: devinfo: apply to HP XP the same flags as Hitachi VSP
      scsi: dh: add new rdac devices

Yong Zhao (1):
      drm/amdkfd: Fix memory leaks in kfd topology

Yuyang Du (1):
      usb: gadget: dummy_hcd: Fix wrong power status bit clear/reset in dum=
my_hub_control()


--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqzcVYACgkQONu9yGCS
aT5K0xAApyBC+N6klZVgETdJxAJvI4vmBzZ07rDSJ4WAP0v+KJjjpO/fo+jqCp/C
Mtm9fZddbXulhlFuef5xtbCN0H9d9hoSfK6MQs5GsmgFc1PyiUW/Bicpal17+X9E
CSQoMn+VLhBrkxRaQRLoK9ElZJ3CFGypglnvJyp34ff/RJ3bhp7D8LmuGmveIXQy
9QMuC+J3ToKMbjafV/bMmXGX5Rn0WuX/WX1C+wZJN+8m9+xcVgYxNYVOV36C48jV
i1h3UqfpJtFwIZTSv1TuD98sE3hAGyfwWytsSg3RnE14A8TNzYdHgro3Y4Ng9qvc
M6fH18qhTwJVuDFcp+wrJPrQyQbYUsyki4r8toOj36dqo/jhu4/Ol79840xVs5/m
o3nm6l+wsD5BjTAEUzQoK/p1Tw/fhmvPNGKXgXuarSdBKg9Sw/7/p6VWG79swlZD
ot/iMvUJKB6RyR7TZspnYi0oWBFufXu4hns70Vd5aHY/gg/lP/+xaRO/yFYH3WLK
gcpbXJHN7Asm52TTyLfLMgf4PfFvuuBHa0d5VxsDEshQaPr1a2vXsMA6dnoPlzrG
xchKzXJOb794ldcvXIrkQ4Te3YLCs6TPjEi8vCxHASNKYMwELtMpBeFQ/uoMthRY
4XR5bqV6cvSPf7XTXpqB0DMJOSI7u3gxvPs8cOQvMgjbCnBPfAc=
=9NAN
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
