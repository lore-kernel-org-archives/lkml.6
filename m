Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2904459-1527011346-3-1787168864133566147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527011345; b=ItekrHHMCx8swXELP/l1uMn6ojJw+7Z2vXyk0WlX4tJ/TVH7Mm
    LU9oq8c4jFolwbkHFodyL/RM3lEyQN5M2jYE6I4o13rSaeMf39twIzlItk4LiNvw
    QgcYHRiTjw1Yclr/rL0JQajGXJeJ13xpl0lzKHnLp1DYp3+KiQRS/NF5UBgTeb4M
    jiH96wcYvXzMmHU6F9TitXUkZhMCpyI6VEXC/mka5CjE1rKhu1KN3oo9FN/m5VRf
    uVHFKDwu0Mg4LY98dxnL0RlCc1E5mI+nFpeBiXgdHe97NX9lJ//ZPd/geCFjkh0Q
    6aahQ7sVLdul4/MiQxOgt5+3tIPjC/zdK3sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527011345;
    bh=1oV4YX5cElGY7j/Nr53f15WY4YBGgI1n1+7C/l5Wk9g=; b=m/r5JsPjO3qz
    9DNwEhYcluUQL7+h6uDrl9Dh6p7iu5SiN+jfVscalc33DLjlBEhKoyTAxvP27Tzn
    qZXFHUyOEs8bLbvdGeD3KKdbN0fUgUcWpxL5IlJWsaOpKsjhtq/rbg7nM4ATxdDv
    auCnxGrgAglW27zYBo+18M5ZlBoe5Ud7D8dr+LgMDBX8GOmKbh6htwSoPNx2MCL5
    qOWRhgWIgX3Siua1qgQn7thI4TE2Vq3495lajxK5TB50QD07kgni3DAr0xTfgWzd
    FYlTGOaa/Ae0hZn76PAbgJ6anI2ZvjBxzPyJ+DtdXFVPoHXSgLPsvqVWfggS7Z46
    24/UrDGVvQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=a5H/tKD6 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=a5H/tKD6 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDwe68gbNev1Wea+1ib+Si5DjEWJeiGaLGMKwERALPgFm3raOyFMxocxl0xzHqWcpGfZxc8A4P3hORzHSCn9d+tzLwXKbD+tRqRWidowE3Qh5Jj5rvBe
    hNb7Kp65Vp9gG2xASxnxiG5/rJk922aZVS5TRuw/lIsfiwSSF/bVtdcHIWFCtoXsg17uxMUB8YJRNocbZxPGOCu0Na16GgyjYh6qWoX9hW2cxG7G8coimjxB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=DzciLMFa0rjrK8yfYl8A:9 a=CjuIK1q_8ugA:10 a=hryMkVc5IMNCO2RvFMwA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeEVRs1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 13:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeEVRs0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 13:48:26 -0400
Date: Tue, 22 May 2018 19:48:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.11
Message-ID: <20180522174807.GA19063@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.11 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu    |    1=20
 Documentation/admin-guide/kernel-parameters.txt       |   45 ++
 Documentation/devicetree/bindings/net/marvell-pp2.txt |    9=20
 Documentation/userspace-api/index.rst                 |    1=20
 Documentation/userspace-api/spec_ctrl.rst             |   94 ++++
 Makefile                                              |    2=20
 arch/arm/include/asm/assembler.h                      |   10=20
 arch/arm/include/asm/kvm_mmu.h                        |   16=20
 arch/arm/kernel/traps.c                               |    5=20
 arch/arm/lib/getuser.S                                |   10=20
 arch/arm/probes/kprobes/opt-arm.c                     |    4=20
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi         |    7=20
 arch/arm64/include/asm/kvm_mmu.h                      |   16=20
 arch/powerpc/platforms/powernv/opal-nvram.c           |   14=20
 arch/s390/kernel/irq.c                                |    5=20
 arch/s390/kernel/perf_cpum_sf.c                       |    4=20
 arch/x86/boot/compressed/eboot.c                      |    6=20
 arch/x86/include/asm/cpufeatures.h                    |   20=20
 arch/x86/include/asm/kvm_host.h                       |    2=20
 arch/x86/include/asm/mmu_context.h                    |    2=20
 arch/x86/include/asm/msr-index.h                      |    9=20
 arch/x86/include/asm/nospec-branch.h                  |   43 +
 arch/x86/include/asm/pkeys.h                          |   18=20
 arch/x86/include/asm/spec-ctrl.h                      |   80 +++
 arch/x86/include/asm/thread_info.h                    |    4=20
 arch/x86/kernel/amd_nb.c                              |    6=20
 arch/x86/kernel/apic/x2apic_cluster.c                 |    1=20
 arch/x86/kernel/cpu/amd.c                             |   22=20
 arch/x86/kernel/cpu/bugs.c                            |  397 +++++++++++++=
