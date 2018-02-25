Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3799018-1519557038-2-16147337632697843871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES sven,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519557037; b=D4QThx5Gm7uYOySGbrgs2oJoFcaMnl778uW7zykuayEtnQw
    j/1Intkh4803vqZRpxM7373I/zrHKttadJaYWkl5VGbMmZEM4lduBvsEKH/eWrVo
    nXaVrRpZGN3MkrYbbjhbbPkJG0gFpl8uny8RP+jNHiEnAMSmdwhqNfkIgV1KR1ZV
    zSEqJ6swuCD5WlvoCEHb1z+CQbVdgfjr9gEWUqkMAeBsLEzFSicmzwxvouhP/9v2
    mdNIM0PankDTN85OvkLFSOQ5Vujfy2eJaNEQaOGib8qRPEZ1NPH1mT/HeiYfu1zg
    Mqx3qjPWO1BetN6klDXgt1DtZi4shOKuCl4sCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519557037; bh=/uvmkupIumj4tsIyiqsUb44wZ+BavuWvDqknPxM1X5k=; b=E
    WiYLZajebZfnj6sZ9VNarnmzTy7TeyayQBwN40j2avHUpcdIurfsnK85LHH/dqmi
    ExAUKj9E7VOy6VlBLd1007IcSWItK5Ue97hslinu8UjOVq3wk+9wrLL+YfmwiXOS
    DIERkLOC3Xr8zEYvJtNUELFJMm5aEhaxXTjMwF0UB3AHFOjO0+01rQgPQ6oYmtHC
    3aNwWYpX4MbbngAlV38qsVsDVunX1e8V3srH/xIbxkdk9jfifDsQp0sanrJt0zXb
    BedztMCWmAhMr29yZXxDkNswGsTz5KszOyAYARhK39yLRzilfO3boMXEld6kV1fH
    5uayNCbPEh/BtVdo9ntLA==
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
        id S1751697AbeBYLJz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 06:09:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBYLJc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Feb 2018 06:09:32 -0500
