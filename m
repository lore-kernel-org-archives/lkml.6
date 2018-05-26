Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031217AbeEZHDj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 03:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031131AbeEZHDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 03:03:36 -0400
Date: Sat, 26 May 2018 09:03:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.133
Message-ID: <20180526070317.GA18550@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.133 kernel.

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

 Makefile                                        |    2=20
 arch/alpha/include/asm/futex.h                  |   26 --
 arch/arc/include/asm/futex.h                    |   40 ----
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |    1=20
 arch/arm/include/asm/assembler.h                |   10 +
 arch/arm/include/asm/futex.h                    |   26 --
 arch/arm/kernel/traps.c                         |    5=20
 arch/arm/lib/getuser.S                          |   10 +
 arch/arm/probes/kprobes/opt-arm.c               |    4=20
 arch/arm64/Kconfig                              |   14 +
 arch/arm64/include/asm/assembler.h              |   60 ++++++
 arch/arm64/include/asm/cputype.h                |   11 +
 arch/arm64/include/asm/futex.h                  |   26 --
 arch/arm64/mm/proc.S                            |    5=20
 arch/frv/include/asm/futex.h                    |    3=20
 arch/frv/kernel/futex.c                         |   27 --
 arch/hexagon/include/asm/futex.h                |   38 ----
 arch/ia64/include/asm/futex.h                   |   25 --
 arch/microblaze/include/asm/futex.h             |   38 ----
 arch/mips/include/asm/futex.h                   |   25 --
 arch/parisc/include/asm/futex.h                 |   25 --
 arch/powerpc/include/asm/firmware.h             |    5=20
 arch/powerpc/include/asm/futex.h                |   26 --
 arch/powerpc/kernel/setup-common.c              |   11 -
 arch/powerpc/platforms/powernv/eeh-powernv.c    |    4=20
 arch/powerpc/platforms/powernv/idle.c           |    2=20
 arch/powerpc/platforms/powernv/opal-nvram.c     |   14 +
 arch/powerpc/platforms/powernv/opal-xscom.c     |    2=20
 arch/powerpc/platforms/powernv/opal.c           |   36 +--
 arch/powerpc/platforms/powernv/pci-ioda.c       |    2=20
 arch/powerpc/platforms/powernv/setup.c          |   12 -
 arch/powerpc/platforms/powernv/smp.c            |   74 +++-----
 arch/s390/include/asm/alternative-asm.h         |  108 +++++++++++
 arch/s390/include/asm/futex.h                   |   23 --
 arch/s390/include/asm/nospec-insn.h             |  182 +++++++++++++++++++
 arch/s390/kernel/Makefile                       |    1=20
 arch/s390/kernel/base.S                         |   24 +-
 arch/s390/kernel/entry.S                        |  105 ++---------
 arch/s390/kernel/irq.c                          |    5=20
 arch/s390/kernel/nospec-branch.c                |   43 ++--
 arch/s390/kernel/nospec-sysfs.c                 |   21 ++
 arch/s390/kernel/perf_cpum_sf.c                 |    4=20
 arch/s390/kernel/reipl.S                        |    5=20
 arch/s390/kernel/swsusp.S                       |   10 -
 arch/s390/lib/mem.S                             |    9=20
 arch/s390/net/bpf_jit.S                         |   16 +
 arch/s390/net/bpf_jit_comp.c                    |   63 ++++++
 arch/sh/include/asm/futex.h                     |   26 --
 arch/sparc/include/asm/futex_64.h               |   26 --
 arch/tile/include/asm/futex.h                   |   40 ----
 arch/x86/boot/compressed/eboot.c                |    6=20
 arch/x86/include/asm/futex.h                    |   40 ----
 arch/x86/kernel/machine_kexec_32.c              |    6=20
 arch/x86/kernel/machine_kexec_64.c              |    4=20
 arch/x86/xen/mmu.c                              |    4=20
 arch/xtensa/include/asm/futex.h                 |   27 --
 drivers/cpufreq/intel_pstate.c                  |   34 ++-
 drivers/cpufreq/powernv-cpufreq.c               |    2=20
 drivers/cpuidle/coupled.c                       |    1=20
 drivers/cpuidle/cpuidle-powernv.c               |    2=20
 drivers/gpio/gpio-rcar.c                        |   46 +++++
 drivers/net/bonding/bond_alb.c                  |    2=20
 drivers/net/ethernet/broadcom/tg3.c             |    9=20
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |   16 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |    7=20
 drivers/net/ethernet/realtek/8139too.c          |    2=20
 drivers/net/ethernet/realtek/r8169.c            |    3=20
 drivers/net/ethernet/sun/niu.c                  |    5=20
 drivers/net/usb/qmi_wwan.c                      |   12 +
 drivers/s390/cio/qdio_setup.c                   |   12 -
 drivers/s390/scsi/zfcp_dbf.c                    |   23 ++
 drivers/s390/scsi/zfcp_ext.h                    |    5=20
 drivers/s390/scsi/zfcp_scsi.c                   |   14 -
 drivers/scsi/libsas/sas_scsi_host.c             |   33 +--
 drivers/scsi/sg.c                               |    2=20
 drivers/spi/spi-pxa2xx.h                        |    2=20
 drivers/usb/usbip/stub.h                        |    2=20
 drivers/usb/usbip/stub_dev.c                    |   43 ++--
 drivers/usb/usbip/stub_main.c                   |  105 ++++++++++-
 fs/btrfs/ctree.c                                |    6=20
 fs/btrfs/tree-log.c                             |    7=20
 fs/btrfs/volumes.c                              |    9=20
 fs/ext2/inode.c                                 |   10 -
 fs/hfsplus/super.c                              |    1=20
 fs/lockd/svc.c                                  |    2=20
 fs/pipe.c                                       |    3=20
 fs/proc/base.c                                  |   55 +++++-
 fs/proc/meminfo.c                               |    5=20
 include/asm-generic/futex.h                     |   50 -----
 include/linux/dmaengine.h                       |   20 ++
 include/linux/efi.h                             |    8=20
 include/linux/signal.h                          |   17 +
 include/linux/timekeeper_internal.h             |    4=20
 include/trace/events/xen.h                      |   16 -
 include/uapi/linux/nl80211.h                    |    2=20
 kernel/auditsc.c                                |    7=20
 kernel/exit.c                                   |    4=20
 kernel/futex.c                                  |   44 ++++
 kernel/signal.c                                 |    7=20
 kernel/time/tick-broadcast.c                    |    8=20
 kernel/time/timekeeping.c                       |   20 +-
 mm/Kconfig                                      |    1=20
 mm/filemap.c                                    |   90 ++++++---
 mm/util.c                                       |   16 +
 mm/vmscan.c                                     |   12 -
 net/bridge/br_if.c                              |    4=20
 net/compat.c                                    |    6=20
 net/core/sock.c                                 |    2=20
 net/dccp/ccids/ccid2.c                          |   14 +
 net/dccp/timer.c                                |    2=20
 net/ipv4/ip_output.c                            |    3=20
 net/ipv4/ping.c                                 |    7=20
 net/ipv4/tcp.c                                  |    2=20
 net/ipv4/tcp_output.c                           |    7=20
 net/ipv4/udp.c                                  |    7=20
 net/ipv6/ip6_output.c                           |    3=20
 net/l2tp/l2tp_netlink.c                         |    2=20
 net/llc/af_llc.c                                |    3=20
 net/openvswitch/flow_netlink.c                  |    9=20
 net/packet/af_packet.c                          |    4=20
 net/sched/sch_fq.c                              |   37 ++--
 net/sctp/associola.c                            |   30 +++
 net/sctp/inqueue.c                              |    2=20
 net/sctp/ipv6.c                                 |    3=20
 net/sctp/sm_statefuns.c                         |   89 +++++----
 net/wireless/core.c                             |    3=20
 net/xfrm/xfrm_state.c                           |    1=20
 sound/core/control_compat.c                     |    3=20
 sound/core/timer.c                              |  220 +++++++++++--------=
