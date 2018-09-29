Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932FAC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F2120666
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F2120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI2Rqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:46:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36166 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeI2Rqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:46:32 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7C696CCA;
        Sat, 29 Sep 2018 11:18:26 +0000 (UTC)
Date:   Sat, 29 Sep 2018 04:18:25 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.11
Message-ID: <20180929111825.GA21960@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.11 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                        |    2=20
 arch/x86/crypto/aegis128-aesni-glue.c           |    1=20
 arch/x86/crypto/aegis128l-aesni-glue.c          |    1=20
 arch/x86/crypto/aegis256-aesni-glue.c           |    1=20
 arch/x86/crypto/morus1280-sse2-glue.c           |    1=20
 arch/x86/crypto/morus640-sse2-glue.c            |    1=20
 arch/x86/xen/pmu.c                              |    2=20
 drivers/ata/libata-core.c                       |   14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c         |   14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |    1=20
 drivers/gpu/drm/i915/intel_display.c            |    8 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c         |   67 +++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c     |   42 +++++++--
 drivers/gpu/drm/nouveau/nouveau_display.c       |   44 +++++++--
 drivers/gpu/drm/nouveau/nouveau_display.h       |    2=20
 drivers/gpu/drm/nouveau/nouveau_drm.c           |    3=20
 drivers/gpu/drm/nouveau/nouveau_fbcon.c         |   57 ++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.h         |    5 +
 drivers/gpu/drm/udl/udl_fb.c                    |    8 +
 drivers/gpu/drm/vc4/vc4_plane.c                 |   25 ++---
 drivers/infiniband/hw/cxgb4/qp.c                |    6 +
 drivers/misc/vmw_balloon.c                      |    1=20
 drivers/mtd/devices/m25p80.c                    |   26 +++++
 drivers/mtd/nand/raw/denali.c                   |    6 +
 drivers/net/appletalk/ipddp.c                   |    8 +
 drivers/net/dsa/mv88e6xxx/global1.h             |    2=20
 drivers/net/dsa/mv88e6xxx/global1_atu.c         |    2=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |    9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |    9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h |    2=20
 drivers/net/ethernet/hp/hp100.c                 |    2=20
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   21 +---
 drivers/net/hyperv/netvsc_drv.c                 |    9 --
 drivers/net/ppp/pppoe.c                         |    3=20
 drivers/net/usb/qmi_wwan.c                      |   14 +--
 drivers/net/xen-netfront.c                      |    8 +
 drivers/pci/quirks.c                            |    6 -
 drivers/platform/x86/alienware-wmi.c            |    1=20
 drivers/platform/x86/dell-smbios-wmi.c          |    1=20
 drivers/rpmsg/rpmsg_core.c                      |    7 -
 drivers/spi/spi.c                               |   13 ++
 drivers/target/iscsi/iscsi_target_auth.c        |   45 +++-------
 drivers/tty/vt/vt_ioctl.c                       |    4=20
 fs/ext4/dir.c                                   |   20 ++--
 fs/ext4/ext4.h                                  |    3=20
 fs/ext4/inline.c                                |    4=20
 fs/ext4/inode.c                                 |   11 +-
 fs/ext4/mmp.c                                   |    1=20
 fs/ext4/namei.c                                 |    6 +
 fs/ext4/resize.c                                |   23 ++++-
 fs/ext4/super.c                                 |    4=20
 fs/ocfs2/buffer_head_io.c                       |    1=20
 fs/ubifs/xattr.c                                |   24 -----
 include/net/nfc/hci.h                           |    2=20
 include/net/tls.h                               |   19 ++--
 include/uapi/linux/keyctl.h                     |    2=20
 include/uapi/sound/skl-tplg-interface.h         |  106 ++++++++++++-------=