Date: Sun, 25 Feb 2018 12:09:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.22
Message-ID: <20180225110917.GA21740@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.22 kernel.

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

 Makefile                                                |    2=20
 arch/arm/boot/dts/am4372.dtsi                           |    6=20
 arch/arm/boot/dts/am437x-cm-t43.dts                     |    4=20
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts        |    3=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                   |   16 +-
 arch/arm/boot/dts/omap4.dtsi                            |    4=20
 arch/arm/common/bL_switcher_dummy_if.c                  |    4=20
 arch/arm/mach-omap2/omap-secure.c                       |   19 ++
 arch/arm/mach-omap2/omap-secure.h                       |    4=20
 arch/arm/mach-omap2/pm.h                                |    4=20
 arch/arm/mach-omap2/pm34xx.c                            |   13 -
 arch/arm/mach-omap2/prm33xx.c                           |   12 -
 arch/arm/mach-omap2/sleep34xx.S                         |   26 ---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi                |    2=20
 arch/m68k/kernel/vmlinux-nommu.lds                      |    2=20
 arch/m68k/kernel/vmlinux-std.lds                        |    2=20
 arch/m68k/kernel/vmlinux-sun3.lds                       |    2=20
 arch/powerpc/perf/core-book3s.c                         |    4=20
 arch/powerpc/perf/imc-pmu.c                             |   13 +
 arch/s390/include/uapi/asm/virtio-ccw.h                 |    2=20
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S            |  112 +++++++----=
---
 arch/x86/kvm/vmx.c                                      |    1=20
 arch/x86/kvm/x86.c                                      |   32 ++++
 arch/x86/mm/ioremap.c                                   |    4=20
 arch/x86/mm/kmmio.c                                     |   12 -
 block/blk-map.c                                         |    4=20
 drivers/Makefile                                        |    1=20
 drivers/android/binder.c                                |   29 ++-
 drivers/base/power/runtime.c                            |    3=20
 drivers/crypto/s5p-sss.c                                |   12 +
 drivers/crypto/talitos.c                                |    5=20
 drivers/dma/at_hdmac.c                                  |    4=20
 drivers/dma/dma-jz4740.c                                |    4=20
 drivers/dma/ioat/init.c                                 |    2=20
 drivers/gpio/gpio-74x164.c                              |    4=20
 drivers/gpio/gpio-davinci.c                             |    2=20
 drivers/gpu/drm/armada/armada_crtc.c                    |   25 +--
 drivers/gpu/drm/drm_modeset_lock.c                      |    2=20
 drivers/gpu/drm/i915/intel_drv.h                        |    2=20
 drivers/gpu/drm/vc4/vc4_gem.c                           |    4=20
 drivers/gpu/drm/vc4/vc4_irq.c                           |    1=20
 drivers/iio/industrialio-core.c                         |    4=20
 drivers/iio/proximity/sx9500.c                          |    9 +
 drivers/infiniband/core/cma.c                           |    3=20
 drivers/infiniband/core/device.c                        |    4=20
 drivers/infiniband/core/iwcm.c                          |    2=20
 drivers/infiniband/core/nldev.c                         |    2=20
 drivers/infiniband/hw/hfi1/rc.c                         |    2=20
 drivers/infiniband/hw/i40iw/i40iw_cm.c                  |    6=20
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c                |   43 +++--
 drivers/infiniband/hw/i40iw/i40iw_d.h                   |    6=20
 drivers/infiniband/hw/mlx4/qp.c                         |   26 ++-
 drivers/md/raid1.c                                      |    4=20
 drivers/md/raid10.c                                     |    4=20
 drivers/md/raid5.c                                      |    2=20
 drivers/media/i2c/Kconfig                               |    1=20
 drivers/media/i2c/s5k6aa.c                              |    5=20
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c                 |   12 +
 drivers/misc/mei/hw-me-regs.h                           |    5=20
 drivers/misc/mei/pci-me.c                               |    5=20
 drivers/net/dsa/mv88e6xxx/chip.c                        |   34 ++--
 drivers/net/ethernet/arc/emac_rockchip.c                |    7=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c               |    3=20
 drivers/net/ethernet/freescale/gianfar.c                |   11 +
 drivers/net/ethernet/marvell/mvpp2.c                    |    2=20
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c       |   15 -
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c    |    8 -
 drivers/net/hippi/rrunner.c                             |    2=20
 drivers/net/ipvlan/ipvlan_core.c                        |    1=20
 drivers/net/phy/phylink.c                               |    1=20
 drivers/net/phy/sfp.c                                   |    8 -
 drivers/net/virtio_net.c                                |    2=20
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c |    2=20
 drivers/net/wireless/mac80211_hwsim.c                   |    5=20
 drivers/pci/host/pcie-rcar.c                            |    8 -
 drivers/pinctrl/intel/pinctrl-denverton.c               |    2=20
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c              |    2=20
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c               |    6=20
 drivers/platform/x86/dell-laptop.c                      |   17 ++
 drivers/s390/block/dasd_eckd.c                          |   16 +-
 drivers/scsi/bfa/bfad_bsg.c                             |    6=20
 drivers/scsi/bfa/bfad_im.c                              |    6=20
 drivers/scsi/bfa/bfad_im.h                              |   10 +
 drivers/scsi/lpfc/lpfc_mem.c                            |    2=20
 drivers/soc/amlogic/meson-gx-socinfo.c                  |    4=20
 drivers/spi/spi-sun4i.c                                 |    2=20
 drivers/staging/android/ashmem.c                        |   19 +-
 drivers/staging/android/ion/ion-ioctl.c                 |    4=20
 drivers/staging/android/ion/ion_system_heap.c           |    2=20
 drivers/staging/ccree/ssi_hash.c                        |    2=20
 drivers/staging/fsl-mc/bus/Kconfig                      |    2=20
 drivers/staging/iio/adc/ad7192.c                        |   27 ++-
 drivers/staging/iio/impedance-analyzer/ad5933.c         |    4=20
 drivers/usb/core/urb.c                                  |   30 +++
 drivers/usb/dwc3/dwc3-of-simple.c                       |    4=20
 drivers/usb/dwc3/gadget.c                               |    2=20
 drivers/usb/usbip/stub_dev.c                            |    3=20
 drivers/usb/usbip/vhci_hcd.c                            |    2=20
 drivers/vhost/vhost.c                                   |    2=20
 drivers/video/fbdev/mmp/core.c                          |    5=20
 drivers/xen/Kconfig                                     |    2=20
 fs/btrfs/disk-io.c                                      |   12 -
 fs/btrfs/inode.c                                        |    2=20
 fs/btrfs/ioctl.c                                        |    2=20
 fs/notify/dnotify/dnotify.c                             |    7=20
 include/linux/ptr_ring.h                                |   15 +
 include/linux/serdev.h                                  |    2=20
 include/linux/usb.h                                     |    2=20
 include/net/cfg80211.h                                  |    2=20
 include/net/red.h                                       |   13 +
 include/net/sctp/sctp.h                                 |    3=20
 include/trace/events/clk.h                              |    4=20
 include/trace/events/xdp.h                              |    1=20
 kernel/bpf/verifier.c                                   |   25 ++-
 kernel/events/core.c                                    |    5=20
 kernel/kcov.c                                           |    4=20
 kernel/locking/lockdep.c                                |    3=20
 kernel/trace/blktrace.c                                 |   32 ++--
 lib/oid_registry.c                                      |    8 -
 mm/early_ioremap.c                                      |    2=20
 mm/vmalloc.c                                            |   10 -
 mm/vmscan.c                                             |    3=20
 net/core/dev.c                                          |    2=20
 net/core/gen_estimator.c                                |    4=20
 net/decnet/af_decnet.c                                  |   62 ++++----
 net/ipv4/esp4_offload.c                                 |    3=20
 net/ipv4/ip_sockglue.c                                  |   14 -
 net/ipv4/netfilter/ipt_CLUSTERIP.c                      |   16 +-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c          |    6=20
 net/ipv6/esp6_offload.c                                 |    3=20
 net/ipv6/ipv6_sockglue.c                                |   17 --
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c          |   18 +-
 net/kcm/kcmsock.c                                       |   25 ++-
 net/netfilter/x_tables.c                                |    9 -
 net/netfilter/xt_RATEEST.c                              |   22 ++
 net/netfilter/xt_bpf.c                                  |    6=20
 net/netfilter/xt_cgroup.c                               |    1=20
 net/rds/connection.c                                    |    3=20
 net/rds/rds.h                                           |    6=20
 net/rds/tcp.c                                           |   13 +
 net/rds/tcp.h                                           |    1=20
 net/sched/sch_choke.c                                   |    3=20
 net/sched/sch_gred.c                                    |    3=20
 net/sched/sch_red.c                                     |    2=20
 net/sched/sch_sfq.c                                     |    3=20
 net/sctp/outqueue.c                                     |    6=20
 net/sctp/socket.c                                       |   29 ++-
 net/vmw_vsock/hyperv_transport.c                        |    2=20
 net/wireless/core.c                                     |    8 -
 net/wireless/core.h                                     |    2=20
 net/xfrm/xfrm_input.c                                   |   12 +
 net/xfrm/xfrm_policy.c                                  |   15 +
 net/xfrm/xfrm_state.c                                   |    3=20
 net/xfrm/xfrm_user.c                                    |   24 +++
 scripts/kernel-doc                                      |    2=20
 security/selinux/ss/services.c                          |   21 +-
 sound/soc/rockchip/rockchip_spdif.c                     |   18 +-
 sound/soc/sh/rcar/ssi.c                                 |   16 +-
 sound/soc/ux500/mop500.c                                |    4=20
 sound/soc/ux500/ux500_pcm.c                             |    5=20
 sound/usb/bcd2000/bcd2000.c                             |    7=20
 sound/usb/caiaq/device.c                                |    7=20
 sound/usb/line6/driver.c                                |    7=20
 tools/perf/bench/numa.c                                 |   56 ++++++-
 tools/perf/builtin-help.c                               |    4=20
 tools/perf/builtin-top.c                                |   15 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh       |    6=20
 tools/perf/tests/task-exit.c                            |    4=20
 tools/perf/util/annotate.c                              |   18 +-
 tools/perf/util/evsel.c                                 |   12 +
 tools/perf/util/evsel.h                                 |    1=20
 tools/perf/util/parse-events.c                          |    2=20
 tools/perf/util/parse-events.h                          |    3=20
 tools/perf/util/pmu.c                                   |    5=20
 tools/testing/selftests/bpf/test_verifier.c             |  123 +++++++++++=
