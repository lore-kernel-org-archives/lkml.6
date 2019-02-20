Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6299BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282952089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550656593;
	bh=l8BJQG3AduSxLOH8qWhmiSnD/P5h+9wDMi7uORyQ5IY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bczYvQ2pWqYrNVQQI/Hruye76wpoxFBK38zU/pSKLN0BTChKdg8vYinBMqOa5CNfh
	 KgeP9zabeTYi4QnxfB6RMWZu19kUot0IHiIQdbFmvyPftxbLi8pCAoB+kKeyfldDJ4
	 azKlGrstakDdpXTkoXNnYGEoyHOQRzhjpKEpZH2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBTJ4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBTJ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:56:31 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2676E2089F;
        Wed, 20 Feb 2019 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550656589;
        bh=l8BJQG3AduSxLOH8qWhmiSnD/P5h+9wDMi7uORyQ5IY=;
        h=Date:From:To:Cc:Subject:From;
        b=utM9pnyYLI6lhl4QnqXkspj1/4nH7JvNCpj2KKQnp2fLfPDXFR3Jo1PZQqFr+6Axc
         deDY/1+0d7vH1AZcPOgWyy8s3R43abAXCHXspoirZqRLme+ynxVoFk9zuB42QGcAb8
         SKOUJv85nWyFGWhVwhQjHSUAHXTSECsET5JinV64=
Date:   Wed, 20 Feb 2019 10:56:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.24
Message-ID: <20190220095625.GA15280@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.24 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/eeprom/at24.txt |    1=20
 Makefile                                          |    2=20
 arch/alpha/include/asm/irq.h                      |    6 -
 arch/alpha/mm/fault.c                             |    2=20
 arch/arm/boot/dts/da850-evm.dts                   |   31 +++++++-
 arch/arm/boot/dts/da850-lcdk.dts                  |   38 ++++++++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi             |    4 -
 arch/arm/boot/dts/omap5-board-common.dtsi         |    9 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                |   12 +++
 arch/arm/include/asm/assembler.h                  |   11 +++
 arch/arm/include/asm/cputype.h                    |    1=20
 arch/arm/include/asm/proc-fns.h                   |   61 +++++++++++++---
 arch/arm/include/asm/thread_info.h                |    4 -
 arch/arm/include/asm/uaccess.h                    |   49 +++++++++++--
 arch/arm/kernel/bugs.c                            |    4 -
 arch/arm/kernel/head-common.S                     |    6 -
 arch/arm/kernel/setup.c                           |   40 ++++++-----
 arch/arm/kernel/signal.c                          |   80 ++++++++++++-----=