++++-
 arch/x86/kernel/cpu/common.c                          |   77 ++-
 arch/x86/kernel/cpu/cpu.h                             |    2=20
 arch/x86/kernel/cpu/intel.c                           |    3=20
 arch/x86/kernel/process.c                             |  146 ++++++
 arch/x86/kernel/process_64.c                          |    1=20
 arch/x86/kernel/smpboot.c                             |    5=20
 arch/x86/kvm/cpuid.c                                  |   21=20
 arch/x86/kvm/svm.c                                    |   66 +-
 arch/x86/kvm/vmx.c                                    |   60 +-
 arch/x86/kvm/x86.c                                    |   13=20
 arch/x86/mm/pkeys.c                                   |   21=20
 arch/x86/xen/mmu.c                                    |    4=20
 arch/x86/xen/mmu_pv.c                                 |    4=20
 drivers/base/cpu.c                                    |    8=20
 drivers/cpufreq/Kconfig.arm                           |    2=20
 drivers/gpu/drm/drm_drv.c                             |    2=20
 drivers/gpu/drm/i915/i915_reg.h                       |    3=20
 drivers/gpu/drm/i915/intel_engine_cs.c                |    4=20
 drivers/hwmon/Kconfig                                 |    2=20
 drivers/hwmon/k10temp.c                               |   51 +-
 drivers/i2c/busses/i2c-designware-master.c            |    5=20
 drivers/md/bcache/debug.c                             |    3=20
 drivers/mtd/nand/marvell_nand.c                       |    8=20
 drivers/s390/cio/qdio_setup.c                         |   12=20
 drivers/s390/cio/vfio_ccw_cp.c                        |   13=20
 drivers/spi/spi-bcm-qspi.c                            |   28 -
 drivers/spi/spi-pxa2xx.h                              |    2=20
 drivers/tee/tee_shm.c                                 |    5=20
 drivers/usb/host/xhci-hub.c                           |    2=20
 drivers/usb/usbip/stub.h                              |    2=20
 drivers/usb/usbip/stub_dev.c                          |   43 +
 drivers/usb/usbip/stub_main.c                         |  105 ++++
 fs/btrfs/ctree.c                                      |   22=20
 fs/btrfs/ctree.h                                      |    2=20
 fs/btrfs/disk-io.c                                    |   26 -
 fs/btrfs/inode.c                                      |   13=20
 fs/btrfs/props.c                                      |   12=20
 fs/btrfs/tree-log.c                                   |    7=20
 fs/btrfs/volumes.c                                    |    9=20
 fs/proc/array.c                                       |   25 +
 include/linux/bpf_verifier.h                          |    1=20
 include/linux/cpu.h                                   |    2=20
 include/linux/efi.h                                   |    8=20
 include/linux/nospec.h                                |   10=20
 include/linux/sched.h                                 |   10=20
 include/linux/seccomp.h                               |    5=20
 include/trace/events/xen.h                            |   16=20
 include/uapi/linux/prctl.h                            |   12=20
 include/uapi/linux/seccomp.h                          |    5=20
 kernel/bpf/verifier.c                                 |   59 ++
 kernel/seccomp.c                                      |   21=20
 kernel/sys.c                                          |   23 +
 kernel/time/tick-broadcast.c                          |    8=20
 lib/radix-tree.c                                      |    6=20
 lib/test_bitmap.c                                     |   21=20
 lib/vsprintf.c                                        |   26 -
 mm/Kconfig                                            |    1=20
 net/netfilter/nf_tables_api.c                         |   75 +--
 sound/core/control_compat.c                           |    3=20
 sound/pci/hda/hda_intel.c                             |    2=20
 sound/pci/hda/patch_realtek.c                         |    1=20
 sound/usb/mixer.c                                     |    8=20
 tools/testing/selftests/seccomp/seccomp_bpf.c         |   22=20
 virt/kvm/arm/vgic/vgic-debug.c                        |    5=20
 virt/kvm/arm/vgic/vgic-its.c                          |   34 -
 virt/kvm/arm/vgic/vgic-v3.c                           |    4=20
 virt/kvm/arm/vgic/vgic.c                              |   22=20
 96 files changed, 1730 insertions(+), 372 deletions(-)

