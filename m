Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E8CC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E1208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 13:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0E1208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeGHN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 09:56:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48952 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeGHN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 09:56:18 -0400
Received: from localhost (unknown [46.44.180.42])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7EF6CF2;
        Sun,  8 Jul 2018 13:56:17 +0000 (UTC)
Date:   Sun, 8 Jul 2018 15:56:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.54
Message-ID: <20180708135615.GA25875@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.54 kernel.

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

 Documentation/devicetree/bindings/net/dsa/b53.txt |    1=20
 Makefile                                          |    2=20
 arch/arm/boot/dts/imx6q.dtsi                      |    2=20
 drivers/acpi/osl.c                                |   72 +++++++
 drivers/atm/zatm.c                                |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c        |    6=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c           |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c      |   23 ++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c             |    4=20
 drivers/gpu/drm/amd/amdgpu/vi.c                   |   77 ++++++--
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |    2=20
 drivers/gpu/drm/i915/i915_reg.h                   |    5=20
 drivers/gpu/drm/i915/intel_lrc.c                  |   12 +
 drivers/gpu/drm/qxl/qxl_display.c                 |    7=20
 drivers/md/dm-raid.c                              |   10 -
 drivers/md/md-cluster.c                           |    6=20
 drivers/md/md.c                                   |   90 ++++++---
 drivers/md/md.h                                   |   15 +
 drivers/md/raid0.c                                |    2=20
 drivers/md/raid1.c                                |   27 --
 drivers/md/raid10.c                               |   10 -
 drivers/md/raid5-cache.c                          |   30 ++-
 drivers/md/raid5-log.h                            |    2=20
 drivers/md/raid5.c                                |   40 ----
 drivers/mtd/nand/nand_base.c                      |    2=20
 drivers/net/dsa/b53/b53_common.c                  |   13 +
 drivers/net/dsa/b53/b53_mdio.c                    |    5=20
 drivers/net/dsa/b53/b53_priv.h                    |    1=20
 drivers/net/ethernet/natsemi/sonic.c              |    2=20
 drivers/net/usb/qmi_wwan.c                        |    1=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   |   10 -
 drivers/platform/x86/asus-wmi.c                   |   23 +-
 drivers/s390/block/dasd.c                         |    7=20
 drivers/staging/android/ion/ion_heap.c            |    2=20
 drivers/tty/n_tty.c                               |   55 +++---
 drivers/tty/serdev/core.c                         |    1=20
 drivers/tty/serial/8250/8250_pci.c                |    2=20
 drivers/tty/vt/vt.c                               |    4=20
 drivers/usb/class/cdc-acm.c                       |    3=20
 drivers/usb/dwc2/hcd_queue.c                      |    2=20
 drivers/usb/host/xhci-mem.c                       |    4=20
 drivers/usb/host/xhci-trace.h                     |   36 +++
 drivers/usb/serial/cp210x.c                       |   14 +
 drivers/usb/typec/ucsi/ucsi.c                     |   13 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                |    5=20
 fs/afs/security.c                                 |   10 -
 fs/inode.c                                        |    1=20
 include/linux/acpi.h                              |    3=20
 include/net/netfilter/nf_tables.h                 |    5=20
 kernel/sched/core.c                               |   45 +++-
 net/bridge/netfilter/ebtables.c                   |    3=20
 net/ipv6/netfilter/ip6t_rpfilter.c                |    4=20
 net/ipv6/netfilter/nft_fib_ipv6.c                 |   12 -
 net/ipv6/xfrm6_policy.c                           |    2=20
 net/netfilter/ipvs/ip_vs_ctl.c                    |   21 +-
 net/netfilter/nf_tables_api.c                     |   61 +++++-
 net/netfilter/nf_tables_core.c                    |   20 +-
 net/netfilter/nft_compat.c                        |  201 +++++++++++++++++=
-----
 net/netfilter/nft_immediate.c                     |   15 +
 net/netfilter/nft_limit.c                         |   38 ++--
 net/netfilter/nft_meta.c                          |   14 -
 tools/perf/tests/topology.c                       |   30 ++-
 tools/perf/util/bpf-loader.c                      |    6=20
 64 files changed, 808 insertions(+), 339 deletions(-)

Abhishek Sahu (1):
      mtd: rawnand: fix return value check for bad block status

Alexander Potapenko (1):
      vt: prevent leaking uninitialized data to userspace via /dev/vcs*

Andy Shevchenko (1):
      serial: 8250_pci: Remove stalled entries in blacklist

Colin Ian King (1):
      netfilter: nf_tables: fix memory leak on error exit return

Damien Th=E9bault (1):
      net: dsa: b53: Add BCM5389 support

Darrick J. Wong (1):
      fs: clear writeback errors in inode_init_always

David Howells (1):
      afs: Fix directory permissions check

Eric Dumazet (1):
      xfrm6: avoid potential infinite loop in _decode_session6()

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

Florian Westphal (6):
      netfilter: nf_tables: nft_compat: fix refcount leak on xt module
      netfilter: nft_compat: prepare for indirect info storage
      netfilter: nft_compat: fix handling of large matchinfo size
      netfilter: nf_tables: don't assume chain stats are set when jumplabel=
 is set
      netfilter: nf_tables: add missing netlink attrs to policies
      netfilter: don't set F_IFACE on ipv6 fib lookups

