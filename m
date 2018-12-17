Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FCDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865C32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545036958;
	bh=+XOy9X/QuKNGc/rF8zZa3k2gFCpAPmypI8JBS9nTMfQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=k9pIhHFrOInLWHx5K4z9h7yFCkviDb3uY5mMh0GdZOgXAtj8h7Lm8I3QhiNA2qNrj
	 qow5EktKcxV2Ur93OkgFa02h/Iy+5SNIcgNyuGcmwj4pX8ly8bRna6ejIzduHIIJVs
	 DikWgX9c/M4p5xmtMDq48kO20GD8HO9BSYFYULHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbeLQIz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbeLQIz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:55:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245462084D;
        Mon, 17 Dec 2018 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545036954;
        bh=+XOy9X/QuKNGc/rF8zZa3k2gFCpAPmypI8JBS9nTMfQ=;
        h=Date:From:To:Cc:Subject:From;
        b=RjHmmU55LXbEr68lbCYTtc0UIEhKVfLRicYe//p4lK1+3LtmdM+x31chlKmw+OCfV
         /8QEd35YUbpTQLb964evWkCQAV3/YQL9D1EKj/jW6GRF+PBVyIu8HbmoZTPwukEGho
         hIoy5m7D0kV31LUDnUP+/ammJ7/NPwtiSqqCcTkY=
