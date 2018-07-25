Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8FEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3045E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3045E20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeGYKxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:53:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44000 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeGYKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:53:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0938DBAD;
        Wed, 25 Jul 2018 09:42:11 +0000 (UTC)
Date:   Wed, 25 Jul 2018 11:42:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.10
Message-ID: <20180725094209.GA25504@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.10 kernel.

All users of the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 arch/alpha/kernel/osf_sys.c                                 |    5 -
 arch/arc/Kconfig                                            |    2=20
 arch/arc/configs/axs101_defconfig                           |    1=20
 arch/arc/configs/axs103_defconfig                           |    1=20
 arch/arc/configs/axs103_smp_defconfig                       |    1=20
 arch/arc/configs/haps_hs_defconfig                          |    1=20
 arch/arc/configs/haps_hs_smp_defconfig                      |    1=20
 arch/arc/configs/hsdk_defconfig                             |    1=20
 arch/arc/configs/nsim_700_defconfig                         |    1=20
 arch/arc/configs/nsim_hs_defconfig                          |    1=20
 arch/arc/configs/nsim_hs_smp_defconfig                      |    1=20
 arch/arc/configs/nsimosci_defconfig                         |    1=20
 arch/arc/configs/nsimosci_hs_defconfig                      |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig                  |    1=20
 arch/arc/include/asm/page.h                                 |    2=20
 arch/arc/include/asm/pgtable.h                              |    2=20
 arch/arc/plat-hsdk/Kconfig                                  |    2=20
 arch/powerpc/kernel/idle_book3s.S                           |    2=20
 arch/x86/events/intel/ds.c                                  |    8 +
 arch/x86/include/asm/apm.h                                  |    6 -
 arch/x86/kernel/apm_32.c                                    |    5 +
 arch/x86/kernel/cpu/mcheck/mce.c                            |    3=20
 arch/x86/kernel/kvmclock.c                                  |   11 +-
 arch/x86/kvm/vmx.c                                          |   52 +++++++=
+----
 drivers/cpufreq/intel_pstate.c                              |   17 +++
 drivers/cpufreq/pcc-cpufreq.c                               |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                      |    4=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   20 +---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c           |   10 --
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h            |    5 -
 drivers/gpu/drm/drm_lease.c                                 |   16 ---
 drivers/gpu/drm/i915/i915_irq.c                             |   32 ++++++-
 drivers/gpu/drm/nouveau/nouveau_backlight.c                 |    6 -
 drivers/gpu/drm/nouveau/nouveau_connector.c                 |    9 +-
 drivers/gpu/drm/nouveau/nouveau_connector.h                 |   36 +++++++-
 drivers/gpu/drm/nouveau/nouveau_display.c                   |   10 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c                       |   11 --
 drivers/misc/cxl/api.c                                      |    8 -
 drivers/net/ethernet/aquantia/atlantic/aq_cfg.h             |    2=20
 drivers/net/ethernet/aquantia/atlantic/aq_hw.h              |    4=20
 drivers/net/ethernet/aquantia/atlantic/aq_main.c            |   11 --
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c             |   47 ++++++-=
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h             |    2=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c   |    2=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c   |    4=20
 drivers/net/ethernet/broadcom/bcmsysport.c                  |    4=20
 drivers/net/ethernet/broadcom/bcmsysport.h                  |    3=20
 drivers/net/ethernet/broadcom/tg3.c                         |    9 ++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                  |    8 +
 drivers/net/hyperv/netvsc.c                                 |   17 ++-
 drivers/net/phy/phy_device.c                                |    7 -
 drivers/net/usb/asix_devices.c                              |    4=20
 drivers/net/usb/qmi_wwan.c                                  |    1=20
 drivers/ptp/ptp_chardev.c                                   |    1=20
 drivers/scsi/qla2xxx/qla_def.h                              |    2=20
 drivers/scsi/qla2xxx/qla_gs.c                               |   40 ++++++-=
--
 drivers/scsi/qla2xxx/qla_init.c                             |   14 +--
 drivers/scsi/qla2xxx/qla_os.c                               |    4=20
 drivers/scsi/sd_zbc.c                                       |    5 -
 drivers/usb/host/xhci.c                                     |   40 +++++++=