-----
 sound/pci/hda/hda_intel.c                       |    2=20
 sound/usb/mixer.c                               |    8=20
 131 files changed, 1583 insertions(+), 1103 deletions(-)

Al Viro (1):
      ext2: fix a block leak

Alexander Potapenko (1):
      scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Anand Jain (1):
      btrfs: fix crash when trying to resume balance without the resume flag

Anders Roxell (1):
      cpuidle: coupled: remove unused define cpuidle_coupled_lock

Andrey Ignatov (1):
      ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Andy Shevchenko (1):
      spi: pxa2xx: Allow 64-bit DMA

Antony Antony (1):
      xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Ard Biesheuvel (2):
      arm64: introduce mov_q macro to move a constant into a 64-bit register
      efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32'=
 definition for mixed mode

Benjamin Herrenschmidt (1):
      powerpc: Don't preempt_disable() in show_cpuinfo()

Bj=F8rn Mork (1):
      qmi_wwan: do not steal interfaces from class drivers

Debabrata Banerjee (1):
      bonding: do not allow rlb updates to invalid mac

Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels

Eric Dumazet (5):
      dccp: fix tasklet usage
      llc: better deal with too small mtu
      net_sched: fq: take care of throttled flows before reuse
      sock_diag: fix use-after-free read in __sk_free
      tcp: purge write queue in tcp_connect_init()