-----
 arch/arm/kernel/smp.c                             |   31 ++++++++
 arch/arm/kernel/sys_oabi-compat.c                 |    8 +-
 arch/arm/lib/copy_from_user.S                     |    6 -
 arch/arm/lib/copy_to_user.S                       |    6 +
 arch/arm/lib/uaccess_with_memcpy.c                |    3=20
 arch/arm/mach-integrator/impd1.c                  |    6 +
 arch/arm/mach-omap2/omap-wakeupgen.c              |   36 +++++++++
 arch/arm/mm/proc-macros.S                         |   10 ++
 arch/arm/mm/proc-v7-bugs.c                        |   17 ----
 arch/arm/vfp/vfpmodule.c                          |   20 ++---
 arch/riscv/include/asm/pgtable-bits.h             |    6 +
 arch/riscv/include/asm/pgtable.h                  |    8 +-
 arch/riscv/kernel/ptrace.c                        |    2=20
 arch/x86/events/core.c                            |   14 +++
 arch/x86/events/intel/core.c                      |    9 ++
 arch/x86/events/perf_event.h                      |   16 +++-
 arch/x86/ia32/ia32_aout.c                         |    6 +
 arch/x86/include/asm/uv/bios.h                    |    8 +-
 arch/x86/kvm/svm.c                                |    3=20
 arch/x86/kvm/vmx.c                                |   11 +--
 arch/x86/platform/uv/bios_uv.c                    |   23 +++++-
 block/blk-flush.c                                 |    2=20
 drivers/acpi/numa.c                               |    6 -
 drivers/cpufreq/cpufreq.c                         |   12 +--
 drivers/firmware/efi/runtime-wrappers.c           |    7 +
 drivers/gpio/gpio-mxc.c                           |   41 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c             |    2=20
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |    3=20
 drivers/gpu/drm/bridge/tc358767.c                 |   45 +++++++++---
 drivers/gpu/drm/drm_lease.c                       |    3=20
 drivers/gpu/drm/i915/i915_gem.c                   |   12 +++
 drivers/gpu/drm/i915/intel_drv.h                  |   10 ++
 drivers/gpu/drm/i915/intel_fbdev.c                |   33 ++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c      |    7 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c  |    7 +
 drivers/gpu/drm/vkms/vkms_crtc.c                  |    8 --
 drivers/gpu/drm/vkms/vkms_drv.c                   |    7 -
 drivers/gpu/drm/vkms/vkms_drv.h                   |    2=20
 drivers/gpu/drm/vkms/vkms_gem.c                   |    8 --
 drivers/gpu/drm/vkms/vkms_output.c                |    8 --
 drivers/gpu/drm/vkms/vkms_plane.c                 |    8 --
 drivers/input/misc/bma150.c                       |    9 +-
 drivers/input/mouse/elan_i2c_core.c               |    2=20
 drivers/input/mouse/elantech.c                    |    9 ++
 drivers/md/dm-crypt.c                             |    2=20
 drivers/md/dm-thin.c                              |   55 +++++++++++++--
 drivers/md/raid1.c                                |   28 ++++---
 drivers/misc/eeprom/Kconfig                       |    2=20
 drivers/misc/eeprom/at24.c                        |    3=20
 drivers/mmc/core/block.c                          |   10 ++
 drivers/mmc/host/sunxi-mmc.c                      |   15 ++++
 drivers/nvme/host/core.c                          |    2=20
 drivers/nvme/host/multipath.c                     |    2=20
 drivers/nvme/host/pci.c                           |   14 ++-
 drivers/s390/crypto/ap_bus.c                      |    3=20
 drivers/scsi/sd.c                                 |   12 ++-
 fs/cifs/file.c                                    |    8 ++
 fs/cifs/smb2file.c                                |    4 +
 fs/cifs/smb2pdu.c                                 |   15 +++-
 fs/inode.c                                        |    7 -
 fs/nfsd/nfsctl.c                                  |    4 -
 fs/proc/task_mmu.c                                |   22 +++---
 include/linux/mmc/card.h                          |    1=20
 include/linux/perf_event.h                        |    5 +
 kernel/events/core.c                              |   16 ++++
 kernel/events/ring_buffer.c                       |    2=20
 kernel/signal.c                                   |    7 +
 kernel/trace/trace_uprobe.c                       |    9 ++
 mm/vmscan.c                                       |   10 --
 sound/pci/hda/patch_conexant.c                    |    1=20
 sound/soc/codecs/hdmi-codec.c                     |    4 -
 sound/usb/pcm.c                                   |    9 ++
 tools/arch/riscv/include/uapi/asm/bitsperlong.h   |   25 ++++++
 tools/include/uapi/asm/bitsperlong.h              |    4 +
 tools/perf/tests/shell/lib/probe_vfs_getname.sh   |    3=20
 tools/perf/util/callchain.c                       |   32 +++++---
 tools/perf/util/callchain.h                       |    1=20
 tools/perf/util/machine.c                         |    2=20
 97 files changed, 892 insertions(+), 316 deletions(-)

Adrian Bunk (2):
      dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
      eeprom: at24: add support for 24c2048

Andreas Ziegler (1):
      tracing/uprobes: Fix output for multiple string arguments

Anson Huang (1):
      gpio: mxc: move gpio noirq suspend/resume to syscore phase

Arnaldo Carvalho de Melo (1):
      perf test shell: Use a fallback to get the pathname in vfs_getname

Aurelien Jarno (1):
      tools uapi: fix RISC-V 64-bit support

Bob Tracy (1):
      tools uapi: fix Alpha support

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Chao Fan (1):
      ACPI: NUMA: Use correct type for printing addresses on i386-PAE

Chen-Yu Tsai (1):
      mmc: sunxi: Filter out unsupported modes declared in the device tree

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

Emily Deng (1):
      drm/amdgpu/sriov:Correct pfvf exchange logic

Eric W. Biederman (1):
      signal: Restore the stop PTRACE_EVENT_EXIT

Greg Kroah-Hartman (1):
      Linux 4.19.24

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

Jianchao Wang (1):
      blk-mq: fix a hung issue when fsync