++++-
 virt/kvm/arm/arm.c                                      |    2=20
 virt/kvm/arm/vgic/vgic.c                                |    5=20
 177 files changed, 1200 insertions(+), 489 deletions(-)

Adam Ford (2):
      ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet
      ARM: dts: logicpd-somlv: Fix wl127x pinmux

Alexander Usyskin (1):
      mei: me: add cannon point device ids

Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Andi Kleen (1):
      perf record: Fix -c/-F options for cpu event aliases

Andre Przywara (2):
      pinctrl: sunxi: Fix A80 interrupt pin bank
      pinctrl: sunxi: Fix A64 UART mux value

Andreas Platschek (1):
      usb: dwc3: of-simple: fix missing clk_disable_unprepare

Andrew Lunn (2):
      net: dsa: mv88e6xxx: Fix interrupt masking on removal
      net: dsa: mv88e6xxx: Unregister MDIO bus on error path

Andrey Konovalov (1):
      media: pvrusb2: properly check endpoint types

Andy Shevchenko (3):
      pinctrl: denverton: Fix UART2 RTS pin mode
      iio: proximity: sx9500: Assign interrupt from GpioIo()
      brcmfmac: Avoid build error with make W=3D1

Anju T Sudhakar (1):
      powerpc/perf/imc: Fix nest-imc cpuhotplug callback failure