Alexander Monakov (1):
      i2c: designware: fix poll-after-enable regression

Alexei Starovoitov (1):
      bpf: Prevent memory disambiguation attack

Anand Jain (1):
      btrfs: fix crash when trying to resume balance without the resume flag

Andre Przywara (4):
      KVM: arm/arm64: Properly protect VGIC locks from IRQs
      KVM: arm/arm64: VGIC/ITS: Promote irq_lock() in update_affinity
      KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls
      KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU lo=
ck

Andy Shevchenko (1):
      spi: pxa2xx: Allow 64-bit DMA

Ard Biesheuvel (1):
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'=
 definition for mixed mode

Boris Brezillon (1):
      mtd: rawnand: marvell: Fix read logic for layouts with ->nchunks > 2

Borislav Petkov (3):
      Documentation/spec_ctrl: Do some minor cleanups
      x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
      x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}

Coly Li (1):
      bcache: return 0 from bch_debug_init() if CONFIG_DEBUG_FS=3Dn

Dave Hansen (2):
      x86/pkeys: Override pkey when moving away from PROT_EXEC
      x86/pkeys: Do not special case protection key 0

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels

Dmitry Safonov (1):
      x86/mm: Drop TS_COMPAT on 64-bit exec() syscall

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Filipe Manana (1):
      Btrfs: fix xattr loss after power failure

Florian Westphal (2):
      netfilter: nf_tables: free set name in error path
      netfilter: nf_tables: can't fail after linking rule into active rule =
list

Greg Kroah-Hartman (1):
      Linux 4.16.11

Guenter Roeck (3):
      hwmon: (k10temp) Fix reading critical temperature register
      hwmon: (k10temp) Use API function to access System Management Network
      x86/amd_nb: Add support for Raven Ridge CPUs

Halil Pasic (1):
      vfio: ccw: fix cleanup if cp_prefetch fails

Haneen Mohammed (1):
      drm: Match sysfs name in link removal to link creation

Hans de Goede (1):
      ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non=
-zero

Jann Horn (1):
      tee: shm: fix use-after-free via temporarily dropped reference

Jeremy Soller (1):
      ALSA: hda/realtek - Clevo P950ER ALC1220 Fixup

Jim Mattson (1):
      x86/cpu: Make alternative_msr_write work for 32-bit code

Jiri Kosina (2):
      x86/bugs: Fix __ssb_select_mitigation() return type
      x86/bugs: Make cpu_show_common() static

Julian Wiedmann (2):
      s390/qdio: fix access to uninitialized qdio_q fields
      s390/qdio: don't release memory in qdio_setup_irq()

Kamal Dasu (2):
      spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
      spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

Kees Cook (6):
      nospec: Allow getting/setting on non-current task
      proc: Provide details on speculation flaw mitigations
      seccomp: Enable speculation flaw mitigations
      x86/bugs: Make boot modes __ro_after_init
      seccomp: Add filter flag to opt-out of SSB mitigation
      x86/speculation: Make "seccomp" the default mode for Speculative Stor=
e Bypass

Konrad Rzeszutek Wilk (15):
      x86/bugs: Concentrate bug detection into a separate function
      x86/bugs: Concentrate bug reporting into a separate function
      x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
      x86/bugs, KVM: Support the combination of guest and host IBRS
      x86/bugs: Expose /sys/../spec_store_bypass
      x86/cpufeatures: Add X86_FEATURE_RDS
      x86/bugs: Provide boot parameters for the spec_store_bypass_disable m=
itigation
      x86/bugs/intel: Set proper CPU features and setup RDS
      x86/bugs: Whitelist allowed SPEC_CTRL MSR values
      x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if request=
ed
      x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
      x86/bugs: Rename _RDS to _SSBD
      proc: Use underscores for SSBD in 'status'
      x86/bugs: Fix the parameters alignment and missing void
      x86/bugs: Rename SSBD_NO to SSB_NO

Linus Torvalds (1):
      x86/nospec: Simplify alternative_msr_write()

Liu Bo (1):
      btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Martin Schwidefsky (1):
      s390: remove indirect branch from do_softirq_own_stack