Date:   Mon, 17 Dec 2018 09:55:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.10
Message-ID: <20181217085552.GA1054@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.10 kernel.

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

 Makefile                                               |    2=20
 arch/arm/boot/dts/am3517-evm.dts                       |    2=20
 arch/arm/boot/dts/am3517-som.dtsi                      |    2=20
 arch/arm/boot/dts/logicpd-som-lv.dtsi                  |    2=20
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts      |    2=20
 arch/arm/boot/dts/sama5d2.dtsi                         |    2=20
 arch/arm/mach-omap1/board-ams-delta.c                  |    3=20
 arch/arm/mach-omap2/prm44xx.c                          |    2=20
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                |    4=20
 arch/s390/kernel/perf_cpum_cf.c                        |    2=20
 arch/x86/kvm/lapic.c                                   |    2=20
 arch/x86/kvm/vmx.c                                     |   29 +-
 arch/x86/xen/enlighten.c                               |   78 ------
 arch/x86/xen/setup.c                                   |    6=20
 drivers/acpi/arm64/iort.c                              |    2=20
 drivers/fsi/Kconfig                                    |    1=20
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                  |    7=20
 drivers/gpu/drm/ast/ast_mode.c                         |   36 ++
 drivers/gpu/drm/meson/meson_venc.c                     |    1=20
 drivers/hwmon/ina2xx.c                                 |    6=20
 drivers/hwmon/mlxreg-fan.c                             |    2=20
 drivers/hwmon/raspberrypi-hwmon.c                      |    6=20
 drivers/hwmon/w83795.c                                 |    2=20
 drivers/infiniband/core/roce_gid_mgmt.c                |    6=20
 drivers/infiniband/hw/bnxt_re/main.c                   |    3=20
 drivers/infiniband/hw/hfi1/chip.c                      |    3=20
 drivers/infiniband/hw/hfi1/hfi.h                       |    2=20
 drivers/infiniband/hw/hfi1/verbs.c                     |    2=20
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c             |  128 ++++------
 drivers/infiniband/hw/mlx5/odp.c                       |    1=20
 drivers/infiniband/hw/mlx5/qp.c                        |   19 -
 drivers/infiniband/sw/rdmavt/ah.c                      |    4=20
 drivers/infiniband/sw/rdmavt/ah.h                      |    3=20
 drivers/net/ethernet/cavium/thunder/nic_main.c         |    3=20
 drivers/net/ethernet/hisilicon/hip04_eth.c             |    4=20
 drivers/net/ethernet/ibm/emac/emac.h                   |    2=20
 drivers/net/ethernet/intel/igb/e1000_i210.c            |    1=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c          |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c        |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c         |    4=20
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h           |    1=20
 drivers/net/ethernet/realtek/8139cp.c                  |    5=20
 drivers/net/phy/phy_device.c                           |   19 -
 drivers/net/phy/sfp-bus.c                              |    2=20
 drivers/net/tun.c                                      |    6=20
 drivers/net/virtio_net.c                               |   14 -
 drivers/nvme/host/core.c                               |    4=20
 drivers/nvme/host/nvme.h                               |    3=20
 drivers/nvme/host/rdma.c                               |    2=20
 drivers/pci/controller/dwc/pci-imx6.c                  |   10=20
 drivers/phy/qualcomm/phy-qcom-qusb2.c                  |   20 -
 drivers/s390/cio/vfio_ccw_cp.c                         |    6=20
 drivers/spi/spi-omap2-mcspi.c                          |   37 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c         |    2=20
 drivers/thunderbolt/switch.c                           |   40 +++
 drivers/usb/gadget/function/u_ether.c                  |   11=20
 drivers/usb/gadget/udc/omap_udc.c                      |   88 ++-----
 drivers/xen/balloon.c                                  |   65 -----
 drivers/xen/pvcalls-front.c                            |    4=20
 drivers/xen/xlate_mmu.c                                |    1=20
 fs/afs/inode.c                                         |   18 -
 fs/aio.c                                               |    1=20
 fs/btrfs/send.c                                        |   11=20
 fs/cachefiles/namei.c                                  |    6=20
 fs/cachefiles/rdwr.c                                   |    9=20
 fs/cachefiles/xattr.c                                  |    3=20
 fs/dax.c                                               |    2=20
 fs/exportfs/expfs.c                                    |    2=20
 fs/fscache/object.c                                    |    3=20
 fs/hfs/btree.c                                         |    3=20
 fs/hfsplus/btree.c                                     |    3=20
 fs/nfs/flexfilelayout/flexfilelayout.c                 |    6=20
 fs/ocfs2/export.c                                      |    2=20
 fs/ocfs2/move_extents.c                                |   47 ++-
 fs/pstore/ram.c                                        |   15 -
 fs/sysv/inode.c                                        |    2=20
 include/linux/fscache-cache.h                          |    3=20
 include/linux/pstore.h                                 |    5=20
 include/linux/skbuff.h                                 |   11=20
 include/net/neighbour.h                                |   28 +-
 include/net/netfilter/ipv4/nf_nat_masquerade.h         |    2=20
 include/net/netfilter/ipv6/nf_nat_masquerade.h         |    2=20
 include/net/sctp/structs.h                             |    2=20
 include/xen/balloon.h                                  |    5=20
 init/initramfs.c                                       |   22 -
 kernel/bpf/local_storage.c                             |    3=20
 kernel/bpf/verifier.c                                  |    2=20
 kernel/kcov.c                                          |    4=20
 kernel/trace/bpf_trace.c                               |    8=20
 lib/debugobjects.c                                     |    5=20
 mm/page_alloc.c                                        |    4=20
 net/core/dev.c                                         |   61 ++--
 net/core/rtnetlink.c                                   |    3=20
 net/ipv4/ip_fragment.c                                 |    7=20
 net/ipv4/ip_input.c                                    |    4=20
 net/ipv4/netfilter/ipt_MASQUERADE.c                    |    7=20
 net/ipv4/netfilter/nf_nat_masquerade_ipv4.c            |   38 ++-
 net/ipv4/netfilter/nft_masq_ipv4.c                     |    4=20
 net/ipv4/tcp_output.c                                  |   43 ++-
 net/ipv6/ip6_input.c                                   |    4=20
 net/ipv6/ip6_output.c                                  |   42 +--
 net/ipv6/netfilter.c                                   |    3=20
 net/ipv6/netfilter/ip6t_MASQUERADE.c                   |    8=20
 net/ipv6/netfilter/nf_conntrack_reasm.c                |    8=20
 net/ipv6/netfilter/nf_nat_masquerade_ipv6.c            |   49 ++--
 net/ipv6/netfilter/nft_masq_ipv6.c                     |    4=20
 net/ipv6/reassembly.c                                  |    8=20
 net/ipv6/seg6_iptunnel.c                               |    1=20
 net/netfilter/ipvs/ip_vs_ctl.c                         |    3=20
 net/netfilter/nf_conncount.c                           |   44 ++-
 net/netfilter/nf_tables_api.c                          |   29 --
 net/netfilter/nft_compat.c                             |    3=20
 net/netfilter/nft_flow_offload.c                       |    5=20
 net/netfilter/xt_RATEEST.c                             |   10=20
 net/netfilter/xt_hashlimit.c                           |    9=20
 net/sched/sch_netem.c                                  |    3=20
 net/sctp/associola.c                                   |    9=20
 net/sctp/sm_make_chunk.c                               |    3=20
 sound/firewire/fireface/ff-protocol-ff400.c            |    2=20
 sound/pci/hda/patch_realtek.c                          |   77 ++++++
 sound/soc/codecs/hdac_hdmi.c                           |   11=20
 sound/soc/codecs/wm_adsp.c                             |   37 +--
 sound/soc/intel/skylake/skl.c                          |   12=20
 sound/soc/omap/omap-abe-twl6040.c                      |   67 ++---
 sound/soc/omap/omap-dmic.c                             |    9=20
 sound/soc/omap/omap-mcbsp.c                            |    6=20
 sound/soc/omap/omap-mcpdm.c                            |   43 +++
 sound/soc/qcom/common.c                                |    9=20
 sound/soc/qcom/qdsp6/q6afe-dai.c                       |  208 ++++++++----=
