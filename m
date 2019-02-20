Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480BC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0752089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656614;
	bh=qUV35rQWAT+TTdYeumm7xP/SmZwxyNLGH6Smk+/YLts=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mj2QLfKx6tXhSmbwjaaBBcq0zdtzqEv6qvboce/yOx1QJt8cuiVmYlxTBxinivdkU
	 0Ls09Q+ch4fiZIyZLqKWe/c0TJsc8IZivHE8Y1keqFZRaQO61+8q0gVuJXZNcaTa4N
	 dDlegJ3g/AhgkoegYswKkIp2TW98vFJ04lO6tXMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfBTJ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:56:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBTJ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:56:53 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F34182089F;
        Wed, 20 Feb 2019 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656611;
        bh=qUV35rQWAT+TTdYeumm7xP/SmZwxyNLGH6Smk+/YLts=;
        h=Date:From:To:Cc:Subject:From;
        b=aJxzjMk/8Q8BEAr+kRsg6eGUgwM2ovv/qHxZp0KXP+G0xRVLWsCRAPGtPIX1rdRxp
         n1SrFtde3R59x5jagR0ZSPcXYMufXAna0XOUFXPOIkRKC0n4ovbhq+5Xp9hQYPJvlr
         3LaE/pSGuWkg9OdXbh2U6dMUil2Yh0njVbnRjm5k=
Date:   Wed, 20 Feb 2019 10:56:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.11
Message-ID: <20190220095647.GA15350@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.11 kernel.

All users of the 4.20 kernel series must upgrade.

The updated 4.20.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.20.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/eeprom/at24.txt  |    1=20
 Makefile                                           |    2=20
 arch/alpha/include/asm/irq.h                       |    6 -
 arch/alpha/mm/fault.c                              |    2=20
 arch/arm/boot/dts/da850-evm.dts                    |   31 +++++++-
 arch/arm/boot/dts/da850-lcdk.dts                   |   38 ++++++++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |    4 -
 arch/arm/boot/dts/omap5-board-common.dtsi          |    9 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   12 +++
 arch/arm/mach-integrator/impd1.c                   |    6 +
 arch/arm/mach-omap2/omap-wakeupgen.c               |   36 +++++++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    2=20
 arch/csky/include/asm/io.h                         |   25 ++++++
 arch/csky/kernel/module.c                          |   38 ++++++----
 arch/powerpc/include/asm/book3s/64/pgtable.h       |    4 -
 arch/riscv/include/asm/pgtable-bits.h              |    6 +
 arch/riscv/include/asm/pgtable.h                   |    8 +-
 arch/riscv/kernel/ptrace.c                         |    2=20
 arch/s390/kernel/swsusp.S                          |    4 -
 arch/x86/events/core.c                             |   14 +++
 arch/x86/events/intel/core.c                       |    9 ++
 arch/x86/events/perf_event.h                       |   16 +++-
 arch/x86/ia32/ia32_aout.c                          |    6 +
 arch/x86/include/asm/uv/bios.h                     |    8 +-
 arch/x86/kvm/svm.c                                 |    3=20
 arch/x86/kvm/vmx.c                                 |   11 +--
 arch/x86/platform/uv/bios_uv.c                     |   23 +++++-
 block/blk-flush.c                                  |    2=20
 drivers/acpi/numa.c                                |    6 -
 drivers/cpufreq/cpufreq.c                          |   12 +--
 drivers/crypto/ccree/cc_driver.c                   |    7 +
 drivers/crypto/ccree/cc_pm.c                       |   13 +--
 drivers/crypto/ccree/cc_pm.h                       |    3=20
 drivers/firmware/efi/runtime-wrappers.c            |    7 +
 drivers/gpio/gpio-mxc.c                            |   41 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    3=20
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   10 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |    2=20
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |    3=20
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c |   14 +++
 drivers/gpu/drm/bridge/tc358767.c                  |   45 +++++++++---
 drivers/gpu/drm/drm_lease.c                        |    3=20
 drivers/gpu/drm/i915/i915_gem.c                    |   12 +++
 drivers/gpu/drm/i915/intel_drv.h                   |   10 ++
 drivers/gpu/drm/i915/intel_fbdev.c                 |   33 ++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c       |    7 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |    7 +
 drivers/gpu/drm/scheduler/sched_entity.c           |    7 -
 drivers/gpu/drm/vkms/vkms_crc.c                    |    3=20
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    8 --
 drivers/gpu/drm/vkms/vkms_drv.c                    |    7 -
 drivers/gpu/drm/vkms/vkms_drv.h                    |    2=20
 drivers/gpu/drm/vkms/vkms_gem.c                    |    8 --
 drivers/gpu/drm/vkms/vkms_output.c                 |    8 --
 drivers/gpu/drm/vkms/vkms_plane.c                  |    8 --
 drivers/input/misc/bma150.c                        |    9 +-
 drivers/input/mouse/elan_i2c_core.c                |    2=20
 drivers/input/mouse/elantech.c                     |    9 ++
 drivers/irqchip/irq-csky-apb-intc.c                |   77 +++++++++++-----=
