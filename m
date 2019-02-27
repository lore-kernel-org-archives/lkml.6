Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863A1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7420C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 11:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551266358;
	bh=ORbdinYkkrCquyUYgVrm0OjeEkOjlOIgO0Cp+ZHfJKc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=SG8YDVjsv0f+fMEDoQqmPJ+R9EaHWBOhbV6ss5nv5CluiSQhVd108m8hRrTn+8Xs2
	 +9f/F8z0KJO4ws1ypgbjrlq06NIQbtUARwGAH/Z7KfcLru84Y4NoXn+EsppBDGJaZZ
	 O9FMELiLbI5vWglfKzd7jT72loVqGA9UfXL3KflU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbfB0LTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 06:19:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfB0LTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 06:19:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F58320C01;
        Wed, 27 Feb 2019 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551266353;
        bh=ORbdinYkkrCquyUYgVrm0OjeEkOjlOIgO0Cp+ZHfJKc=;
        h=Date:From:To:Cc:Subject:From;
        b=XdY9j8U6bbZucNjLGNdogkhhE4ZMyiIbb/TTEWG6KIN6PTSh0hpAp3LDY98+WZMEl
         CGPn3IREj7sH63Gp2gOIKG7nwvu/PbJqrIkmwuDD+liebbkD0PZaubQHeOmPXqPTlK
         XY0eOrx/wjDYu/AupVI2gNZ++16XM/dRieqPyQwM=
Date:   Wed, 27 Feb 2019 12:19:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.20.13
Message-ID: <20190227111910.GA8575@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.20.13 kernel.

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

 Makefile                                                            |    2=
=20
 arch/arc/include/asm/cache.h                                        |   11=
=20
 arch/arc/kernel/head.S                                              |   14=
=20
 arch/arc/kernel/setup.c                                             |   87=
=20
 arch/arm/probes/kprobes/opt-arm.c                                   |    2=
=20
 arch/mips/configs/ath79_defconfig                                   |    1=
=20
 arch/mips/jazz/jazzdma.c                                            |    5=
=20
 arch/mips/net/ebpf_jit.c                                            |    9=
=20
 arch/parisc/kernel/ptrace.c                                         |   29=
=20
 arch/powerpc/kernel/head_8xx.S                                      |    3=
=20
 arch/s390/kvm/vsie.c                                                |    2=
=20
 arch/x86/include/asm/kvm_host.h                                     |    2=
=20
 arch/x86/kvm/cpuid.c                                                |    4=
=20
 arch/x86/kvm/mmu.c                                                  |   18=
=20
 arch/x86/xen/enlighten_pv.c                                         |    5=
=20
 drivers/acpi/bus.c                                                  |   24=
=20
 drivers/acpi/nfit/core.c                                            |    6=
=20
 drivers/atm/he.c                                                    |    2=
=20
 drivers/clk/at91/at91sam9x5.c                                       |    5=
=20
 drivers/clk/at91/sama5d2.c                                          |    4=
=20
 drivers/clk/at91/sama5d4.c                                          |    2=
=20
 drivers/cpufreq/scmi-cpufreq.c                                      |    2=
=20
 drivers/gpio/gpio-mt7621.c                                          |   20=
=20
 drivers/gpio/gpio-pxa.c                                             |    1=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                             |    1=
=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                              |    2=
=20
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                           |   12=
=20
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |    5=
=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c         |    7=
=20
 drivers/gpu/drm/i915/intel_fbdev.c                                  |   12=
=20
 drivers/gpu/drm/meson/meson_drv.c                                   |    9=
=20
 drivers/gpu/drm/radeon/radeon_kms.c                                 |    1=
=20
 drivers/gpu/drm/sun4i/sun4i_backend.c                               |    5=
=20
 drivers/hwmon/nct6775.c                                             |   12=
=20
 drivers/hwmon/tmp421.c                                              |    2=
=20
 drivers/infiniband/hw/mthca/mthca_provider.c                        |    4=
=20
 drivers/infiniband/ulp/srp/ib_srp.c                                 |   10=
=20
 drivers/isdn/hardware/avm/b1.c                                      |    2=
=20
 drivers/isdn/i4l/isdn_tty.c                                         |    6=
=20
 drivers/leds/leds-lp5523.c                                          |    4=
=20
 drivers/mfd/Kconfig                                                 |    1=
