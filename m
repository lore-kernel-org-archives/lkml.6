Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-955397-1520614474-2-13574221863255657312
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520614473; b=OzkqtcgNtvzvzD3lwC3Quv4Y4LxE0eFbFgwB6cQXPUYxmFI
    +9cKzrxRH/kmTmTYNwYMKCXvb0ohU5ilHUQoFzNhfJ8gVzVMorm4FA40iv41OftY
    D2Beox2J7b6S1qGX528QQxFytJFoGr6xD4y/jCQ80edYvAXPCz0zF9kKYV980A1n
    gHMjxURZSxszQgHNiNnaiGfzf//Q5nGzPEjukn+FGAKIfjNQFFuK4F6INuSFB0wB
    RlWZEl2uqRMU+gQ84h2p9k6vmRf+q0KbcdQBKR0ObOIquP+aeIsxJBTxA6HT9e+R
    5ZwV6p9vPnNHBgu67fZ9Zh8+ITRxLbjA+ZZYi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520614473; bh=GwCq+XI7vi0dk80La/+JpZjJcMFTNfQ6puRL+e2fA3w=; b=m
    vJyL7T3YHQGVivzKuXVZbbNKeElPwOMlGBAcV99LIacSZjK3JATQlNjtsPtGrCNi
    fmIxdInnRTdsZRcKFRhXBKsj0Wq7drm/l7nU3JuJ4wMgKZjpwVel1bF0jD5kjGcN
    mdZm6lHKqLTqSKrreHBh+vUsG7a06sAzLliKq/6kjUVUOB8KkX9+llfPNRdJkG1R
    Or8n+kym7Kk39cgJiWu2icEqgeHuQsYxds/nTRcAXPiKZCmLjjekLztyx02bJwBO
    jMOHROPaamGlnkI4cuKnr7bMr5Uo1nqKdS3DHSA+U7l9xH5sZeQuMYsaTF0gq+y5
    N4qF2MUrHngAtYdN4lW7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeCIQyO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 11:54:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeCIQyK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 11:54:10 -0500