-----
 drivers/md/dm-crypt.c                              |    2=20
 drivers/md/dm-thin.c                               |   55 +++++++++++++--
 drivers/md/raid1.c                                 |   28 ++++---
 drivers/misc/eeprom/Kconfig                        |    2=20
 drivers/misc/eeprom/at24.c                         |    3=20
 drivers/mmc/core/block.c                           |   10 ++
 drivers/mmc/host/sunxi-mmc.c                       |   26 ++++++-
 drivers/nvme/host/core.c                           |   18 ++--
 drivers/nvme/host/multipath.c                      |    2=20
 drivers/nvme/host/nvme.h                           |    5 +
 drivers/nvme/host/pci.c                            |   16 +++-
 drivers/s390/crypto/ap_bus.c                       |    3=20
 drivers/scsi/sd.c                                  |   12 ++-
 drivers/soc/renesas/r8a774c0-sysc.c                |   23 +-----
 fs/cifs/cifsglob.h                                 |   20 +++++
 fs/cifs/cifssmb.c                                  |    7 +
 fs/cifs/file.c                                     |   37 ++++++++--
 fs/cifs/inode.c                                    |   10 ++
 fs/cifs/smb2file.c                                 |    4 +
 fs/cifs/smb2inode.c                                |   17 ++++
 fs/cifs/smb2ops.c                                  |    6 +
 fs/cifs/smb2pdu.c                                  |   15 +++-
 fs/cifs/transport.c                                |   58 ++++++++++++---
 fs/inode.c                                         |    7 -
 fs/nfsd/nfsctl.c                                   |    4 -
 fs/proc/task_mmu.c                                 |   22 +++---
 include/linux/mmc/card.h                           |    1=20
 include/linux/perf_event.h                         |    5 +
 kernel/events/core.c                               |   16 ++++
 kernel/events/ring_buffer.c                        |    2=20
 kernel/signal.c                                    |    7 +
 kernel/trace/trace_probe_tmpl.h                    |    6 +
 mm/vmscan.c                                        |   10 --
 net/sunrpc/auth_gss/gss_krb5_seqnum.c              |   49 ++++++++++---
 sound/core/pcm_lib.c                               |   20 +----
 sound/pci/hda/patch_conexant.c                     |    1=20
 sound/soc/codecs/hdmi-codec.c                      |    4 -
 sound/usb/pcm.c                                    |    9 ++
 tools/arch/riscv/include/uapi/asm/bitsperlong.h    |   25 ++++++
 tools/include/uapi/asm/bitsperlong.h               |    4 +
 tools/perf/builtin-stat.c                          |    3=20
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    3=20
 tools/perf/util/callchain.c                        |   32 +++++---
 tools/perf/util/callchain.h                        |    1=20
 tools/perf/util/machine.c                          |    2=20
 105 files changed, 972 insertions(+), 362 deletions(-)