=20
 drivers/mfd/ab8500-core.c                                           |    2=
=20
 drivers/mfd/axp20x.c                                                |  126=
 -
 drivers/mfd/bd9571mwv.c                                             |    1=
=20
 drivers/mfd/cros_ec_dev.c                                           |    1=
=20
 drivers/mfd/db8500-prcmu.c                                          |    4=
=20
 drivers/mfd/mc13xxx-core.c                                          |    4=
=20
 drivers/mfd/mt6397-core.c                                           |    3=
=20
 drivers/mfd/qcom_rpm.c                                              |    4=
=20
 drivers/mfd/ti_am335x_tscadc.c                                      |    5=
=20
 drivers/mfd/tps65218.c                                              |   24=
=20
 drivers/mfd/twl-core.c                                              |    4=
=20
 drivers/mfd/wm5110-tables.c                                         |    2=
=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c                        |   10=
=20
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c                      |    6=
=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c                   |    6=
=20
 drivers/net/ethernet/mellanox/mlx4/en_rx.c                          |   22=
=20
 drivers/net/ethernet/mellanox/mlx4/icm.c                            |   92=
=20
 drivers/net/ethernet/mellanox/mlx4/icm.h                            |   22=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en.h                        |    1=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c                    |    6=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h                    |   17=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c                   |    2=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c                    |    1=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                     |   25=
=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                     |    6=
=20
 drivers/net/ethernet/mellanox/mlxsw/Kconfig                         |    1=
=20
 drivers/net/ethernet/mellanox/mlxsw/pci.c                           |    4=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_ctcam.c            |   10=
=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c            |   12=
=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c                           |    4=
=20
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c                  |    6=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                   |   51=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c                    |   10=
=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c                     |    2=
=20
 drivers/net/geneve.c                                                |   10=
=20
 drivers/net/phy/micrel.c                                            |    1=
=20
 drivers/net/phy/phylink.c                                           |   19=
=20
 drivers/net/phy/sfp-bus.c                                           |    2=
=20
 drivers/net/phy/sfp.c                                               |   30=
=20
 drivers/net/phy/sfp.h                                               |    2=
=20
 drivers/net/team/team.c                                             |   27=
=20
 drivers/net/wan/fsl_ucc_hdlc.c                                      |   62=
=20
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c                     |   46=
=20
 drivers/pinctrl/pinctrl-max77620.c                                  |   14=
=20
 drivers/pinctrl/qcom/pinctrl-qcs404.c                               |    2=
=20
 drivers/scsi/cxgbi/cxgb3i/cxgb3i.c                                  |    9=
=20
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c                                  |   28=
=20
 drivers/scsi/cxgbi/libcxgbi.c                                       |    7=
=20
 drivers/scsi/cxgbi/libcxgbi.h                                       |    5=
=20
 drivers/scsi/isci/init.c                                            |   14=
=20
 drivers/scsi/qedi/qedi_iscsi.c                                      |    3=
=20
 drivers/scsi/qedi/qedi_iscsi.h                                      |    1=
=20
 drivers/scsi/qla1280.c                                              |    2=
=20
 drivers/scsi/qla4xxx/ql4_os.c                                       |    2=
=20
 drivers/scsi/sd_zbc.c                                               |    8=
=20
 drivers/scsi/ufs/ufs.h                                              |    2=
=20
 drivers/scsi/ufs/ufshcd.c                                           |    2=
=20
 drivers/soc/fsl/qe/qe_tdm.c                                         |   55=
=20
 drivers/staging/erofs/dir.c                                         |    7=
=20
 drivers/staging/erofs/inode.c                                       |   10=
=20
 drivers/staging/erofs/internal.h                                    |   70=
=20
 drivers/staging/erofs/super.c                                       |   19=
=20
 drivers/staging/erofs/unzip_pagevec.h                               |    2=
=20
 drivers/staging/erofs/unzip_vle.c                                   |   35=
=20
 drivers/staging/erofs/unzip_vle_lz4.c                               |    2=
=20
 drivers/staging/erofs/utils.c                                       |   12=
=20
 drivers/target/target_core_user.c                                   |   88=
=20
 drivers/vhost/scsi.c                                                |   20=
=20
 drivers/vhost/vhost.c                                               |    8=
=20
 drivers/video/backlight/pwm_bl.c                                    |   19=
=20
 drivers/watchdog/mt7621_wdt.c                                       |    1=