-----
 kernel/bpf/verifier.c                           |    2=20
 kernel/pid.c                                    |    2=20
 kernel/sched/fair.c                             |    3=20
 kernel/trace/ring_buffer.c                      |    2=20
 mm/Kconfig                                      |    1=20
 mm/shmem.c                                      |    2=20
 net/core/neighbour.c                            |   13 +-
 net/core/rtnetlink.c                            |    2=20
 net/ipv4/af_inet.c                              |    1=20
 net/ipv4/udp.c                                  |   49 +++++------
 net/ipv6/ip6_offload.c                          |    1=20
 net/ipv6/ip6_output.c                           |    6 -
 net/ipv6/route.c                                |   44 ++++++---
 net/ipv6/udp.c                                  |   65 ++++++++------
 net/nfc/hci/core.c                              |   10 ++
 net/sched/act_sample.c                          |    2=20
 net/socket.c                                    |   22 +++-
 net/tls/tls_device.c                            |    4=20
 net/tls/tls_device_fallback.c                   |    2=20
 net/tls/tls_main.c                              |   22 +++-
 net/tls/tls_sw.c                                |   21 ++--
 security/keys/dh.c                              |    2=20
 sound/firewire/bebob/bebob.c                    |    2=20
 sound/firewire/bebob/bebob_maudio.c             |   28 +++---
 sound/firewire/digi00x/digi00x.c                |    1=20
 sound/firewire/fireface/ff-protocol-ff400.c     |    9 +-
 sound/firewire/fireworks/fireworks.c            |    2=20
 sound/firewire/oxfw/oxfw.c                      |   10 ++
 sound/firewire/tascam/tascam.c                  |    1=20
 sound/pci/emu10k1/emufx.c                       |    2=20
 sound/soc/codecs/cs4265.c                       |    4=20
 sound/soc/codecs/tas6424.c                      |   12 ++
 sound/soc/codecs/wm9712.c                       |    2=20
 sound/soc/sh/rcar/core.c                        |   11 ++
 sound/soc/sh/rcar/rsnd.h                        |    7 +
 sound/soc/sh/rcar/ssi.c                         |   16 ++-
 93 files changed, 713 insertions(+), 402 deletions(-)

Alex Deucher (1):
      drm/amdgpu: add new polaris pci id

Alexei Starovoitov (1):
      bpf/verifier: disallow pointer subtraction

Andrew F. Davis (1):
      ASoC: tas6424: Save last fault register even when clear

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix ATU Miss Violation

Antoine Tenart (1):
      net: mvpp2: let phylink manage the carrier state

Bj=F8rn Mork (1):
      qmi_wwan: set DTR for modems in forced USB2 mode

Boris Brezillon (2):
      mtd: devices: m25p80: Make sure the buffer passed in op is DMA-able
      drm/vc4: Fix the "no scaling" case on multi-planar YUV formats

Boris Ostrovsky (1):
      xen/x86/vpmu: Zero struct pt_regs before calling into sample handling=
 code

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Daniel Borkmann (1):
      tls: fix currently broken MSG_PEEK behavior

Davide Caratti (1):
      net/sched: act_sample: fix NULL dereference in the data path

Dmitry V. Levin (1):
      ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation erro=
rs

Emil Lundmark (1):
      drm: udl: Destroy framebuffer only if it was initialized

Eric Biggers (1):
      ext4: show test_dummy_encryption mount option in /proc/mounts

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Geert Uytterhoeven (1):
      spi: Fix double IDR allocation with DT aliases

Greg Kroah-Hartman (2):
      Revert "rpmsg: core: add support to power domains for devices"
      Linux 4.18.11

Guillaume Nault (1):
      pppoe: fix reception of frames with no mac header

Gustavo A. R. Silva (1):
      tty: vt_ioctl: fix potential Spectre v1

Imre Deak (1):
      drm/i915/bdw: Increase IPS disable timeout to 100ms

Jens Axboe (1):
      libata: mask swap internal and hardware tag

Jiada Wang (1):
      ASoC: rsnd: fixup not to call clk_get/set under non-atomic