+-
 drivers/usb/host/xhci.h                                     |    4=20
 drivers/vfio/pci/vfio_pci.c                                 |    4=20
 drivers/vfio/vfio_iommu_spapr_tce.c                         |    8 -
 fs/fat/inode.c                                              |   20 +++-
 fs/internal.h                                               |    1=20
 include/linux/fs.h                                          |    1=20
 include/linux/sched/task.h                                  |    2=20
 include/linux/skbuff.h                                      |   10 +-
 include/net/ipv6.h                                          |    2=20
 include/net/sctp/sctp.h                                     |    9 +-
 kernel/stop_machine.c                                       |    6 +
 lib/rhashtable.c                                            |   25 ++++-
 mm/huge_memory.c                                            |    2=20
 mm/memcontrol.c                                             |    2=20
 net/core/gen_stats.c                                        |   16 +++
 net/core/skbuff.c                                           |    1=20
 net/ipv4/fib_frontend.c                                     |    1=20
 net/ipv4/sysctl_net_ipv4.c                                  |    5 -
 net/ipv4/tcp.c                                              |    3=20
 net/ipv6/Kconfig                                            |    1=20
 net/ipv6/ip6_gre.c                                          |    3=20
 net/ipv6/ndisc.c                                            |    2=20
 net/ipv6/route.c                                            |    7 +
 net/sched/sch_fq_codel.c                                    |   25 ++++-
 net/sctp/associola.c                                        |    6 -
 net/sctp/transport.c                                        |    8 -
 sound/core/rawmidi.c                                        |   20 +++-
 sound/pci/hda/patch_conexant.c                              |    1=20
 sound/pci/hda/patch_realtek.c                               |    2=20
 virt/kvm/eventfd.c                                          |   17 ++-
 91 files changed, 484 insertions(+), 263 deletions(-)

Al Viro (3):
      alpha: fix osf_wait4() breakage
      drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
      cxl_getfile(): fix double-iput() on alloc_file() failures

Alex Deucher (1):
      Revert "drm/amd/display: Don't return ddc result and read_bytes in sa=
me return value"

Alexander Couzens (1):
      net: usb: asix: replace mii_nway_restart in resume path

Alexey Brodkin (2):
      ARC: Fix CONFIG_SWAP
      ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs

Alexey Kardashevskiy (1):
      vfio/spapr: Use IOMMU pageshift rather than pagesize

Arnd Bergmann (1):
      ipv6: ila: select CONFIG_DST_CACHE

Chuck Anderson (1):
      scsi: qla2xxx: Fix NULL pointer dereference for fcport search

Colin Ian King (1):
      ipv6: fix useless rol32 call on hash

Damien Le Moal (1):
      scsi: sd_zbc: Fix variable type and bogus comment

David Ahern (2):
      net/ipv4: Set oif in fib_compute_spec_dst
      net/ipv6: Do not allow device only routes via the multipath API

Davidlohr Bueso (1):
      lib/rhashtable: consider param->min_size when setting initial table s=
ize

Dewet Thibaut (1):
      x86/MCE: Remove min interval polling limitation

Florian Fainelli (1):
      net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite

Gautham R. Shenoy (1):
      powerpc/powernv: Fix save/restore of SPRG3 on entry/exit from stop (i=
dle)

Greg Kroah-Hartman (1):
      Linux 4.17.10

Gustavo A. R. Silva (2):
      vfio/pci: Fix potential Spectre v1
      ptp: fix missing break in switch

Haiyang Zhang (1):
      hv_netvsc: Fix napi reschedule while receive completion is busy

Heiner Kallweit (1):
      net: phy: fix flag masking in __set_phy_supported

Hugh Dickins (2):
      x86/events/intel/ds: Fix bts_interrupt_threshold alignment
      mm/huge_memory.c: fix data loss when splitting a file pmd

Igor Russkikh (1):
      net: aquantia: vlan unicast address list correct handling

Isaac J. Manjarres (1):
      stop_machine: Disable preemption when waking two stopper threads

Jacob Keller (1):
      sch_fq_codel: zero q->flows_cnt when fq_codel_init fails

Jing Xia (1):
      mm: memcg: fix use after free in mem_cgroup_iter()

Lan Tianyu (1):
      KVM/Eventfd: Avoid crash when assign and deassign specific eventfd in=
 parallel.

Liran Alon (1):
      KVM: VMX: Mark VMXArea with revision_id of physical CPU even when eVM=
CS enabled

Lorenzo Colitti (1):
      net: diag: Don't double-free TCP_NEW_SYN_RECV sockets in tcp_abort

Lyude Paul (3):
      drm/nouveau: Remove bogus crtc check in pmops_runtime_idle
      drm/nouveau: Use drm_connector_list_iter_* for iterating connectors
      drm/nouveau: Avoid looping through fake MST connectors

Marcelo Ricardo Leitner (1):
      sctp: introduce sctp_dst_mtu