Federico Cuello (1):
      ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Filipe Manana (1):
      Btrfs: fix xattr loss after power failure

Geert Uytterhoeven (1):
      gpio: rcar: Add Runtime PM handling for interrupts

Greg Kroah-Hartman (2):
      Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
      Linux 4.4.133

Hangbin Liu (1):
      bridge: check iface upper dev when setting master via ioctl

Hans de Goede (1):
      ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Heiner Kallweit (1):
      r8169: fix powering up RTL8168h

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non=
-zero

Ingo Molnar (1):
      8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

James Chapman (1):
      l2tp: revert "l2tp: fix missing print session offset info"

Janis Danisevskis (1):
      procfs: fix pthread cross-thread naming if !PR_DUMPABLE

Jason Yan (1):
      scsi: libsas: defer ata device eh commands to libata

Jens Remus (1):
      scsi: zfcp: fix infinite iteration on ERP ready list

Jiri Slaby (2):
      futex: Remove duplicated code and fix undefined behaviour
      futex: futex_wake_op, fix sign_extend32 sign bits

Johannes Berg (1):
      cfg80211: limit wiphy names to 128 bytes

Johannes Weiner (1):
      proc: meminfo: estimate available memory more conservatively

John Stultz (1):
      time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting

Julian Wiedmann (2):
      s390/qdio: fix access to uninitialized qdio_q fields
      s390/qdio: don't release memory in qdio_setup_irq()

Lance Richardson (1):
      net: support compat 64-bit time in {s,g}etsockopt

Liu Bo (1):
      btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Martin Schwidefsky (8):
      s390: remove indirect branch from do_softirq_own_stack
      s390: add assembler macros for CPU alternatives
      s390: move expoline assembler macros to a header
      s390/lib: use expoline for indirect branches
      s390/kernel: use expoline for indirect branches
      s390: move spectre sysfs attribute code
      s390: extend expoline to BC instructions
      s390: use expoline thunks in the BPF JIT

Masami Hiramatsu (4):
      ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr
      ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
      ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
      ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Mateusz Guzik (1):
      proc read mm's {arg,env}_{start,end} with mmap semaphore taken.

Mel Gorman (3):
      futex: Remove unnecessary warning from get_futex_key
      mm: filemap: remove redundant code in do_read_cache_page
      mm: filemap: avoid unnecessary calls to lock_page when waiting for IO=
 to complete during a read

Michael Chan (1):
      tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Michael Kerrisk (man-pages) (1):
      pipe: cap initial pipe capacity according to pipe-max-size limit