-----
 sound/soc/qcom/qdsp6/q6afe.c                           |   16 -
 sound/soc/rockchip/rockchip_pcm.c                      |    1=20
 sound/soc/sh/rcar/ssi.c                                |    2=20
 sound/soc/soc-acpi.c                                   |   10=20
 sound/soc/soc-core.c                                   |    1=20
 sound/soc/sunxi/sun8i-codec.c                          |    6=20
 sound/usb/quirks-table.h                               |   10=20
 tools/bpf/bpftool/common.c                             |    2=20
 tools/bpf/bpftool/prog.c                               |   10=20
 tools/objtool/elf.c                                    |   19 +
 tools/perf/tests/attr/base-record                      |    2=20
 tools/perf/util/evsel.c                                |    2=20
 tools/perf/util/namespaces.c                           |   17 +
 tools/perf/util/namespaces.h                           |    1=20
 tools/testing/selftests/Makefile                       |    1=20
 tools/testing/selftests/bpf/test_verifier.c            |   19 +
 tools/testing/selftests/netfilter/Makefile             |    6=20
 tools/testing/selftests/netfilter/config               |    2=20
 tools/testing/selftests/netfilter/nft_trans_stress.sh  |   78 ++++++
 tools/testing/selftests/proc/proc-self-map-files-002.c |    9=20
 149 files changed, 1242 insertions(+), 838 deletions(-)

Aaro Koskinen (5):
      USB: omap_udc: use devm_request_irq()
      USB: omap_udc: fix crashes on probe error and module removal
      USB: omap_udc: fix omap_udc_start() on 15xx machines
      USB: omap_udc: fix USB gadget functionality on Palm Tungsten E
      USB: omap_udc: fix rejection of out transfers when DMA is used

Adam Ford (4):
      ARM: dts: am3517: Fix pinmuxing for CD on MMC1
      ARM: dts: LogicPD Torpedo: Fix mmc3_dat1 interrupt
      ARM: dts: logicpd-somlv: Fix interrupt on mmc3_dat1
      ARM: dts: am3517-som: Fix WL127x Wifi interrupt

Alexey Dobriyan (1):
      proc: fixup map_files test on arm

Alin Nastac (1):
      netfilter: ipv6: Preserve link scope traffic original oif

Anders Roxell (1):
      kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace

Arnd Bergmann (1):
      fsi: master-ast-cf: select GENERIC_ALLOCATOR

Artem Savkov (2):
      objtool: Fix double-free in .cold detection error path
      objtool: Fix segfault in .cold detection with -ffunction-sections

Artemy Kovalyov (1):
      IB/mlx5: Fix page fault handling for MW

Baruch Siach (1):
      net: phy: sfp: correct store of detected link modes

Benjamin Herrenschmidt (1):
      Revert "net/ibm/emac: wrong bit is used for STA control"

Bjorn Andersson (1):
      arm64: dts: sdm845-mtp: Reserve reserved gpios

Chris Chiu (1):
      ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Christian Hewitt (1):
      drm/meson: add support for 1080p25 mode

Christoph Hellwig (1):
      nvme: warn when finding multi-port subsystems without multipathing en=
abled

Christoph Paasch (1):
      net: Prevent invalid access to skb->prev in __qdisc_drop_all

Christophe JAILLET (1):
      staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_=
read32()'

Colin Ian King (1):
      fscache, cachefiles: remove redundant variable 'cache'

David Howells (2):
      cachefiles: Fix an assertion failure when trying to update a failed o=
bject
      afs: Fix validation/callback interaction

Edward Cree (2):
      net: use skb_list_del_init() to remove from RX sublists
      bpf: fix off-by-one error in adjust_subprog_starts

Eran Ben Elisha (1):
      net/mlx4_en: Change min MTU size to ETH_MIN_MTU

Eric Dumazet (3):
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices
      tcp: Do not underestimate rwnd_limited
      tcp: lack of available data can also cause TSO defer

Eric Farman (2):
      s390/cio: Fix cleanup of pfn_array alloc failure
      s390/cio: Fix cleanup when unsupported IDA format is used

Florian Westphal (3):
      netfilter: nf_tables: don't skip inactive chains during update
      selftests: add script to stress-test nft packet path vs. control plane
      netfilter: nf_tables: fix use-after-free when deleting compat express=
ions

Greg Kroah-Hartman (1):
      Linux 4.19.10

Heiner Kallweit (1):
      net: phy: don't allow __set_phy_supported to add unsupported modes

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Hui Wang (2):
      ALSA: usb-audio: Add vendor and product name for Dell WD19 Dock
      ALSA: hda/realtek - Fix the mute LED regresion on Lenovo X1 Carbon

Igor Druzhinin (1):
      Revert "xen/balloon: Mark unallocated host memory as UNUSABLE"

Jakub Kicinski (1):
      tools: bpftool: fix potential NULL pointer dereference in do_load

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Jason Wang (1):
      virtio-net: keep vnet header zeroed after processing XDP

Jens Axboe (1):
      aio: fix failure to put the file pointer

Jian-Hong Pan (2):
      ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
      ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with AL=
C294

Jiri Olsa (2):
      perf tools: Fix crash on synthesizing the unit
      perf tools: Restore proper cwd on return from mnt namespace

Jiri Wiesner (1):
      ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes

Josh Elsasser (1):
      ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Kailang Yang (1):
      ALSA: hda/realtek - Fixed headphone issue for ALC700

Kamal Heib (1):
      RDMA/rdmavt: Fix rvt_create_ah function signature

Katsuhiro Suzuki (1):
      ASoC: rockchip: add missing slave_config setting for I2S

Kees Cook (1):
      pstore/ram: Correctly calculate usable PRZ bytes

Keyon Jie (1):
      ASoC: acpi: fix: continue searching when machine is ignored

Kiran Kumar Modukuri (1):
      cachefiles: Fix page leak in cachefiles_read_backing_file while vmsca=
n is active

Kuninori Morimoto (1):
      ASoC: rsnd: fixup clock start checker

Larry Chen (1):
      ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Li Zhijian (1):
      initramfs: clean old path before creating a hardlink

Liran Alon (1):
      KVM: VMX: Update shared MSRs to be saved/restored on MSR_EFER.LMA cha=
nges