=20
 drivers/watchdog/rt2880_wdt.c                                       |    1=
=20
 drivers/xen/pvcalls-back.c                                          |    9=
=20
 drivers/xen/pvcalls-front.c                                         |  100=
=20
 fs/afs/flock.c                                                      |    4=
=20
 fs/afs/inode.c                                                      |    3=
=20
 fs/afs/protocol_yfs.h                                               |   11=
=20
 fs/afs/rxrpc.c                                                      |   53=
=20
 fs/afs/yfsclient.c                                                  |    2=
=20
 fs/ceph/snap.c                                                      |    3=
=20
 fs/proc/base.c                                                      |    4=
=20
 include/keys/user-type.h                                            |    2=
=20
 include/linux/compiler-clang.h                                      |    5=
=20
 include/linux/compiler-gcc.h                                        |    4=
=20
 include/linux/compiler-intel.h                                      |    4=
=20
 include/linux/compiler.h                                            |    4=
=20
 include/linux/qed/qed_chain.h                                       |   31=
=20
 include/linux/skbuff.h                                              |    2=
=20
 include/linux/virtio_net.h                                          |   19=
=20
 include/net/netfilter/nf_flow_table.h                               |    1=
=20
 include/sound/soc.h                                                 |    6=
=20
 include/trace/events/afs.h                                          |    2=
=20
 include/uapi/linux/inet_diag.h                                      |   16=
=20
 kernel/bpf/stackmap.c                                               |   12=
=20
 kernel/trace/trace.c                                                |    2=
=20
 kernel/trace/trace_kprobe.c                                         |   10=
=20
 mm/mempolicy.c                                                      |    6=
=20
 net/batman-adv/soft-interface.c                                     |    2=
=20
 net/bridge/br_fdb.c                                                 |    5=
=20
 net/bridge/br_multicast.c                                           |    9=
=20
 net/ceph/messenger.c                                                |   15=
=20
 net/core/filter.c                                                   |   11=
=20
 net/dsa/port.c                                                      |    4=
=20
 net/ipv4/inet_diag.c                                                |   10=
=20
 net/ipv4/netfilter/ipt_CLUSTERIP.c                                  |   19=
=20
 net/ipv6/netfilter.c                                                |    4=
=20
 net/ipv6/seg6.c                                                     |    4=
=20
 net/ipv6/sit.c                                                      |    3=
=20
 net/ipv6/udp.c                                                      |    8=
=20
 net/mac80211/cfg.c                                                  |    6=
=20
 net/mac80211/main.c                                                 |    4=
=20
 net/mac80211/mesh.h                                                 |    6=
=20
 net/mac80211/mesh_pathtbl.c                                         |  155=
 -
 net/mac80211/rx.c                                                   |    7=
=20
 net/netfilter/nf_flow_table_core.c                                  |    5=
=20
 net/netfilter/nf_tables_api.c                                       |    5=
=20
 net/netfilter/nfnetlink_osf.c                                       |    4=
=20
 net/netfilter/nft_compat.c                                          |    3=
=20
 net/netfilter/nft_flow_offload.c                                    |   13=
=20
 net/packet/af_packet.c                                              |    2=
=20
 net/sched/cls_tcindex.c                                             |   80=
=20
 net/sctp/diag.c                                                     |    1=
=20
 net/sctp/offload.c                                                  |    1=
=20
 net/sctp/stream.c                                                   |    4=
=20
 net/socket.c                                                        |   82=
=20
 net/sunrpc/auth_gss/auth_gss.c                                      |   12=
=20
 net/sunrpc/clnt.c                                                   |   20=
=20
 net/sunrpc/xprt.c                                                   |    1=
=20
 net/sunrpc/xprtrdma/verbs.c                                         |    6=
=20
 net/xdp/xdp_umem.c                                                  |   16=
=20
 samples/bpf/Makefile                                                |    1=
=20
 samples/bpf/asm_goto_workaround.h                                   |   16=
=20
 security/keys/key.c                                                 |    4=
=20
 security/keys/keyring.c                                             |    4=
=20
 security/keys/proc.c                                                |    3=
=20
 security/keys/request_key.c                                         |    1=
=20
 security/keys/request_key_auth.c                                    |    2=
=20
 sound/pci/hda/patch_realtek.c                                       |   42=
=20
 sound/soc/soc-core.c                                                |   11=