Matevz Vucnik (1):
      qmi_wwan: add support for Quectel EG91

Mathias Nyman (1):
      xhci: Fix perceived dead host due to runtime suspend race with event =
handler

Michel D=C3=A4nzer (1):
      drm/amdgpu: Reserve VM root shared fence slot for command submission =
(v3)

OGAWA Hirofumi (1):
      fat: fix memory allocation failure handling of match_strdup()

Paolo Bonzini (1):
      KVM: irqfd: fix race between EPOLLHUP and irq_bypass_register_consumer

Po-Hsu Lin (1):
      ALSA: hda: add mute led support for HP ProBook 455 G5

Prashant Bhole (1):
      net: ip6_gre: get ipv6hdr after skb_cow_head()

Quinn Tran (1):
      scsi: qla2xxx: Fix inconsistent DMA mem alloc/free

Radim Kr=C4=8Dm=C3=A1=C5=99 (1):
      x86/kvmclock: set pvti_cpu0_va after enabling kvmclock

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Register when ACPI PCCH is present

Sabrina Dubroca (1):
      ipv6: make DAD fail with enhanced DAD when nonce length differs

Saeed Mahameed (1):
      net/mlx4_en: Don't reuse RX page when XDP is set

Sanjeev Bansal (1):
      tg3: Add higher cpu clock for 5762.

Stefano Brivio (2):
      net: Don't copy pfmemalloc flag in __copy_skb_header()
      skbuff: Unconditionally copy pfmemalloc in __skb_clone()

Taehee Yoo (1):
      rhashtable: add restart routine in rhashtable_free_and_destroy()

Takashi Iwai (2):
      ALSA: rawmidi: Change resized buffers atomically
      ALSA: hda/realtek - Yet another Clevo P950 quirk entry

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      gen_stats: Fix netlink stats dumping in the presence of padding

Tyler Hicks (1):
      ipv4: Return EINVAL when ping_group_range sysctl doesn't map to user =
ns

Ville Syrj=C3=A4l=C3=A4 (2):
      x86/apm: Don't access __preempt_count with zeroed fs
      drm/i915: Fix hotplug irq ack on i965/g4x

Vineet Gupta (2):
      ARCv2: [plat-hsdk]: Save accl reg pair by default
      ARC: mm: allow mprotect to make stack mappings executable

Vitaly Kuznetsov (1):
      x86/kvm/vmx: don't read current->thread.{fs,gs}base of legacy tasks

Xin Long (1):
      sctp: fix the issue that pathmtu may be set lower than MINSEGMENT

YOKOTA Hiroshi (1):
      ALSA: hda/realtek - Add Panasonic CF-SZ6 headset jack quirk

himanshu.madhani@cavium.com (1):
      scsi: qla2xxx: Fix kernel crash due to late workqueue allocation


--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltYRfEACgkQONu9yGCS
aT6r3w/9EhQ+VbWTCaWq5DirqppNQHw7bcmsA5gKO9HzBAMOb5pB7+RZcJgAWbCu
kgGKPkj7x3Xmw/n/kh+YAIvZWpysuU4LjD8E4sLCQJwhDQxQWX6cr7bskogViAfD
4tSr7agJ37VjCP4bonpQI9m56D0b3gHPy/k94vxN6qOyIx18wVNJJC+0w+/Js8Xy
kwzvTpmQQKfD6NiMPEqZsQ2wrY1Fnk1sYh5BawutceYPy7gm1qmLbCturWAQjWXh
oJz94AzhbBT/XQBX5waEn0f9toN5t/qDqi0EZSIbB9OjHmcp2Xc0Uip2sH5jFTL2
nJiGe1/A0V45WF04HMrAgFhD3wLf7/8m5r+iW70Y5U8IW+UFCU1ynsFFj6HIgqWd
69e2HXEaD1ivorkzJY5ByFfBu6qBBMWNlFKBGDXtwKc5krfLDG7MPL3h8hO8Jtxe
rwYF3rEQeaIIfCAnYpTDCGI9l6j9+tFBUMOO9BZK0DE65Y1bTnEGNfsxy9uUZSUN
FOAJsAanXAj5+zA5m0DJxWNZBTA9OqKxSCbLOn4edBE4OA5gcmi+juISlB99S2dB
9pLWBEFoJuoGpgn7MhJFMdpD5OqHdmW6yiOXqlf99NwzfDb5iTZ+THkrU15EsT2z
05VZvMr2RF4x5eRauPWhdKRNrY/Yazy/QSlH3g/TlkDBW3pmgbs=
=H4yc
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