Moshe Shemesh (1):
      net/mlx4_en: Verify coalescing parameters are in range

Nicholas Piggin (1):
      powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Pavel Tatashin (1):
      mm: don't allow deferred pages with NEED_PER_CPU_KM

Richard Guy Briggs (1):
      audit: move calcs after alloc and check when logging set loginuid

Rob Taglang (1):
      net: ethernet: sun: niu set correct packet size in skb

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Shuah Khan (Samsung OSG) (4):
      usbip: usbip_host: delete device from busid_table after rebind
      usbip: usbip_host: run rebind from exit when module is removed
      usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
      usbip: usbip_host: fix bad unlock balance during stub_probe()

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Enable HWP by default

Stefano Brivio (1):
      openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED i=
s found

Steven Rostedt (VMware) (1):
      tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flu=
sh_tlb{_all}

Stewart Smith (3):
      powerpc/powernv: panic() on OPAL < V3
      powerpc/powernv: Remove OPALv2 firmware define and references
      powerpc/powernv: remove FW_FEATURE_OPALv3 and just use FW_FEATURE_OPAL

Suzuki K Poulose (1):
      arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Takashi Iwai (1):
      ALSA: timer: Call notifier in the same spinlock

Tetsuo Handa (2):
      hfsplus: stop workqueue when fill_super() failed
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Vasily Averin (1):
      lockd: lost rollback of set_grace_period() in lockd_down_net()

Vinod Koul (1):
      dmaengine: ensure dmaengine helpers check valid callback

Vladimir Davydov (1):
      vmscan: do not force-scan file lru if its absolute size is small

Waiman Long (1):
      signals: avoid unnecessary taking of sighand->siglock

Wenwen Wang (1):
      ALSA: control: fix a redundant-copy issue

Willem de Bruijn (2):
      net: test tailroom before appending to linear skb
      packet: in packet_snd start writing at link layer allocation

Xin Long (4):
      sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
      sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
      sctp: fix the issue that the cookie-ack with auth can't get processed
      sctp: delay the authentication for the duplicated cookie-echo chunk

Yuchung Cheng (1):
      tcp: ignore Fast Open on repair mode

zhongjiang (1):
      kernel/exit.c: avoid undefined behaviour when calling wait4()


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsJBrIACgkQONu9yGCS
aT7Nlg/+PWHFsD5r15/nL/o4hBaT7P/HiN4c/qSZkqB3lRMx3QuDshj2w3dRPQFn
iUTPsTI6QiSK9t+EwkIhNMvItPsHAwM7fQF6P8R2jQqHzLc/U+RlUN/Dep6AtjgE
vXzH1rBiO9CSm9YN8tDDm8+Hu8t9tTtdl1ixSqIhxTrtlCmgakwzZzeE0wv9wUw3
711JPv7JUTG28u7OjPg+pocTZSINnzIRdNuCkpboGi7ikkaOZuLfALA6o+IcSXJy
eMa3EzaAvpeIlj2PmjwnNh4Y2Yl7q6VPmMIY21UzhRv9L8lMGm5RvbNOazSvoHre
WH44pIqzFyUs9pl8epeuEzl7++h9e+Yp2brUJMJcUolKAu1bQNiHFn5dOwIzoBQ/
VvUP+gDX54wQ6M0mop5+NTpQwc9O2d7zTH2qxgIaFJHtW0w0wiPlxRH+VdLkElqi
lJnh9W20DkI+mTquNmisS4nwLaM3BIi88Ht49RG+ghvC5nijBWJ5VaHsEBtVNBCM
lsFutFJfPcfUztsriKyukZqYIplw/JiqKBiZmHfaz+f5CuzSzQdYoFLUUvey+oUo
mIOP+/T0U57oyzkeni2QBmELlc0yQ1RTy1pdPKdso20X5WqP9JGnxJHpFN26Ybaf
4RskLKW76GpKBkOT0WqaSWc+zhbDeb7ZIhqL+VNKTDOaKc9/GQw=
=Gnqj
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