Adrian Bunk (2):
      dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
      eeprom: at24: add support for 24c2048

Andreas Ziegler (1):
      tracing: probeevent: Correctly update remaining space in dynamic area

Anson Huang (1):
      gpio: mxc: move gpio noirq suspend/resume to syscore phase

Arnaldo Carvalho de Melo (1):
      perf test shell: Use a fallback to get the pathname in vfs_getname

Aurelien Jarno (1):
      tools uapi: fix RISC-V 64-bit support

Biju Das (1):
      soc: renesas: r8a774c0-sysc: Fix initialization order of 3DG-{A,B}

Bob Tracy (1):
      tools uapi: fix Alpha support

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Chen-Yu Tsai (2):
      mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
      mmc: sunxi: Filter out unsupported modes declared in the device tree

Christian K=F6nig (1):
      drm/amdgpu: disable system memory page tables for now

Dave Chinner (2):
      Revert "mm: don't reclaim inodes with many attached pages"
      Revert "mm: slowly shrink slabs with a relatively small number of obj=
ects"

David Abdurachmanov (1):
      riscv: fix trace_sys_exit hook

David Rientjes (1):
      kvm: sev: Fail KVM_SEV_INIT if already initialized

Dmitry Torokhov (1):
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-=
573G"

Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-ro=
ck64

Emily Deng (1):
      drm/amdgpu/sriov:Correct pfvf exchange logic

Eric Anholt (1):
      drm/sched: Always trace the dependencies we wait on, to fix a race.

Eric W. Biederman (1):
      signal: Restore the stop PTRACE_EVENT_EXIT

Evan Quan (1):
      drm/amd/powerplay: avoid possible buffer overflow

Gilad Ben-Yossef (1):
      crypto: ccree - fix resume race condition on init

Greg Kroah-Hartman (1):
      Linux 4.20.11

Guo Ren (4):
      csky: fixup relocation error with 807 & 860
      csky: fixup CACHEV1 store instruction fast retire
      irqchip/csky: fixup handle_irq_perbit break irq
      csky: fixup compile error with CPU 810.

Hannes Reinecke (1):
      nvme-multipath: zero out ANA log buffer

Harald Freudenberger (1):
      s390/zcrypt: fix specification exception on z196 during ap probe

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Hongbo Yao (1):
      nvme-pci: fix out of bounds access in nvme_cqe_pending

Ilia Mirkin (1):
      drm/nouveau/falcon: avoid touching registers if engine is off

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

J. Bruce Fields (1):
      Revert "nfsd4: return default lease period"

James Bottomley (1):
      scsi: sd: fix entropy gathering for most rotational disks

James Dingwall (1):
      nvme: introduce NVME_QUIRK_IGNORE_DEV_SUBNQN

Jianchao Wang (1):
      blk-mq: fix a hung issue when fsync

Jim Qu (1):
      drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

Jin Yao (2):
      perf stat: Fix endless wait for child process
      perf report: Fix wrong iteration count in --branch-history

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Jurica Vukadin (1):
      ALSA: hda - Add quirk for HP EliteBook 840 G5

Keith Busch (1):
      nvme: pad fake subsys NQN vid and ssvid with zeros

Linus Walleij (1):
      ARM: dts: kirkwood: Fix polarity of GPIO fan lines

Liviu Dudau (1):
      nvme-pci: use the same attributes when freeing host_mem_desc_bufs.

Lyude Paul (1):
      drm/i915: Block fbdev HPD processing during suspend

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Martin Schwidefsky (1):
      s390/suspend: fix stack setup in swsusp_arch_suspend

Matthew Wilcox (1):
      drm: Use array_size() when creating lease

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Michael Ellerman (1):
      powerpc/64s: Fix possible corruption on big endian due to pgd/pud_pre=