=20
 tools/include/uapi/linux/pkt_sched.h                                | 1163=
 ++++++++++
 tools/testing/selftests/bpf/Makefile                                |    5=
=20
 tools/testing/selftests/bpf/test_progs.c                            |   30=
=20
 tools/testing/selftests/bpf/test_sock_addr.c                        |   53=
=20
 tools/testing/selftests/net/forwarding/bridge_vlan_aware.sh         |   47=
=20
 tools/testing/selftests/net/ip_defrag.c                             |   96=
=20
 tools/testing/selftests/net/ip_defrag.sh                            |    9=
=20
 tools/testing/selftests/tc-testing/tc-tests/actions/ife.json        |   88=
=20
 tools/testing/selftests/tc-testing/tc-tests/actions/tunnel_key.json |   31=
=20
 189 files changed, 2953 insertions(+), 993 deletions(-)

Alban Bedel (1):
      MIPS: ath79: Enable OF serial ports in the default config

Alex Deucher (1):
      drm/amdgpu: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Alexandre Belloni (2):
      clk: at91: fix masterck name
      clk: at91: fix at91sam9x5 peripheral clock number

Alexey Brodkin (1):
      ARC: define ARCH_SLAB_MINALIGN =3D 8

Anders Roxell (1):
      selftests: bpf: install files tcp_(server|client)*.py

Andrey Ignatov (2):
      bpf: Fix [::] -> [::1] rewrite in sys_sendmsg
      selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock=
_addr

Arthur Kiyanovski (1):
      net: ena: fix race between link up and device initalization

Avri Altman (1):
      scsi: ufs: Fix geometry descriptor size

Bart Van Assche (1):
      RDMA/srp: Rework SCSI device reset handling

Bijan Mottahedeh (1):
      vhost/scsi: Use copy_to_iter() to send control queue response

Bjorn Andersson (1):
      pinctrl: qcom: qcs404: Correct SDC tile

Changbin Du (1):
      kprobe: Do not use uaccess functions to access kernel memory that can=
 fault

Charlene Liu (1):
      drm/amd/display: fix PME notification not working in RV desktop

Charles Keepax (1):
      mfd: wm5110: Add missing ASRC rate register

Chen-Yu Tsai (1):
      mfd: axp20x: Re-align MFD cell entries

Cheng-Min Ao (1):
      hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attr=
ibute in OF device ID table

Chris Wilson (1):
      drm/i915/fbdev: Actually configure untiled displays

Christian K=F6nig (1):
      drm/amdgpu: disable bulk moves for now

Christophe Leroy (1):
      powerpc/8xx: fix setting of pagetable for Abatron BDI debug tool.

Colin Ian King (1):
      atm: he: fix sign-extension overflow on large shift

Cong Wang (4):
      team: avoid complex list operations in team_nl_cmd_options_set()
      net_sched: fix a race condition in tcindex_destroy()
      net_sched: fix a memory leak in cls_tcindex
      net_sched: fix two more memory leaks in cls_tcindex

Curtis Malainey (1):
      ASoC: soc-core: fix init platform memory handling

Dan Carpenter (2):
      mfd: ab8500-core: Return zero in get_register_interruptible()
      xprtrdma: Double free in rpcrdma_sendctxs_create()

Daniel Borkmann (1):
      bpf: pull in pkt_sched.h header for tooling to fix bpftool build

David Howells (3):
      afs: Fix key refcounting in file locking code
      afs: Provide a function to get a ref on a call
      afs: Fix race in async call refcounting

Davide Caratti (3):
      selftests: tc-testing: drop test on missing tunnel key id
      selftests: tc-testing: fix tunnel_key failure if dst_port is unspecif=
ied
      selftests: tc-testing: fix parsing of ife type

Denis Bolotin (2):
      qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page=
 count
      qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory =
barrier

Dien Pham (1):
      mfd: bd9571mwv: Add volatile register to make DVFS work

Dmitry V. Levin (1):
      parisc: Fix ptrace syscall number modification

Eli Cooper (1):
      netfilter: ipv6: Don't preserve original oif for loopback address

Enric Balletbo i Serra (1):
      mfd: cros_ec_dev: Add missing mfd_remove_devices() call in remove

Eric Biggers (3):
      KEYS: allow reaching the keys quotas exactly
      KEYS: user: Align the payload buffer
      KEYS: always initialize keyring_index_key::desc_len