Ard Biesheuvel (1):
      kvm: arm: don't treat unavailable HYP mode as an error

Arnaud Patard (1):
      meson-gx-socinfo: Fix package id parsing

Arnd Bergmann (7):
      ASoC: ux500: add MODULE_LICENSE tag
      video: fbdev/mmp: add MODULE_LICENSE
      ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
      arm64: dts: add #cooling-cells to CPU nodes
      staging: fsl-mc: fix build testing on x86
      scsi: bfa: fix type conversion warning
      drm/i915: fix intel_backlight_device_register declaration

Aviv Heller (1):
      xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Branislav Radocaj (1):
      net: ethernet: arc: fix error handling in emac_rockchip_probe

Cai Li (1):
      clk: fix a panic error caused by accessing NULL pointer

Chien Tin Tung (1):
      i40iw: Allocate a sdbuf per CQP WQE

Chris Wilson (1):
      drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Christophe JAILLET (1):
      dmaengine: ioat: Fix error handling path

Claudiu Manoil (1):
      gianfar: Disable EEE autoneg by default

Cong Wang (3):
      xfrm: check id proto in validate_tmpl()
      netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Dan Carpenter (2):
      scsi: lpfc: Use after free in lpfc_rq_buf_free()
      staging: ccree: Uninitialized return in ssi_ahash_import()

Daniel Borkmann (1):
      bpf: mark dst unknown on inconsistent {s, u}bounds adjustments

Dave Young (1):
      mm/early_ioremap: Fix boot hang with earlyprintk=3Defi,keep

Dennis Dalessandro (1):
      IB/hfi1: Initialize bth1 in 16B rc ack builder

Dmitry Monakhov (1):
      IB/core: Init subsys if compiled to vmlinuz-core

Dmitry Vyukov (3):
      kcov: detect double association with a single task
      netfilter: x_tables: fix int overflow in xt_alloc_table_info()
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Douglas Gilbert (1):
      blk_rq_map_user_iov: fix error override

Eric Biggers (3):
      crypto: x86/twofish-3way - Fix %rbp usage
      binder: check for binder_thread allocation failure in binder_poll()
      509: fix printing uninitialized stack memory when OID is empty

Eric Dumazet (2):
      netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{ma=
tch|target}
      net_sched: gen_estimator: fix lockdep splat

Florian Westphal (2):
      xfrm: don't call xfrm_policy_cache_flush while holding spinlock
      xfrm: skip policies marked as dead while rehashing

Gao Feng (1):
      ipvlan: Add the skb->mark as flow4's member to lookup route

Geert Uytterhoeven (2):
      gpio: 74x164: Fix crash during .remove()
      PCI: rcar: Fix use-after-free in probe error path

Greg Kroah-Hartman (1):
      Linux 4.14.22

Greg Ungerer (1):
      m68k: add missing SOFTIRQENTRY_TEXT linker section

Gustavo A. R. Silva (1):
      dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_pr=
ep_dma_interleaved

Guy Levi (1):
      IB/mlx4: Fix RSS hash fields restrictions

Jan Beulich (1):
      xen: XEN_ACPI_PROCESSOR is Dom0-only

Jan Kara (1):
      dnotify: Handle errors from fsnotify_add_mark_locked() in fcntl_dirno=
tify()

Jann Horn (1):
      netfilter: xt_bpf: add overflow checks

Jason Wang (3):
      vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()
      ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
      ptr_ring: try vmalloc() when kmalloc() fails