Joel Fernandes (Google) (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep

Johannes Berg (1):
      socket: fix struct ifreq size in compat ioctl

Juergen Gross (1):
      xen/netfront: don't bug in case of too many frags

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic

KJ Tsanaktsidis (1):
      fork: report pid exhaustion correctly

Kirill Kapranov (1):
      spi: fix IDR collision on systems with both fixed and dynamic SPI bus=
 numbers

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Lubomir Rintel (1):
      Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a stru=
ct member name"

Lyude Paul (9):
      drm/nouveau: Reset MST branching unit before enabling
      drm/nouveau: Only write DP_MSTM_CTRL when needed
      drm/nouveau: Remove duplicate poll_enable() in pmops_runtime_suspend()
      drm/nouveau: Fix deadlocks in nouveau_connector_detect()
      drm/nouveau/drm/nouveau: Don't forget to cancel hpd_work on suspend/u=
nload
      drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() place=
ment
      drm/nouveau/drm/nouveau: Fix deadlock with fb_helper with async RPM r=
equests
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_d=
etect()
      drm/nouveau/drm/nouveau: Prevent handling ACPI HPD events too early

Marcel Ziswiler (1):
      ASoC: wm9712: fix replace codec to component

Mario Limonciello (2):
      platform/x86: dell-smbios-wmi: Correct a memory leak
      platform/x86: alienware-wmi: Correct a memory leak

Masahiro Yamada (1):
      mtd: rawnand: denali: fix a race condition when DMA is kicked

Michael Chan (1):
      bnxt_en: Fix VF mac address regression.

Mika Westerberg (1):
      Revert "PCI: Add ACS quirk for Intel 300 series"

Nadav Amit (1):
      vmw_balloon: include asm/io.h

Ondrej Mosnacek (1):
      crypto: x86/aegis,morus - Do not require OSXSAVE for SSE2

Paolo Abeni (2):
      udp4: fix IP_CMSG_CHECKSUM for connected sockets
      udp6: add missing checks on edumux packet processing

Pasha Tatashin (1):
      mm: disable deferred struct page for 32-bit arches

Peter Oskolkov (1):
      net/ipv6: do not copy dst flags on rt init

Richard Weinberger (1):
      Revert "ubifs: xattr: Don't operate on deleted inodes"

Roopa Prabhu (1):
      net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_f=
lags

Sabrina Dubroca (3):
      tls: don't copy the key out of tls12_crypto_info_aes_gcm_128
      tls: zero the crypto information from tls_context before freeing
      tls: clear key material from kernel memory when do_tls_setsockopt_con=
f fails

Stephen Hemminger (1):
      hv_netvsc: fix schedule in RCU context

Steve Muckle (1):
      sched/fair: Fix vruntime_normalized() for remote non-migration wakeup

Steve Wise (1):
      iw_cxgb4: only allow 1 flush on user qps

Suren Baghdasaryan (2):
      NFC: Fix possible memory corruption when handling SHDLC I-Frame comma=
nds
      NFC: Fix the number of pipes

S=E9bastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Takashi Sakamoto (9):
      ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at=
 error path
      ALSA: bebob: use address returned by kmalloc() instead of kernel stac=
k for streaming DMA mapping
      ALSA: fireface: fix memory leak in ff400_switch_fetching_mode()
      ALSA: firewire-digi00x: fix memory leak of private data
      ALSA: firewire-tascam: fix memory leak of private data
      ALSA: fireworks: fix memory leak of response buffer at error path
      ALSA: oxfw: fix memory leak for model-dependent data at error path
      ALSA: oxfw: fix memory leak of discovered stream formats at error path
      ALSA: oxfw: fix memory leak of private data

Theodore Ts'o (6):
      ext4: check to make sure the rename(2)'s destination is not freed
      ext4: avoid divide by zero fault when deleting corrupted inline direc=
tories
      ext4: avoid arithemetic overflow that can trigger a BUG
      ext4: recalucate superblock checksum after updating free blocks/inodes
      ext4: fix online resize's handling of a too-small final block group
      ext4: fix online resizing for bigalloc file systems with a 1k block s=
ize

Toke H=F8iland-J=F8rgensen (1):
      gso_segment: Reset skb->mac_len after modifying network header

Toshi Kani (2):
      ext4, dax: add ext4_bmap to ext4_dax_aops
      ext4, dax: set ext4_dax_aops for dax files

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

Vasily Khoruzhick (1):
      neighbour: confirm neigh entries when ARP packet is received

Vincent Pelletier (2):
      scsi: target: iscsi: Use hex2bin instead of a re-implementation
      scsi: target: iscsi: Use bin2hex instead of a re-implementation

Willy Tarreau (2):
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_I=
OCTL_INFO

Xin Long (1):
      ipv6: use rt6_info members when dst is set in rt6_fill_node


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluvX34ACgkQONu9yGCS
aT50yRAAjsedlxDI1+f9CLORkX4cXFerKS+90LSiQFNmeFfUW9Q2j49G6HajJlcH
65mgB7j4WdMsXWn2QsYAMM1MZXm6cBlRwaN9gv77BaCi0aUrnkYS5LBhnKZ6dt8F
zxKUa7KB3LL7qzFkAUcrsaufhi10B103UBzM9EQ12c5WNXSRM+pKG22IhcnFjODR
oo+ZbZHGAPsAKEiCFqULcsG32W/V8vsJzTUWffU4CYsZDH1FSr9Z1O/43sYoOgQM
rgyZKbkVkJ/XCHkGHIfNG1JUeD2KrEkV2O8jWduYFJvca6H8nAeUnQvGXNLyXjcQ
HPAW9sd5DwDX1/5PDNLlQEhlkO+KOTNVxp3Ss4pb74I6N4N6v188RjxsnsxC0LsW
RizX4d6XUWMAUEof6euVyfgeCIOwb6BuGbAEwcfD11NAxfVpHhYVWH6+UiEXhlNv
E3658umXvQ2i+0HTJVjHN13E5kBBTjxm7eKQnljIQ+E326RzyEFdnpi2p9zELZhD
08tyLZJalhLF2qSGUjZV4Y78eMPkkUMcVQVnI/MtPAdaAySTziQh5///TgK8uiRU
jdymaqa4o3QnqwuVwccH3A02TTDB8PPSTBtqRI+2qFec1yPnewBKYWFOspOncc6g
PNLxJp6FJEqERweU9O12qHS09Akk4ikgxOcPNP1ywVNOF5wNvKE=
=CMtp
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