Date: Fri, 9 Mar 2018 08:54:10 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.8
Message-ID: <20180309165410.GA29574@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.8 kernel.

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

 Documentation/networking/ip-sysctl.txt                   |    4=20
 Makefile                                                 |    2=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                    |    9=20
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi               |    8=20
 arch/arm/boot/dts/rk3288-phycore-som.dtsi                |   20 -
 arch/arm/kvm/hyp/Makefile                                |    5=20
 arch/arm/kvm/hyp/banked-sr.c                             |    4=20
 arch/arm/mach-mvebu/Kconfig                              |    4=20
 arch/arm/plat-orion/common.c                             |   23 -
 arch/parisc/include/asm/cacheflush.h                     |    1=20
 arch/parisc/include/asm/processor.h                      |    2=20
 arch/parisc/kernel/cache.c                               |   57 ++--
 arch/parisc/kernel/pacache.S                             |   22 +
 arch/parisc/kernel/time.c                                |   11=20
 arch/parisc/mm/init.c                                    |    7=20
 arch/powerpc/mm/pgtable-radix.c                          |   20 +
 arch/powerpc/platforms/pseries/ras.c                     |   31 +-
 arch/s390/kvm/interrupt.c                                |   25 +
 arch/s390/kvm/kvm-s390.c                                 |   79 +++---
 arch/s390/kvm/kvm-s390.h                                 |    5=20
 arch/s390/kvm/priv.c                                     |    9=20
 arch/x86/include/asm/pgtable.h                           |    8=20
 arch/x86/include/asm/pgtable_32.h                        |    1=20
 arch/x86/include/asm/pgtable_64.h                        |    1=20
 arch/x86/include/asm/pgtable_types.h                     |   10=20
 arch/x86/kernel/setup.c                                  |   17 -
 arch/x86/kernel/setup_percpu.c                           |   17 -
 arch/x86/kvm/lapic.c                                     |   11=20
 arch/x86/kvm/mmu.c                                       |    2=20
 arch/x86/kvm/svm.c                                       |    9=20
 arch/x86/kvm/vmx.c                                       |    9=20
 arch/x86/kvm/x86.c                                       |    8=20
 arch/x86/mm/cpu_entry_area.c                             |    6=20
 arch/x86/mm/init_32.c                                    |   15 +
 arch/x86/platform/intel-mid/intel-mid.c                  |    2=20
 arch/x86/xen/suspend.c                                   |   16 +
 block/blk-core.c                                         |    2=20
 block/blk-mq.c                                           |    4=20
 block/ioctl.c                                            |    2=20
 block/kyber-iosched.c                                    |    1=20
 drivers/acpi/bus.c                                       |   38 ++-
 drivers/bluetooth/btusb.c                                |   25 +
 drivers/char/ipmi/ipmi_si_intf.c                         |    9=20
 drivers/char/tpm/st33zp24/st33zp24.c                     |    4=20
 drivers/char/tpm/tpm-interface.c                         |    4=20
 drivers/char/tpm/tpm2-cmd.c                              |    4=20
 drivers/char/tpm/tpm_i2c_infineon.c                      |    5=20
 drivers/char/tpm/tpm_i2c_nuvoton.c                       |    8=20
 drivers/char/tpm/tpm_tis_core.c                          |    5=20
 drivers/cpufreq/s3c24xx-cpufreq.c                        |    8=20
 drivers/edac/sb_edac.c                                   |    2=20
 drivers/md/md.c                                          |    4=20
 drivers/media/dvb-frontends/m88ds3103.c                  |    7=20
 drivers/mmc/host/dw_mmc-exynos.c                         |    1=20
 drivers/mmc/host/dw_mmc-k3.c                             |    4=20
 drivers/mmc/host/dw_mmc-rockchip.c                       |    1=20
 drivers/mmc/host/dw_mmc-zx.c                             |    1=20
 drivers/mmc/host/dw_mmc.c                                |   84 ++++--
 drivers/mmc/host/dw_mmc.h                                |    2=20
 drivers/mmc/host/sdhci-pci-core.c                        |   35 ++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c                 |    2=20
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c                 |    2=20
 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c           |    2=20
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c         |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c            |    8=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        |   10=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          |   49 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c    |    3=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c          |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c        |   10=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |   35 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   29 ++
 drivers/net/ethernet/ti/cpsw.c                           |   16 +
 drivers/net/phy/phy.c                                    |    4=20
 drivers/net/phy/phy_device.c                             |   18 +
 drivers/net/ppp/ppp_generic.c                            |    9=20
 drivers/net/tun.c                                        |    7=20
 drivers/net/virtio_net.c                                 |    8=20
 drivers/net/wan/hdlc_ppp.c                               |    5=20
 drivers/platform/x86/dell-laptop.c                       |  188 ++++++++--=
-----
 drivers/s390/net/qeth_core.h                             |    7=20
 drivers/s390/net/qeth_core_main.c                        |   43 +--
 drivers/s390/net/qeth_l3.h                               |   34 ++
 drivers/s390/net/qeth_l3_main.c                          |  123 ++++-----
 drivers/vfio/vfio_iommu_type1.c                          |   18 +
 fs/btrfs/sysfs.c                                         |    8=20
 fs/btrfs/transaction.c                                   |   20 -
 fs/direct-io.c                                           |    3=20
 include/linux/fs.h                                       |    2=20
 include/linux/nospec.h                                   |    3=20
 include/linux/phy.h                                      |    1=20
 include/net/udplite.h                                    |    1=20
 kernel/time/hrtimer.c                                    |    7=20
 kernel/time/timer.c                                      |    6=20
 lib/vsprintf.c                                           |    2=20
 net/bridge/br_sysfs_if.c                                 |    3=20
 net/bridge/br_vlan.c                                     |    2=20
 net/core/dev.c                                           |   11=20
 net/core/gen_estimator.c                                 |    1=20
 net/ipv4/fib_semantics.c                                 |    5=20
 net/ipv4/route.c                                         |   10=20
 net/ipv4/tcp_input.c                                     |   24 -
 net/ipv4/tcp_ipv4.c                                      |    3=20
 net/ipv4/tcp_output.c                                    |   34 ++
 net/ipv4/udp.c                                           |    5=20
 net/ipv6/ip6_checksum.c                                  |    5=20
 net/ipv6/sit.c                                           |    2=20
 net/ipv6/tcp_ipv6.c                                      |    3=20
 net/l2tp/l2tp_core.c                                     |  142 +++--------
 net/l2tp/l2tp_core.h                                     |   23 -
 net/l2tp/l2tp_ip.c                                       |   10=20
 net/l2tp/l2tp_ip6.c                                      |    8=20
 net/l2tp/l2tp_ppp.c                                      |   60 ++--
 net/netlink/af_netlink.c                                 |    4=20
 net/netlink/genetlink.c                                  |   12=20
 net/rxrpc/output.c                                       |    2=20
 net/sched/cls_api.c                                      |    7=20
 net/sched/cls_u32.c                                      |   24 +
 net/sctp/input.c                                         |    5=20
 net/sctp/ipv6.c                                          |   10=20
 net/sctp/protocol.c                                      |   10=20
 net/sctp/sm_make_chunk.c                                 |    7=20
 net/tls/tls_main.c                                       |   52 ++--
 sound/core/control.c                                     |    2=20
 sound/pci/hda/hda_intel.c                                |   38 ++-
 sound/pci/hda/patch_realtek.c                            |    3=20
 sound/usb/quirks-table.h                                 |   47 +++
 sound/x86/intel_hdmi_audio.c                             |    2=20
 virt/kvm/kvm_main.c                                      |    3=20
 129 files changed, 1270 insertions(+), 736 deletions(-)