Jim Qu (1):
      drm/amdgpu: set WRITE_BURST_LENGTH to 64B to workaround SDMA1 hang

Jin Yao (1):
      perf report: Fix wrong iteration count in --branch-history

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback

Jonathan Bakker (1):
      Input: bma150 - register input device after setting private data

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Julien Thierry (10):
      ARM: 8789/1: signal: copy registers using __copy_to_user()
      ARM: 8790/1: signal: always use __copy_to_user to save iwmmxt context
      ARM: 8791/1: vfp: use __copy_to_user() when saving VFP state
      ARM: 8792/1: oabi-compat: copy oabi events using __copy_to_user()
      ARM: 8793/1: signal: replace __put_user_error with __put_user
      ARM: 8794/1: uaccess: Prevent speculative use of the current addr_lim=
it
      ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
      ARM: 8796/1: spectre-v1,v1.1: provide helpers for address sanitization
      ARM: 8797/1: spectre-v1.1: harden __copy_to_user
      ARM: 8810/1: vfp: Fix wrong assignement to ufp_exc

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

Matthew Wilcox (1):
      drm: Use array_size() when creating lease

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Mikulas Patocka (1):
      dm crypt: don't overallocate the integrity tag space

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Nicholas Mc Guire (1):
      gpio: pl061: handle failed allocations

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Pavel Shilovsky (1):
      CIFS: Do not assume one credit for async responses

Peter Ujfalusi (4):
      ARM: dts: da850-evm: Correct the audio codec regulators
      ARM: dts: da850-evm: Correct the sound card name
      ARM: dts: da850-lcdk: Correct the audio codec regulators
      ARM: dts: da850-lcdk: Correct the sound card name

Rodrigo Siqueira (1):
      drm/vkms: Fix license inconsistent

Ross Lagerwall (1):
      cifs: Limit memory used by lock request calls to a page

Russell King (8):
      ARM: make lookup_processor_type() non-__init
      ARM: split out processor lookup
      ARM: clean up per-processor check_bugs method call
      ARM: add PROC_VTABLE and PROC_TABLE macros
      ARM: spectre-v2: per-CPU vtables to work around big.Little systems
      ARM: ensure that processor vtables is not lost after boot
      ARM: fix the cockup in the previous patch
      ASoC: hdmi-codec: fix oops on re-probe

Sandeep Patil (1):
      mm: proc: smaps_rollup: fix pss_locked calculation

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Stefan O'Rear (1):
      riscv: Add pte bit to distinguish swap from invalid

Sudeep Holla (1):
      cpufreq: check if policy is inactive early in __cpufreq_get()

Takashi Iwai (1):
      drm/nouveau: Don't disable polling in fallback mode

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


--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxtJEkACgkQONu9yGCS
aT6TRRAAnfigBQBRnE4xH47xFz9fv4qhYl4LQh1626QGYGnem00/+WIBqrbtBLcL
g9SVrq97aOkT6MCK4wlM9sWwzMOL86C/3IKjFDVglxOcYj+X1Y+HCaXQIzpSTgvs
jp3aXVi0Ja24iZ/ViSxhzDtn/1nLFCLBabf3WHBv1wsJAlxTpI4p2uIcNx745V2T
fQMJT5GC4zehKpahYERyjIhgDnbE991X2RUP8LKUm/KeYRX1nnp3oT2uTpCGjxjb
FnK+aJSwnKoRee8SisZCZl8YYsSIX+w0Hrlk3DiB36lKmjyI018Op23vMRiI6GUW
6wzX7YNSRYsP4dGLfZ4nROm4Y+HCWAMhjcA4fK8+ghipFPvwt4scZrL6WSyKopzY
FOzzjFClCWst9NaK1W8Q7igNJuWLWz0yvwB6AAfkDmL6IhJgrJZ/lp/RxunSB8Iz
sLRWr1wRjSO9+/zViqYhkAZWdRCJNQlUm2JaQNMkuw2LiSuuxMwrIh8J7tOJh/8Y
EZlaRK/IDjuKi1qafSavZwGBAGZM5mh2XQFAVjxDZ34G0Jd+nF2v4V/UUE1h6aED
UJ2P2y0OZ3MfvniWjcGquPO7gjT9FwdkbgzfVx6RuWp1rDq5dJp5dswhuHHKPTgE
Hd/iAFyqA9kJfsfhxJsLE03XFsWG+OXWf22p9OC1xkxGq/G5QKc=
=NBN+
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