Lorenzo Bianconi (1):
      net: thunderx: fix NULL pointer dereference in nic_remove

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_get_platform_device_domain() uninitialized pointe=
r value

Majd Dibbiny (1):
      RDMA/mlx5: Fix fence type for IB_WR_LOCAL_INV WR

Manu Gautam (2):
      phy: qcom-qusb2: Use HSTX_TRIM fused value as is
      phy: qcom-qusb2: Fix HSTX_TRIM tuning with fused value for SDM845

Marek Szyprowski (1):
      usb: gadget: u_ether: fix unsafe list iteration

Martynas Pumputis (1):
      bpf: fix check of allowed specifiers in bpf_trace_printk

Matthew Wilcox (1):
      dax: Check page->mapping isn't NULL

Mika Westerberg (1):
      thunderbolt: Prevent root port runtime suspend during NVM upgrade

Nathan Chancellor (2):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_i=
o_wakeup
      cachefiles: Explicitly cast enumerated type in put_object

NeilBrown (1):
      fscache: fix race between enablement and dropping of object

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Nicolin Chen (2):
      hwmon (ina2xx) Fix NULL id pointer in probe()
      hwmon: (ina2xx) Fix current value calculation

Pan Bian (6):
      exportfs: do not read dentry after free
      net: hisilicon: remove unexpected free_netdev
      pvcalls-front: fixes incorrect error handling
      hfs: do not free node before using
      hfsplus: do not free node before using
      ocfs2: fix potential use after free

Parav Pandit (1):
      RDMA/core: Add GIDs while changing MAC addr only for registered ndev

Peter Ujfalusi (4):
      ASoC: omap-abe-twl6040: Fix missing audio card caused by deferred pro=
bing
      ASoC: omap-mcbsp: Fix latency value calculation for pm_qos
      ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CP=
U_IDLE
      ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Pierre-Louis Bossart (1):
      ASoC: Intel: Power down links before turning off display audio power

Piotr Stankiewicz (1):
      IB/hfi1: Fix an out-of-bounds access in get_hw_stats

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Qian Cai (1):
      debugobjects: avoid recursive calls with kmemleak

Quentin Monnet (1):
      tools: bpftool: prevent infinite loop in get_fdinfo()

Richard Fitzgerald (1):
      ASoC: wm_adsp: Fix dma-unsafe read of scratch registers

Robbie Ko (1):
      Btrfs: send, fix infinite loop due to directory rename dependencies

Rohit kumar (2):
      ASoC: qdsp6: q6afe: Fix wrong MI2S SD line mask
      ASoC: qcom: Set dai_link id to each dai_link

Romain Izard (1):
      ARM: dts: at91: sama5d2: use the divided clock for SMC

Roman Gushchin (1):
      bpf: allocate local storage buffers using GFP_ATOMIC

Sabrina Dubroca (2):
      net: restore call to netdev_queue_numa_node_write when resetting XPS
      net: fix XPS static_key accounting

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

Selvin Xavier (2):
      RDMA/bnxt_re: Fix system hang when registration with L2 driver fails
      RDMA/bnxt_re: Avoid accessing the device structure after it is freed

Shmulik Ladkani (1):
      ipv6: sr: properly initialize flowi6 prior passing to ip6_route_output

Srikanth Boddepalli (1):
      xen: xlate_mmu: add missing header to fix 'W=3D1' warning

Srinivas Kandagatla (1):
      ASoC: qdsp6: q6afe-dai: Fix the dai widgets

Stefan Wahren (1):
      hwmon: (raspberrypi) Fix initial notify

Stefano Brivio (2):
      ipv6: Check available headroom in ip6_xmit() even without options
      neighbour: Avoid writing before skb->head in neigh_hh_output()