Adam Borowski (1):
      vsprintf: avoid misleading "(null)" for %px

Adam Ford (2):
      ARM: dts: LogicPD SOM-LV: Fix I2C1 pinmux
      ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux

Adrian Hunter (1):
      mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers

Alexey Kodanev (3):
      sctp: verify size of a new chunk in _sctp_make_chunk()
      udplite: fix partial checksum initialization
      sctp: fix dst refcnt leak in sctp_v6_get_dst()

Anand Jain (1):
      btrfs: use proper endianness accessors for super_copy

Andrew Lunn (1):
      net: phy: Restore phy_resume() locking assumption

Anna Karbownik (1):
      EDAC, sb_edac: Fix out of bound writes during DIMM configuration on K=
NL

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Arnd Bergmann (3):
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning
      ARM: orion: fix orion_ge00_switch_board_info initialization
      ARM: kvm: fix building with gcc-8

Boris Pismenny (1):
      tls: Use correct sk->sk_prot for IPV6

Corey Minyard (1):
      ipmi_si: Fix error handling of platform device

Dan Williams (2):
      vfio: disable filesystem-dax page pinning
      dax: fix vma_is_fsdax() helper

Daniel Schultz (1):
      ARM: dts: rockchip: Remove 1.8 GHz operation point from phycore som

David Ahern (1):
      net: ipv4: Set addr_type in hash_keys for forwarded case

David Hildenbrand (4):
      KVM: s390: take care of clock-comparator sign control
      KVM: s390: provide only a single function for setting the tod (fix SC=
K)
      KVM: s390: consider epoch index on hotplugged CPUs
      KVM: s390: consider epoch index on TOD clock syncs

David Howells (1):
      rxrpc: Fix send in rxrpc_send_data_packet()

Denis Du (1):
      hdlc_ppp: carrier detect ok, don't turn off negotiation

Emil Tantilov (1):
      ixgbe: fix crash in build_skb Rx code path

Eran Ben Elisha (1):
      net/mlx5e: Verify inline header size do not exceed SKB linear size

Eric Biggers (1):
      KVM/x86: remove WARN_ON() for when vm_munmap() fails

Eric Dumazet (2):
      tcp_bbr: better deal with suboptimal GSO
      net_sched: gen_estimator: fix broken estimators based on percpu stats

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Gal Pressman (2):
      net/mlx5e: Fix TCP checksum in LRO buffers
      net/mlx5e: Specify numa node when allocating drop rq

Geert Uytterhoeven (1):
      mmc: dw_mmc-k3: Fix out-of-bounds access through DT alias

Greg Kroah-Hartman (1):
      Linux 4.15.8

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix net watchdog timeout

Guillaume Nault (1):
      ppp: prevent unregistered channels from connecting to PPP units