Jens Axboe (1):
      blktrace: fix unlocked registration of tracepoints

Jia-Ju Bai (1):
      hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jiada Wang (1):
      ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update

Jim Mattson (1):
      KVM: VMX: fix page leak in hardware_setup()

Jiri Olsa (2):
      perf: Fix header.size for namespace events
      perf top: Fix window dimensions change handling

Johan Hovold (1):
      serdev: fix receive_buf return value when no callback

Johannes Berg (2):
      cfg80211: check dev_set_name() return value
      mac80211_hwsim: validate number of different channels

Johannes Thumshirn (1):
      scsi: bfa: fix access to bfad_im_port_s

Justin Maggard (1):
      btrfs: Fix quota reservation leak on preallocated files

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Karol Herbst (1):
      x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Keerthy (2):
      ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function
      gpio: davinci: Assign first bank regs for unbanked case

LEROY Christophe (1):
      crypto: talitos - fix Kernel Oops on hashing an empty file

Lan Tianyu (1):
      KVM/x86: Check input paging mode when cs.l is set

Laura Abbott (2):
      staging: android: ion: Add __GFP_NOWARN for system contig heap
      staging: android: ion: Switch from WARN to pr_warn

Leon Romanovsky (1):
      RDMA/netlink: Fix general protection fault

Marc Zyngier (1):
      KVM: arm/arm64: Fix spinlock acquisition in vgic_set_owner

Martijn Coenen (1):
      ANDROID: binder: synchronize_rcu() when using POLLFREE.

Mauro Carvalho Chehab (1):
      media: s5k6aa: describe some function parameters

Michael S. Tsirkin (1):
      s390/virtio: add BSD license to virtio-ccw

Michal Hocko (1):
      vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems

Moni Shoua (1):
      RDMA/cma: Make sure that PSN is not over max allowed

Mustafa Ismail (2):
      i40iw: Do not free sqbuf when event is I40IW_TIMER_TYPE_CLOSE
      i40iw: Correct ARP index mask

Namhyung Kim (1):
      perf help: Fix a bug during strstart() conversion

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel (2):
      net_sched: red: Avoid devision by zero
      net_sched: red: Avoid illegal values

Omar Sandoval (1):
      Btrfs: disable FUA if mounted with nobarrier

Pali Roh=E1r (1):
      platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitud=
e E6410

Paolo Abeni (2):
      netfilter: on sockopt() acquire sock lock only in the required scope
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Paul Moore (2):
      selinux: ensure the context is NUL terminated in security_context_to_=
sid_core()
      selinux: skip bounded transition processing if the policy isn't loaded

Peter Ujfalusi (2):
      ARM: dts: am4372: Correct the interrupts_properties of McASP
      ARM: dts: am437x-cm-t43: Correct the dmas property of spi0

Peter Zijlstra (1):
      locking/lockdep: Fix possible NULL deref

Pieter Jansen van Vuuren (1):
      nfp: fix port stats for mac representors

Rafael J. Wysocki (1):
      PM / runtime: Fix handling of suppliers with disabled runtime PM

Randy Dunlap (2):
      usb: build drivers/usb/common/ when USB_SUPPORT is set
      iio: fix kernel-doc build errors

Ravi Bangoria (2):
      perf annotate: Do not truncate instruction names at 6 chars
      powerpc/perf: Fix oops when grouping different pmu events

Ray Jui (1):
      bnxt_en: Need to unconditionally shut down RoCE in bnxt_shutdown

Russell King (3):
      sfp: fix RX_LOS signal handling
      phylink: ensure we take the link down when phylink_stop() is called
      drm/armada: fix leak of crtc structure

Sabrina Dubroca (1):
      xfrm: fix rcu usage in xfrm_get_type_offload

Sakari Ailus (1):
      media: ov13858: Select V4L2_FWNODE

Satheesh Rajendran (1):
      perf bench numa: Fixup discontiguous/sparse numa nodes

Shaohua Li (1):
      md/raid1/10: add missed blk plug

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Sowmini Varadhan (2):
      rds: tcp: correctly sequence cleanup on netns deletion.
      rds: tcp: atomically purge entries from rds_tcp_conn_list during netn=
s delete

Stefan Haberland (1):
      s390/dasd: prevent prefix I/O error

Stefan Hajnoczi (1):
      VSOCK: fix outdated sk_state value in hvs_release()

Stefan Potyra (1):
      ASoC: rockchip: disable clock on error