sent()

Mikulas Patocka (1):
      dm crypt: don't overallocate the integrity tag space

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Pavel Shilovsky (6):
      CIFS: Fix credits calculation for cancelled requests
      CIFS: Move credit processing to mid callbacks for SMB3
      CIFS: Fix error paths in writeback code
      CIFS: Fix credit calculations in compound mid callback
      CIFS: Do not assume one credit for async responses
      CIFS: Fix mounts if the client is low on credits

Peter Ujfalusi (4):
      ARM: dts: da850-evm: Correct the audio codec regulators
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the audio codec regulators
      ARM: dts: da850-lcdk: Correct the sound card name

Rodrigo Siqueira (1):
      drm/vkms: Fix license inconsistent

Ross Lagerwall (1):
      cifs: Limit memory used by lock request calls to a page

Russell King (1):
      ASoC: hdmi-codec: fix oops on re-probe

Sandeep Patil (1):
      mm: proc: smaps_rollup: fix pss_locked calculation

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with a sca=
tterlist

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Stefan O'Rear (1):
      riscv: Add pte bit to distinguish swap from invalid

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Takashi Iwai (2):
      drm/nouveau: Don't disable polling in fallback mode
      ALSA: pcm: Revert capture stream behavior change in blocking mode

Tao Zhou (1):
      drm/amdgpu: fix CPDMA hang in PRT mode for VEGA20

Tomi Valkeinen (6):
      drm/bridge: tc358767: add bus flags
      drm/bridge: tc358767: add defines for DP1_SRCCTRL & PHY_2LANE
      drm/bridge: tc358767: fix single lane configuration
      drm/bridge: tc358767: fix initial DP0/1_SRCCTRL value
      drm/bridge: tc358767: reject modes which require too much BW
      drm/bridge: tc358767: fix output H/V syncs

Tony Lindgren (1):
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type

Vitaly Kuznetsov (1):
      x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when it is =
available

Xiaoyao Li (1):
      kvm: vmx: Fix entry number check for add_atomic_switch_msr()

Zachary Hays (1):
      mmc: block: handle complete_work on separate workqueue


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxtJF8ACgkQONu9yGCS
aT7Tuw//bnfONAqKCefjTGJDEjoim1cDb60go5ZcyaGqxpX54krVb0+0wPeFLWBP
hEq9+ELI4pOghn3PpWNOVFrmNxIRdJYci8UoVZ0WOFV65hKmALKZ7X28hGq4L/9L
Uj0ahy3XQBpwEHVQuPcwiE6lE6bteRJJrjgaHgPQRb3Fx/dIP7xxvlGWAMzDXIN1
yXWKf3KGXGCttlUPPhslY7LR3zazgmxS5P8gkl7dtjo1vYMTF19ZFmkwfLWiCRUx
l7VtXESIJMRznrQbsgW9SugVlIA3MeVUEXiHFEAuO4wbXPD4LU2rkVM2/DInycay
tKjHsNqp6eh86t+fyBp2JwaRcXd/7lPXSWQsOQaEVzkVjLofQq5Mp0HZR1KlV7E6
yLHwPVwyxEL+olDRkDnNOgQHBjGhljXHQURUvxfas+UdG3c9YdSA/L0/o/qMmsIq
l2ZRDSDZyvf/gexqwDPmIb0aMOJHO7g5u+sgr2YtaVc5jsVIniBG2Ofd23ghli24
3SOMzP4KzLV6ssg3jYBK2rh9gnXS4NM1sjVjCTErMsoBWzYYk+b60E954QyPD7KX
SWlU8zxFr+AlML3gAOuQzjqhCKd6U1skopqAFKHFoHNeNpUtMiYd9jNM84DYkBtT
JMBHLZCi8hDoHkB2p+XV6ywtuU063LNqtVIJB8b4S7sxdlR5qoY=
=Ivmf
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