Hans de Goede (2):
      Bluetooth: btusb: Use DMI matching for QCA reset_resume quirking
      ALSA: hda: Add a power_save blacklist

Heiner Kallweit (1):
      net: phy: fix phy_start to consider PHY_IGNORE_INTERRUPT

Helge Deller (3):
      parisc: Use cr16 interval timers unconditionally on qemu
      parisc: Reduce irq overhead when run in qemu
      parisc: Hide virtual kernel memory layout

Ido Schimmel (2):
      bridge: Fix VLAN reference count problem
      mlxsw: spectrum_router: Do not unconditionally clear route offload in=
dication

Ilya Lesokhin (1):
      tcp: Honor the eor bit in tcp_mtu_probe

Inbar Karmy (1):
      net/mlx5e: Fix loopback self test when GRO is off

Ivan Vecera (1):
      net/sched: cls_u32: fix cls_u32 on filter replace

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

James Chapman (5):
      l2tp: don't use inet_shutdown on tunnel destroy
      l2tp: don't use inet_shutdown on ppp session destroy
      l2tp: fix races with tunnel socket close
      l2tp: fix race in pppol2tp_release with session object destroy
      l2tp: fix tunnel lookup use-after-free race

Jan Beulich (1):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()

Jan Kara (1):
      direct-io: Fix sleep in atomic due to sync AIO

Jason A. Donenfeld (1):
      netlink: put module reference if dump start fails

Jason Wang (3):
      tuntap: correctly add the missing XDP flush
      tuntap: disable preemption during XDP processing
      virtio-net: disable NAPI only when enabled during XDP set

Jeremy Boone (5):
      tpm: st33zp24: fix potential buffer overruns caused by bit glitches o=
n the bus
      tpm: fix potential buffer overruns caused by bit glitches on the bus
      tpm_i2c_infineon: fix potential buffer overruns caused by bit glitche=
s on the bus
      tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches=
 on the bus
      tpm_tis: fix potential buffer overruns caused by bit glitches on the =
bus

Jiri Pirko (1):
      mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create

Jiufei Xue (1):
      block: fix the count of PGPGOUT for WRITE_SAME

John David Anglin (1):
      parisc: Fix ordering of cache and TLB flushes

Juergen Gross (1):
      x86/xen: Zero MSR_IA32_SPEC_CTRL before suspend

Julian Wiedmann (7):
      s390/qeth: fix SETIP command handling
      s390/qeth: fix overestimated count of buffer elements
      s390/qeth: fix IP removal on offline cards
      s390/qeth: fix double-free on IP add/remove race
      Revert "s390/qeth: fix using of ref counter for rxip addresses"
      s390/qeth: fix IP address lookup for L3 devices
      s390/qeth: fix IPA command submission race

Kai Heng Feng (1):
      ACPI / bus: Parse tables as term_list for Dell XPS 9570 and Precision=
 M5530

Laszlo Toth (1):
      platform/x86: dell-laptop: fix kbd_get_state's request value

Lingutla Chandrasekhar (1):
      timers: Forward timer base before migrating timers

Mario Limonciello (1):
      platform/x86: dell-laptop: Allocate buffer on heap rather than global=
ly

Mauro Carvalho Chehab (1):
      media: m88ds3103: don't call a non-initalized function

Ming Lei (3):
      block: kyber: fix domain token leak during requeue
      block: pass inclusive 'lend' parameter to truncate_inode_pages_range
      blk-mq: don't call io sched's .requeue_request when requeueing rq to =
->dispatch

NeilBrown (1):
      md: only allow remove_and_add_spares when no sync_thread running.

Nicholas Piggin (1):
      powerpc/64s/radix: Boot-time NULL pointer protection using a guard-PID

Nicolas Dichtel (1):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()

Paolo Abeni (1):
      cls_u32: fix use after free in u32_destroy_key()

Paolo Bonzini (3):
      KVM/x86: Remove indirect MSR op calls from SPEC_CTRL
      KVM: x86: move LAPIC initialization after VMCS creation
      KVM/VMX: Optimize vmx_vcpu_run() and svm_vcpu_run() by marking the RD=
MSR path as unlikely()

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      KVM: x86: fix vcpu initialization with userspace lapic