Stefan Schake (1):
      drm/vc4: Release fence after signalling

Steffen Klassert (3):
      esp: Fix GRO when the headers not fully in the linear part of the skb.
      xfrm: Fix stack-out-of-bounds read on socket policy lookup.
      xfrm: Fix stack-out-of-bounds with misconfigured transport mode polic=
ies.

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix leak on transmit failure

Takashi Iwai (4):
      usb: core: Add a helper function to check the validity of EP type in =
URB
      ALSA: line6: Add a sanity check for invalid EPs
      ALSA: caiaq: Add a sanity check for invalid EPs
      ALSA: bcd2000: Add a sanity check for invalid EPs

Takuo Koguchi (1):
      spi: sun4i: disable clocks in the remove function

Tetsuo Handa (1):
      mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() fa=
iled.

Thomas Richter (2):
      perf test shell: Fix check open filename arg using 'perf trace' on s3=
90x
      perf test: Fix test 21 for s390x

Tobias Jordan (1):
      dmaengine: jz4740: disable/unprepare clk if probe fails

Todd Kjos (2):
      ANDROID: binder: remove WARN() for redundant txn error
      binder: replace "%p" with "%pK"

Tom Herbert (2):
      kcm: Check if sk_user_data already set in kcm_attach
      kcm: Only allow TCP sockets to be attached to a KCM mux

Tomas Winkler (1):
      mei: me: add cannon point device ids for 4th device

Tony Lindgren (3):
      ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_co=
ntext
      ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen
      ARM: dts: Fix elm interrupt compiler warning

Vincent Pelletier (1):
      usb: dwc3: gadget: Wait longer for controller to end command processi=
ng

Wanpeng Li (1):
      KVM: x86: fix escape of guest dr6 to the host

Will Deacon (1):
      scripts/kernel-doc: Don't fail with status !=3D 0 if error encountere=
d with -none

Willem de Bruijn (1):
      net: avoid skb_warn_bad_offload on IS_ERR

Xie XiuQi (1):
      trace/xdp: fix compile warning: 'struct bpf_map' declared inside para=
meter list

Xin Long (2):
      sctp: set frag_point in sctp_setsockopt_maxseg correctly
      sctp: only update outstanding_bytes for transmitted queue when doing =
prsctp_prune

Yan Markman (1):
      net: mvpp2: allocate zeroed tx descriptors

Yunjian Wang (1):
      virtio_net: fix return value check in receive_mergeable()

Zumeng Chen (1):
      gianfar: fix a flooded alignment reports because of padding issue.

bingjingc (1):
      md/raid5: correct degraded calculation in raid5_error


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqSmV0ACgkQONu9yGCS
aT7X+A/7BZ8AdE6Jn17UXy8HGMR7VXgLPGaB4qDz6OA7Sr9+v4/eTOo95A1Ic0tT
niuJ8mvIH6I3qBRAKzYDqOUpIuW0r+0AkhY84KcnP5a1IAIDETL3UjqqVPiUxn8i
12LFjxxRm/g6EqzJyxwB+4L/Cs4DCbjZbcB06bpcP1Re3BU30CRrLhMYhbwEnWZ+
NwTS97e56ux2tDrGPL57T7Xpu5IeOZjqKuRQRdkE6xMMgqlBM4K/WbamdMSe5wb6
LR9FtwxccDp4ZL9+OKlkFx0STdtX6yoQSf2JxIcgIlGk3IATBpqPqXY68yZMxz7b
/5uOSTjXgvdoyCzvEBF+GNIi/ulW2tinf1Q1/d6IMGrkvjICkJX1YtB+QU+ZSNqk
em0/ra5iGXVg8B9EDCk3/CSa+4dKUTCEe6MwKmIwWTRsnjlsZiGDAKgNpatOioap
gRxleX92mEAcNnO88SXauZtYgxGJDRlI51NU/tMfBtdt8V7ntbg0rvGPBnTw4JS1
QBFq4spJHCzUfu6kRWsJpccgNFW3OjFminRXhNic++x/+l7wEOse7BLnWK3Gka6h
qX39sz+R8Evmp8vG5VpBl4Cb9n5Y03Y2CP3H/N1ad6x4vIeTLNCbUtbiQPRz6xda
rM0SKK+VwzVL6j8uwcDjjz6BZJBBv7HZsYa7xk8ShuWoARrq+84=
=AZrd
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