Su Yanjun (1):
      net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Taehee Yoo (9):
      netfilter: nf_conncount: use spin_lock_bh instead of spin_lock
      netfilter: nf_conncount: fix list_del corruption in conn_free
      netfilter: nf_conncount: fix unexpected permanent node of list.
      netfilter: xt_RATEEST: remove netns exit routine
      netfilter: xt_hashlimit: fix a possible memory leak in htable_create()
      netfilter: add missing error handling code for register functions
      netfilter: nat: fix double register in masquerade modules
      netfilter: nf_conncount: remove wrong condition check routine
      netfilter: nf_tables: deactivate expressions in rule replecement rout=
ine

Takashi Sakamoto (1):
      ALSA: fireface: fix reference to wrong register for clock configurati=
on

Tarick Bedeir (1):
      net/mlx4_core: Correctly set PFC param if global pause is turned off.

Thomas Richter (1):
      s390/cpum_cf: Reject request for sampling in event initialization

Tigran Mkrtchyan (1):
      flexfiles: enforce per-mirror stateid only for v4 DSes

Tony Lindgren (1):
      spi: omap2-mcspi: Add missing suspend and resume calls

Trent Piepho (1):
      PCI: imx6: Fix link training status detection in link up check

Tzung-Bi Shih (1):
      ASoC: dapm: Recalculate audio map forcely when card instantiated

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Fix macros for tacho fault reading

Vasily Khoruzhick (1):
      ASoC: sun8i-codec: fix crash on module removal

Wei Yang (1):
      mm/page_alloc.c: fix calculation of pgdat->nr_zones

Xin Long (3):
      sctp: kfree_rcu asoc
      sctp: update frag_point when stream_interleave is set
      ipvs: call ip_vs_dst_notifier earlier than ipv6_dev_notf

Y.C. Chen (1):
      drm/ast: fixed reading monitor EDID not stable issue

Yi Wang (2):
      KVM: x86: fix empty-body warnings
      x86/kvm/vmx: fix old-style function declaration

Yixian Liu (1):
      RDMA/hns: Bugfix pbl configuration for rereg mr

Yuchung Cheng (1):
      tcp: fix NULL ref in tail loss probe

YueHaibing (1):
      sysv: return 'err' instead of 0 in __sysv_write_inode

Yunjian Wang (1):
      igb: fix uninitialized variables

kiran.modukuri (1):
      fscache: Fix race in fscache_op_complete() due to split atomic_sub & =
read

shaoyunl (1):
      drm/amdgpu: Add delay after enable RLC ucode


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwXZJYACgkQONu9yGCS
aT4bWhAAkFXeSC2lTobtBvm6F4IApqx8229DaQDbc+AiLPtt47ZSvKszzXH251lL
sw97oypGQwM76vhNpgkqg/mPxHH6DQwGz4hN/Yr/nEDet4afad12eWn+j3wvqvuh
ZQtU6rojT7Cg1TlMGXuEdBtWbJhmNrKpVGGlA0KUiXhJvPUTg/QMfmqa/sS/d/ib
iRjGyMZKoJeyIO5m+1PIxm3UsPssq27YcJ7HUKiWlXG40eqpx4dkeiPGYx/tNxXd
GyKZvqVTqyFRm9RF5so68p29TvNmWLXgjiO3uAhcBnrZgFHWZYHIm2TQjP8pOlHd
k6L/8tgFcVAHUMQ1vDrmNKppgYehZfoi//0SiRcDqV/kdvuQ7hDh1gJjS+wLdGy7
AdPwC12Prt3VDKnmmqJWgMELC+azDuxArSUzDyyPkmvpRMhg0y5UO7TnJRV4uJHb
yGIqkGW6y4xhmR7+NdRFBhngc7SjhZDpsKYgar9ZzB4mTeR2vZ2xLzByv9H81hPC
QGXwiL20fqU69BucHkB390VcElByIw/iwssm78xcMU/EgRY94eK3TSPjsFD+JIbe
KJ4GiFCZTNPIIYUm0+4+9peDdMyzX1Ac5Rx+PESmUm6WC2oYLgQuYOWhgri2OsmL
hBr4wbBOm5oaqg5AtOFF0jmNK6+hlKrnl1Y0Ixm630aKfnoyj/E=
=/KL3
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