Greg Kroah-Hartman (1):
      Linux 4.14.54

Hao Wei Tee (1):
      iwlwifi: pcie: compare with number of IRQs requested for, not number =
of CPUs

Heikki Krogerus (3):
      acpi: Add helper for deactivating memory region
      usb: typec: ucsi: acpi: Workaround for cache mode issue
      usb: typec: ucsi: Fix for incorrect status data issue

Houston Yaroschoff (1):
      usb: cdc_acm: Add quirk for Uniden UBC125 scanner

Huang Rui (1):
      drm/amdgpu: fix the missed vcn fw version report

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jeremy Cline (1):
      drm/qxl: Call qxl_bo_unref outside atomic context

Johan Hovold (2):
      USB: serial: cp210x: add CESINEL device ids
      serdev: fix memleak on module unload

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Fix NULL pointer dereference

Julian Anastasov (1):
      ipvs: fix buffer overflow with sync daemon and service

Karoly Pados (1):
      USB: serial: cp210x: add Silicon Labs IDs for Windows Update

Kenneth Graunke (1):
      drm/i915: Enable provoking vertex fix on Gen9 systems.

Laura Abbott (1):
      staging: android: ion: Return an ERR_PTR in ion_map_kernel

Michel D=E4nzer (2):
      drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes array
      drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper

NeilBrown (6):
      md: always hold reconfig_mutex when calling mddev_suspend()
      md: don't call bitmap_create() while array is quiesced.
      md: move suspend_hi/lo handling into core md code
      md: use mddev_suspend/resume instead of ->quiesce()
      md: allow metadata update while suspending.
      md: remove special meaning of ->quiesce(.., 2)

Pablo Neira Ayuso (3):
      netfilter: nf_tables: bogus EBUSY in chain deletions
      netfilter: nf_tables: disable preemption in nft_update_chain_stats()
      netfilter: nft_limit: fix packet ratelimiting

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Paul Burton (1):
      sched/core: Require cpu_active() in select_task_rq(), for user tasks

Peter Zijlstra (1):
      sched/core: Fix rules for running on online && !active CPUs

Rex Zhu (2):
      drm/amdgpu: Add APU support in vi_set_uvd_clocks
      drm/amdgpu: Add APU support in vi_set_vce_clocks

Sean Nyekjaer (1):
      ARM: dts: imx6q: Use correct SDMA script for SPI5 core

Sebastian Ott (1):
      s390/dasd: use blk_mq_rq_from_pdu for per request data

Stefan Agner (1):
      drm/atmel-hlcdc: check stride values in the first plane

Taehee Yoo (4):
      netfilter: nft_meta: fix wrong value dereference in nft_meta_set_eval
      netfilter: nf_tables: increase nft_counters_enabled in nft_chain_stat=
s_replace()
      netfilter: nf_tables: fix NULL-ptr in nf_tables_dump_obj()
      netfilter: nf_tables: use WARN_ON_ONCE instead of BUG_ON in nft_do_ch=
ain()

Tetsuo Handa (2):
      n_tty: Fix stall at n_tty_receive_char_special().
      n_tty: Access echo_* variables carefully.

Thomas Richter (1):
      perf test: "Session topology" dumps core on s390

Vincent Bernat (1):
      netfilter: ip6t_rpfilter: provide input interface for route lookup

William Wu (1):
      usb: dwc2: fix the incorrect bitmaps for the ports of multi_tt hub

YueHaibing (1):
      perf bpf: Fix NULL return handling in bpf__prepare_load()

Zhengjun Xing (1):
      xhci: Fix kernel oops in trace_xhci_free_virt_device


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltCF/wACgkQONu9yGCS
aT5vsQ//ckxYLGombSDWg4ysgWrzWreAx89cusslfo7CnIQt9stQeANCzDu0GGuJ
RFEHUWTwgFtkZPllBwfxbJk76f9lR++jgu93vaq9rEgOz0qj1YR/CovMtG0LFzO8
OYhzGMkECHmw0BQvbBdhxoC8VBqQwaafANuokGaB7XbzmHB0PRR4C5W/dqce0Q6l
OnhFnP0RMmH+5H3Lv+W48vATuGab1Cdx5wxfC4Cb2NRW+TRIi8cvB5KmnsvmtmGA
4LwP+VVJm4+Lc3faLFGKS8Wxyk7PvN0f6pTaVg4mHGQOMqND6iBDO3rKt5UZmlE/
MwC2iajCkxkRzaNqBWw1zCxKW+41WSTzyXQP4IMkgs/lw/sjOjbQ2edlNj8u5vvF
7suLPSUxaWpKMtYCCwCRWGBi+SnQh1BIA0EP3Kl8kFddXL2v+vSIGJG9lJgTsgSc
Wpi+P+qD+2J0BMANcBj7Kibr6n5+s2EnuFoSba0K613sIgPG3kaHihRRTw/NFf6O
qOclr4SEq+65K1eV9fZVDYSTzRg+4ULRLTp2aXajJA+3t1hCnhf+uGC++1ikq5e0
Aoat01y5+AhoIb+ztSSt91GrYlXFQLT++Mv4XCi44RIoWNDGDEAdlkYHejCeX6q4
bnU7xr47pWkSEz5sNgfwtT3sCV4Fa47HVchBPGYZpFvHARfgEfk=
=LDss
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