Masami Hiramatsu (4):
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
      ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
      ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Mathias Nyman (1):
      xhci: Fix USB3 NULL pointer dereference at logical disconnect.

Matthew Wilcox (1):
      lib/test_bitmap.c: fix bitmap optimisation tests to report errors cor=
rectly

Maxime Chevallier (2):
      ARM64: dts: marvell: armada-cp110: Add clocks for the xmdio node
      ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node

Michel Thierry (1):
      drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk

Miquel Raynal (1):
      cpufreq: armada-37xx: driver relies on cpufreq-dt

Misono Tomohiro (1):
      btrfs: property: Set incompat flag if lzo/zstd compression is set

Nicholas Piggin (1):
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Nikolay Borisov (2):
      btrfs: Split btrfs_del_delalloc_inode into 2 functions
      btrfs: Fix delalloc inodes invalidation during transaction abort

Pavel Tatashin (1):
      mm: don't allow deferred pages with NEED_PER_CPU_KM

Robbie Ko (1):
      Btrfs: send, fix invalid access to commit roots due to concurrent sna=
pshotting

Ross Zwisler (1):
      radix tree: fix multi-order iteration race

Sean Christopherson (1):
      KVM: vmx: update sec exec controls for UMIP iff emulating UMIP

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (4):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
      usbip: usbip_host: fix bad unlock balance during stub_probe()

Steven Rostedt (VMware) (2):
      tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flu=
sh_tlb{_all}
      vsprintf: Replace memory barrier with static_key for random_ptr_key u=
pdate

Thomas Gleixner (19):
      x86/apic/x2apic: Initialize cluster ID properly
      x86/speculation: Create spec-ctrl.h to avoid include hell
      prctl: Add speculation control prctls
      x86/process: Allow runtime control of Speculative Store Bypass
      x86/speculation: Add prctl for Speculative Store Bypass mitigation
      prctl: Add force disable speculation
      seccomp: Use PR_SPEC_FORCE_DISABLE
      seccomp: Move speculation migitation control to arch code
      KVM: SVM: Move spec control call after restore of GS
      x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
      x86/cpufeatures: Disentangle SSBD enumeration
      x86/cpufeatures: Add FEATURE_ZEN
      x86/speculation: Handle HT correctly on AMD
      x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
      x86/speculation: Rework speculative_store_bypass_update()
      x86/bugs: Expose x86_spec_ctrl_base directly
      x86/bugs: Remove x86_spec_ctrl_set()
      x86/bugs: Rework spec_ctrl base and mask logic
      x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Tom Lendacky (2):
      x86/speculation: Add virtualized speculative store bypass disable sup=
port
      KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue

kbuild test robot (1):
      netfilter: nf_tables: nf_tables_obj_lookup_byhandle() can be static


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsEV9cACgkQONu9yGCS
aT4mZg//fPtKOThtEiLNI9nel5sYIgpl3+/sdR3HXp+kDsgPTWvK43TM1qmGGicb
OwbvWfBBz5I0kP40GF1wmREamNuquDYo6IKMLBQbJTsw7zSmiNYJWFWtszYgIkVU
n8zCWeNSQHFHdcToFG0ihWF7ExN8+vIiO2YT7dS/1g6DvvwbEL+GFUUPMQv78xpH
0E88Epj3ZMB6j1DrIG/iQYaWlhTSFu1Pd2NZvAi82F5DrhbJK9etS0QOzuQuXSGB
7lynZQkJhBrLXvQvs1wxx06LUvzRrz3MkS3GdmCXsSIFzQLD2h1kNj06mXYFNXY+
PzKplAjXqo152qAxdxrnAOQD2lxlWKYK+n4Jnr4t15kE/yIN+qxy2320ZVUlAlZx
7eKdii3xsEusQIIxKXQqTD1JtP7kYhPD5khTUm8VEJ6Xg2MTvpKdaHqO1wqa7XJH
6PAs6atc1kSzEvPRSEaCkUb7nJZ0cIQcRg32aR2z6E7vRguJCubriIeW1hN/rZn4
yDYF9ukMry0ds5uJbJy/vOggpmASjArzEA15mI2/HBViX6K3gG3G3zw8aNamgVwx
IlTMjcNplTY6GPDbANBYlUsAE4RidRL67GRE2X3m13pNaUA/b+mpzXnACicAOdKm
7MsaG/wSWRz5XVDm1SxbZ/RDBo13PGXwHbSxXxJFN4AsomhVy/g=
=uByj
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