Eric Dumazet (1):
      batman-adv: fix uninit-value in batadv_interface_tx()

Eugeniy Paltsev (2):
      ARCv2: Enable unaligned access in early ASM code
      ARC: U-boot: check arguments paranoidly

Felix Fietkau (1):
      mac80211: allocate tailroom for forwarded mesh packets

Felix Kuehling (1):
      drm/amdkfd: Don't assign dGPUs to APU topology devices

Fernando Fernandez Mancera (1):
      netfilter: nfnetlink_osf: add missing fmatch check

Florian Fainelli (1):
      net: dsa: Fix NPD checking for br_vlan_enabled()

Gao Xiang (7):
      staging: erofs: remove the redundant d_rehash() for the root dentry
      staging: erofs: atomic_cond_read_relaxed on ref-locked workgroup
      staging: erofs: fix `erofs_workgroup_{try_to_freeze, unfreeze}'
      staging: erofs: add a full barrier in erofs_workgroup_unfreeze
      staging: erofs: {dir,inode,super}.c: rectify BUG_ONs
      staging: erofs: unzip_{pagevec.h,vle.c}: rectify BUG_ONs
      staging: erofs: unzip_vle_lz4.c,utils.c: rectify BUG_ONs

Greg Kroah-Hartman (1):
      Linux 4.20.13

Guenter Roeck (2):
      hwmon: (nct6775) Fix chip ID for NCT6798D
      hwmon: (nct6775) Enable IO mapping for NCT6797D and NCT6798D

Hangbin Liu (3):
      geneve: should not call rt6_lookup() when ipv6 was disabled
      sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()
      Revert "bridge: do not add port to router list when receives query wi=
th source 0.0.0.0"

Heiko Stuebner (1):
      backlight: pwm_bl: Fix devicetree parsing with auto-generated brightn=
ess tables

Heiner Kallweit (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KS=
Z9031

Henry Yen (1):
      netfilter: nft_flow_offload: fix checking method of conntrack helper

Herbert Xu (2):
      mac80211: Use linked list instead of rhashtable walk for mesh tables
      mac80211: Free mpath object when rhashtable insertion fails

Hui Wang (1):
      ALSA: hda/realtek: Disable PC beep in passthrough on alc285

Ido Schimmel (5):
      mlxsw: spectrum: Add VXLAN dependency for spectrum
      selftests: forwarding: Add a test for VLAN deletion
      net: bridge: Mark FDB entries that were added by user as such
      mlxsw: spectrum_switchdev: Do not treat static FDB entries as sticky
      selftests: forwarding: Add a test case for externally learned FDB ent=
ries

Ilya Dryomov (1):
      libceph: handle an empty authorize reply

Jean Delvare (1):
      mfd: at91-usart: Add platform dependency

Jeremy Soller (1):
      ALSA: hda/realtek - Headset microphone and internal speaker support f=
or System76 oryp5

Jia-Ju Bai (1):
      isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Johannes Berg (4):
      Revert "socket: fix struct ifreq size in compat ioctl"
      Revert "kill dev_ifsioc()"
      net: socket: fix SIOCGIFNAME in compat
      net: socket: make bond ioctls go through compat_ifreq_ioctl()

Jonathan Marek (1):
      mfd: qcom_rpm: write fw_version to CTRL_REG

Jose Abreu (5):
      net: stmmac: Fix PCI module removal leak
      net: stmmac: dwxgmac2: Only clear interrupts that are active
      net: stmmac: Check if CBS is supported before configuring
      net: stmmac: Fix the logic of checking if RX Watchdog must be enabled
      net: stmmac: Prevent RX starvation in stmmac_napi_poll()

Julia Lawall (2):
      drm/meson: add missing of_node_put
      drm/sun4i: backend: add missing of_node_puts

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Kangjie Lu (2):
      mfd: mc13xxx: Fix a missing check of a register-read failure
      leds: lp5523: fix a missing check of return value of lp55xx_read

Keerthy (1):
      mfd: tps65218: Use devm_regmap_add_irq_chip and clean up error path i=
n probe()

Konstantin Khlebnikov (1):
      inet_diag: fix reporting cgroup classid and fallback to priority

Krzysztof Kazimierczak (1):
      xsk: Check if a queue exists during umem setup

Leo (Hanghong) Ma (1):
      drm/amd/display: Fix MST reboot/poweroff sequence

Leon Romanovsky (1):
      RDMA/mthca: Clear QP objects during their allocation

Li RongQing (1):
      ipv6: propagate genlmsg_reply return code

Logan Gunthorpe (1):
      scsi: isci: initialize shost fully before calling scsi_add_host()

Lubomir Rintel (1):
      gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2

Madalin Bucur (1):
      dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start

Manish Rangankar (1):
      scsi: qedi: Add ep_state for login completion on un-reachable targets

Marc Dionne (2):
      afs: Set correct lock type for the yfs CreateFile
      afs: Don't set vnode->cb_s_break in afs_validate()

Masato Suzuki (1):
      scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation

Mathieu Desnoyers (1):
      ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction

Michael S. Tsirkin (1):
      include/linux/compiler*.h: fix OPTIMIZER_HIDE_VAR

Michal Hocko (1):
      proc, oom: do not report alien mms when setting oom_score_adj

Nathan Chancellor (4):
      mfd: twl-core: Fix section annotations on {,un}protect_pm_master
      mfd: db8500-prcmu: Fix some section annotations
      isdn: avm: Fix string plus integer warning from Clang
      pinctrl: max77620: Use define directive for max77620_pinconf_param va=
lues

NeilBrown (1):
      watchdog: mt7621_wdt/rt2880_wdt: Fix compilation problem

Nicolas Boichat (1):
      mfd: mt6397: Do not call irq_domain_remove if PMIC unsupported

Nir Dotan (2):
      mlxsw: spectrum_acl: Add cleanup after C-TCAM update error condition
      mlxsw: pci: Return error on PCI reset timeout

Oskari Lemmela (2):
      mfd: axp20x: Add AC power supply cell for AXP813
      mfd: axp20x: Add supported cells for AXP803

Pablo Neira Ayuso (2):
      netfilter: nf_tables: fix flush after rule deletion in the same batch
      netfilter: nft_compat: use-after-free when deleting targets

Paul Burton (1):
      MIPS: eBPF: Always return sign extended 32b values

Pavel Tikhomirov (1):
      vhost: return EINVAL if iovecs size does not match the message size

Peter Oskolkov (2):
      selftests: net: fix/improve ip_defrag selftest
      bpf: bpf_setsockopt: reset sock dst on SO_MARK changes

Pierre Morel (1):
      s390: vsie: Use effective CRYCBD.31 to check CRYCBD validity

Quentin Perret (1):
      tracing: Fix number of entries in trace header

Raed Salem (1):
      net/mlx5e: FPGA, fix Innova IPsec TX offload data path performance

Rafael J. Wysocki (2):
      ACPI: EC: Look for ECDT EC after calling acpi_load_tables()
      gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling PM-runtime

Rakesh Pillai (1):
      mac80211: Restore vif beacon interval if start ap fails

Ralph Campbell (1):
      numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNOD=
ES

Ren=E9 van Dorst (1):
      gpio: MT7621: use a per instance irq_chip structure

Russell King (2):
      net: sfp: do not probe SFP module before we're attached
      net: phylink: avoid resolving link state too early

Saeed Mahameed (2):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
      net/mlx5e: XDP, fix redirect resources availability check

Song Liu (1):
      bpf: fix panic in stack_map_get_build_id() on i386 and arm32

Stanislav Fomichev (4):
      selftests/bpf: install with_tunnels.sh for test_flow_dissector.sh
      bpf: don't assume build-id length is always 20 bytes
      bpf: zero out build_id for BPF_STACK_BUILD_ID_IP
      selftests/bpf: retry tests that expect build-id

Stanislaw Gruszka (1):
      mt76x0u: fix suspend/resume

Stanley Chu (1):
      scsi: ufs: Fix system suspend status

Stefano Stabellini (4):
      pvcalls-front: read all data before closing the connection
      pvcalls-front: don't try to free unallocated rings
      pvcalls-front: properly allocate sk
      pvcalls-back: set -ENOTCONN in pvcalls_conn_back_read

Stephen Warren (1):
      net/mlx4: Get rid of page operation after dma_alloc_coherent

Taehee Yoo (2):
      netfilter: nf_tables: fix leaking object reference count
      netfilter: ipt_CLUSTERIP: fix sleep-in-atomic bug in clusterip_config=
_entry_put()

Talons Lee (1):
      always clear the X2APIC_ENABLE bit for PV guest

Tariq Toukan (1):
      net/mlx5e: Fix wrong (zero) TX drop counter indication for representor

Thomas Bogendoerfer (2):
      MIPS: jazz: fix 64bit build
      scsi: qla1280: set 64bit coherent mask

Toke H=F8iland-J=F8rgensen (1):
      mac80211: Change default tx_sk_pacing_shift to 7

Tonghao Zhang (1):
      net/mlx5e: Don't overwrite pedit action when multiple pedit used

Tony Luck (1):
      acpi/nfit: Fix race accessing memdev in nfit_get_smbios_id()

Trond Myklebust (2):
      SUNRPC: Ensure rq_bytes_sent is reset before request transmission
      SUNRPC: Ensure we respect the RPCSEC_GSS sequence number limit

Varun Prakash (1):
      scsi: cxgb4i: add wait_for_completion()

Vignesh R (1):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd =
cells

Vitaly Kuznetsov (1):
      x86/kvm/mmu: fix switch between root and guest MMUs

Wen Yang (3):
      soc/fsl/qe: fix err handling of ucc_of_parse_tdm
      pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
      pvcalls-front: fix potential null dereference

Willem de Bruijn (2):
      net: validate untrusted gso packets without csum offload
      net: avoid false positives in untrusted gso validation

Xin Long (2):
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_seg=
ment
      sctp: set stream ext to NULL after freeing it in sctp_stream_outq_mig=
rate

Xiubo Li (1):
      scsi: tcmu: avoid cmd/qfull timers updated whenever a new cmd comes

Yan, Zheng (1):
      ceph: avoid repeatedly adding inode to mdsc->snap_flush_list

Yangtao Li (1):
      cpufreq: scmi: Fix use-after-free in scmi_cpufreq_exit()

Yonghong Song (1):
      samples/bpf: workaround clang asm goto compilation errors

Yonglong Liu (1):
      net: hns: Fix use after free identified by SLUB debug

Yu Zhang (2):
      KVM: MMU: record maximum physical address width in kvm_mmu_extended_r=
ole
      kvm: x86: Return LA57 feature based on hardware capability

Yuchung Cheng (2):
      bpf: correctly set initial window on active Fast Open sender
      bpf: fix SO_MAX_PACING_RATE to support TCP internal pacing

YueHaibing (2):
      xen/pvcalls: remove set but not used variable 'intf'
      scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

wenxu (2):
      netfilter: nft_flow_offload: Fix reverse route lookup
      netfilter: nft_flow_offload: fix interaction with vrf slave device


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlx2ci0ACgkQONu9yGCS
aT5FFQ//U0VgD2/juxQzBdMPQ+jUOAUVt+059ntqePECbzoVXuM+0ICvnuv+oP7P
NkLKMi4TkOocvtm2kURNcBOkqLlOJ2c2P9ZKF2NJ+oou4Co42yYIc/zXbUluqGqh
bnLi3ZBXcETvkcyuValaNaQ7WeByKHgxGoVQGqdNTAvTAm15nJNq+ql3JiYVZ6zG
SF0baKv+2IxEZEmgoZKUDfEoItsUkgeIaKHtDx9iZRu9KwbRAvt16OcwAQwEWvd/
8avGsgp1WB7lbU3cq5W8f5u4iD61OByg2b7bH9qhGv7uwitVQ8Gg5LderkpLbRpy
6Aao1/DgeMyU3QbNJThwlAOynesKcP8szaK5e3fl5K3cVoMl3Ea1mNuN63E9Ph/1
Q9XW9WJUIYZnEyQwFIt1ikMwYyps0uE6uGtskwMKEr1tYEYtXrdCwmAKQyOW+5/u
9rrcNwCmO0J+3Et62oUVIQaDY50DbNLMgjAxpy8DmWMYbsFfa2o7yMuXs5pJNDuZ
Psq5lCqREEM87YJqucE020hcCXONV2/4MNhHEgpRBpDW692wMB4RkWZsXHBeiLpb
O1taeX1RhX7NnZLCJe72PF1hDt6lrm/Y5Xuk1i2sAGSH1GI29luQy+j4tCCnpZz+
XVE14/JA0BXLZAEfXHsjUgXAKuLtkWu05nUJ+1ZRRIu11xYQoSM=
=fYAu
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