Rahul Lakkireddy (1):
      cxgb4: fix trailing zero in CIM LA dump

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type

Richard Fitzgerald (1):
      ALSA: control: Fix memory corruption risk in snd_ctl_elem_read

Roman Kapl (1):
      net: sched: report if filter is too large to dump

Sabrina Dubroca (1):
      net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68

Sam Bobroff (1):
      powerpc/pseries: Enable RAS hotplug events later

Sebastian Panceac (1):
      x86/platform/intel-mid: Handle Intel Edison reboot correctly

Shalom Toledo (1):
      mlxsw: spectrum_switchdev: Check success of FDB add operation

Shawn Lin (3):
      mmc: dw_mmc: Avoid accessing registers in runtime suspended state
      mmc: dw_mmc: Factor out dw_mci_init_slot_caps
      mmc: dw_mmc: Fix out-of-bounds access for slot's caps

Soheil Hassas Yeganeh (1):
      tcp: purge write queue upon RST

Song Liu (1):
      tcp: tracepoint: only call trace_tcp_send_reset with full socket

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Takashi Iwai (2):
      ALSA: x86: Fix missing spinlock and mutex initializations
      ALSA: hda - Fix pincfg at resume on Lenovo T470 dock

Thomas Gleixner (1):
      x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table

Tom Lendacky (1):
      amd-xgbe: Restore PCI interrupt enablement setting on resume

Tommi Rantala (1):
      sctp: fix dst refcnt leak in sctp_v4_get_dst

Tonghao Zhang (1):
      doc: Change the min default value of tcp_wmem/tcp_rmem.

Ulf Magnusson (1):
      ARM: mvebu: Fix broken PL310_ERRATA_753970 selects

Ursula Braun (1):
      s390/qeth: fix underestimated count of buffer elements

Viresh Kumar (1):
      cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()

Vlad Buslov (1):
      net/mlx5: Fix error handling when adding flow rules

Wanpeng Li (2):
      KVM: X86: Fix SMRAM accessing even if VM is shutdown
      KVM: mmu: Fix overlap between public and private memslots

Wolfram Sang (1):
      net: amd-xgbe: fix comparison to bitshift when dealing with a mask

Xin Long (2):
      bridge: check brport attr show in brport_show
      sctp: do not pr_err for the duplicated node in transport rhlist

Yuchung Cheng (2):
      tcp: revert F-RTO middle-box workaround
      tcp: revert F-RTO extension to detect more spurious timeouts


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqivDIACgkQONu9yGCS
aT5YHw/+PDs38YS+tVyyDZl4JIz9Hra8WMIMVAi8mpF8AT8Ak+aAPj9/Lf6TUh6I
B3QFSh3OvamSGgnyBRgB5ojtgX1ZUwgZT1FaNBlhBVwMSArp2lLB0chOAbXg2BmV
fmLpzGVtciZgnzVKC9rEkQxlN1DV/AFuaOsBR65fOFTlwmTz/li63FqmEc/ey+Ei
5l4NjADb1c1dTvHDrGygkUF+7FsE+fOxBM+9a5E3mwVloh1QofKeM7wyTLt430IV
QgwgTqBX5fpFplQAZIiJc4YaZ/3aJVTLk+cO/llFnPfEGw+DayTYmDoW9lO0newE
HvwaVKytDmWBndpIXXzXPaSMG7fAiuywurn3zr17HA/sQ5wCZyxGu110eiixmSBp
48VniJnw5Uc2YeHqkLCcCwhOgkAgeoz3r25BvIav05uHGipfb7Y+tzCgn+170AaH
7oW/TWAKk5dQnKom1dsg85glOFoi0F0G89yTxZyTJtmfbo37khnM98wWE+DAqhsu
LrlLIvQ+8lzYM2D7rQI+sRv2SFJkF7f4PqA0uat3mfhzgzaIhRcvxZDnZcdyXhmP
RcllqEstLpIbwFZEOMwcRiOmvQ0AcwZYBRygzYqDl4fzrmQW35vcD1aop4arxg26
M8SEH1xLnatuH1TNKqAphuzwu8Q4Ddnk5o+JudsXra3t1DvOCgU=
=JHem
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
