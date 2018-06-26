Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70E7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AA48263C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA48263C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935308AbeFZBKW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:10:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60742 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933294AbeFZBKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:10:13 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3BB5EC23;
        Tue, 26 Jun 2018 01:10:11 +0000 (UTC)
Date:   Tue, 26 Jun 2018 09:10:06 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.18
Message-ID: <20180626011006.GA25096@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---------------------
Note, this is the LAST 4.16.y kernel release.  This branch is now
end-of-life.  Please move to the 4.17.y kernel now.
---------------------

I'm announcing the release of the 4.16.18 kernel.

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

 Makefile                                       |    2=20
 arch/x86/include/asm/apic.h                    |    2=20
 arch/x86/include/asm/trace/irq_vectors.h       |    2=20
 arch/x86/kernel/apic/io_apic.c                 |    2=20
 arch/x86/kernel/apic/vector.c                  |   18 +++++-
 arch/x86/kernel/cpu/intel_rdt.c                |    2=20
 arch/x86/kernel/cpu/mcheck/mce-inject.c        |    2=20
 arch/x86/platform/uv/uv_irq.c                  |    7 --
 block/blk-mq.c                                 |    3 -
 drivers/ata/libata-core.c                      |    3 -
 drivers/ata/libata-zpodd.c                     |    2=20
 drivers/base/core.c                            |   14 ++++-
 drivers/block/nbd.c                            |   17 +++++-
 drivers/cpufreq/cpufreq.c                      |    2=20
 drivers/cpufreq/cpufreq_governor.c             |   12 +---
 drivers/cpufreq/ti-cpufreq.c                   |    2=20
 drivers/hid/intel-ish-hid/ipc/pci-ish.c        |   22 ++------
 drivers/hid/wacom_sys.c                        |    8 ++
 drivers/iommu/amd_iommu.c                      |    2=20
 drivers/iommu/intel_irq_remapping.c            |    2=20
 drivers/iommu/irq_remapping.c                  |    5 -
 drivers/iommu/irq_remapping.h                  |    2=20
 drivers/net/bonding/bond_options.c             |    1=20
 drivers/net/hyperv/netvsc_drv.c                |    4 +
 drivers/net/phy/dp83848.c                      |   35 ++++++++++--
 drivers/net/tap.c                              |    5 +
 drivers/net/tun.c                              |    3 -
 drivers/net/usb/cdc_ncm.c                      |    4 -
 drivers/net/virtio_net.c                       |    3 -
 drivers/net/wireless/intel/iwlwifi/fw/paging.c |   49 +++++++++++++++---
 drivers/nvme/host/pci.c                        |   11 +++-
 drivers/vhost/vhost.c                          |    3 +
 drivers/w1/masters/mxc_w1.c                    |   20 ++++---
 fs/binfmt_misc.c                               |   12 +++-
 fs/btrfs/inode.c                               |    4 +
 fs/btrfs/ioctl.c                               |   18 ++++--
 fs/btrfs/scrub.c                               |    2=20
 fs/cifs/cifsacl.h                              |   14 +++++
 fs/cifs/smb2ops.c                              |   68 +++++++++++++++++---=
-----
 fs/cifs/smb2pdu.c                              |    4 -
 fs/ext4/indirect.c                             |   14 +++--
 fs/ext4/inline.c                               |    6 ++
 fs/ext4/inode.c                                |   46 +++++++++-------
 fs/ext4/resize.c                               |    2=20
 fs/ext4/xattr.c                                |    2=20
 fs/orangefs/inode.c                            |    7 ++
 fs/orangefs/namei.c                            |    7 ++
 include/linux/irq.h                            |    7 ++
 include/linux/virtio_net.h                     |   11 +---
 include/net/transp_v6.h                        |   11 +++-
 include/net/udp.h                              |    5 +
 kernel/irq/manage.c                            |   37 ++++++++++++-
 kernel/irq/migration.c                         |   31 +++++++----
 mm/backing-dev.c                               |   18 ++++++
 mm/page_alloc.c                                |    1=20
 net/dsa/tag_trailer.c                          |    3 -
 net/ipv4/tcp_ipv4.c                            |    4 +
 net/ipv4/udp.c                                 |    2=20
 net/ipv4/udp_diag.c                            |    2=20
 net/ipv6/datagram.c                            |    6 +-
 net/ipv6/route.c                               |    3 -
 net/ipv6/tcp_ipv6.c                            |    4 +
 net/ipv6/udp.c                                 |    3 -
 net/packet/af_packet.c                         |    4 -
 net/sched/act_simple.c                         |   15 ++---
 net/socket.c                                   |   18 +++++-
 net/tls/tls_sw.c                               |   26 ++++-----
 sound/pci/hda/hda_controller.c                 |    4 +
 sound/pci/hda/patch_conexant.c                 |    3 +
 sound/pci/hda/patch_realtek.c                  |    6 +-
 sound/usb/quirks-table.h                       |    5 +
 71 files changed, 497 insertions(+), 209 deletions(-)

Alvaro Gamez Machado (1):
      net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for =
DP83620

Bj=F8rn Mork (1):
      cdc_ncm: avoid padding beyond end of skb

Bo Chen (1):
      ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Chen Yu (1):
      cpufreq: governors: Fix long idle detection logic in load calculation

Cong Wang (1):
      socket: close race condition between sock_close() and sockfs_setattr()

Dan Carpenter (1):
      libata: zpodd: small read overflow in eject_tray()

Daniel Borkmann (1):
      tls: fix use-after-free in tls_push_record

Davide Caratti (1):
      net/sched: act_simple: fix parsing of TCA_DEF_DATA

Dennis Wassenberg (2):
      ALSA: hda: add dock and led support for HP EliteBook 830 G5
      ALSA: hda: add dock and led support for HP ProBook 640 G4

Dexuan Cui (1):
      hv_netvsc: Fix a network regression after ifdown/ifup

Dou Liyang (1):
      x86/vector: Fix the args of vector_alloc tracepoint

Even Xu (1):
      HID: intel_ish-hid: ipc: register more pm callbacks to support hibern=
ation

Frank van der Linden (1):
      tcp: verify the checksum of the first data segment in a new connection

Greg Kroah-Hartman (1):
      Linux 4.16.18

Hans de Goede (1):
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Hui Wang (1):
      ALSA: hda/realtek - Enable mic-mute hotkey for several Lenovo AIOs

Jan Kara (2):
      ext4: fix hole length detection in ext4_ind_map_blocks()
      ext4: fix fencepost error in check for inode count overflow during re=
size

Jason Gerecke (1):
      HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large

Josef Bacik (3):
      nbd: fix nbd device deletion
      nbd: update size when connected
      nbd: use bd_set_size when updating disk size

Julian Anastasov (1):
      ipv6: allow PMTU exceptions to local routes

Keith Busch (1):
      nvme/pci: Sync controller reset for AER slot_reset

Luca Coelho (1):
      iwlwifi: fw: harden page loading code

Lukas Czerner (1):
      ext4: update mtime in ext4_punch_hole even if no blocks are released

Mark Syms (1):
      CIFS: 511c54a2f69195b28afb9dd119f03787b1625bb4 adds a check for sessi=
on expiry

Martin Brandenburg (2):
      orangefs: set i_size on new symlink
      orangefs: report attributes_mask and attributes for statx

Michael S. Tsirkin (1):
      vhost: fix info leak due to uninitialized memory

Omar Sandoval (2):
      Btrfs: fix clone vs chattr NODATASUM race
      Btrfs: fix memory and mount leak in btrfs_ioctl_rm_dev_v2()

Paolo Abeni (1):
      udp: fix rx queue len reported by diag and proc interface

Qu Wenruo (1):
      btrfs: scrub: Don't use inode pages for device replace

Roman Pen (1):
      blk-mq: reinit q->tag_set_list entry only after grace period

Shirish Pargaonkar (1):
      cifs: For SMB2 security informaion query, check for minimum sized sec=
urity descriptor instead of sizeof FileAllInformation class

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Steve French (2):
      smb3: fix various xid leaks
      smb3: on reconnect set PreviousSessionId field

Su Yue (1):
      btrfs: return error value if create_io_em failed in cow_file_range

Suman Anna (1):
      cpufreq: ti-cpufreq: Fix an incorrect error return value

Takashi Iwai (2):
      ALSA: usb-audio: Disable the quirk for Nura headset
      ALSA: hda/conexant - Add fixup for HP Z2 G4 workstation

Tao Wang (1):
      cpufreq: Fix new policy initialization during limits updates via sysfs

Tejun Heo (1):
      bdi: Move cgroup bdi_writeback to a dedicated low concurrency workque=
ue

Tetsuo Handa (1):
      driver core: Don't ignore class_dir_create_and_add() failure.

Thadeu Lima de Souza Cascardo (1):
      fs/binfmt_misc.c: do not allow offset overflow

Theodore Ts'o (3):
      ext4: do not allow external inodes for inline data
      ext4: bubble errors from ext4_find_inline_data_nolock() up to ext4_ig=
et()
      ext4: correctly handle a zero-length xattr with a non-zero e_value_of=
fs

Thomas Gleixner (8):
      x86/apic/vector: Prevent hlist corruption and leaks
      x86/apic: Provide apic_ack_irq()
      x86/ioapic: Use apic_ack_irq()
      x86/platform/uv: Use apic_ack_irq()
      irq_remapping: Use apic_ack_irq()
      genirq/generic_pending: Do not lose pending affinity update
      genirq/affinity: Defer affinity setting if irq chip is busy
      genirq/migration: Avoid out of line call if pending is not set

Tony Luck (2):
      x86/MCE: Fix stack out-of-bounds write in mce-inject.c: Flags_read()
      x86/intel_rdt: Enable CMT and MBM on new Skylake stepping

Vlastimil Babka (1):
      mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Willem de Bruijn (1):
      net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload ho=
lds vlan

Xiangning Yu (1):
      bonding: re-evaluate force_primary when the primary slave name changes

Zhouyang Jia (1):
      net: dsa: add error handling for pskb_trim_rcsum


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsxkm0ACgkQONu9yGCS
aT6sVA//czzGir1Nf9KK2NGeAFG1E5nZMJh7aip7l2tBpuYr2CfELvLW1evaPbIq
nRGFdVeilZvVFnoNTvGf8LTq5hIiuO1T4OpogY/k8bH6A7wkfiGLrj/qKlvbMG/P
TbdacpndG2Z6r4Tzw/wzHQXbbMTCJbGCcIObkq9DWIsAHuE7+TQDFPVQRxpIKW6Y
SbqhHNvfrTCWqjOBiDLRjua1s8II788ylAvhncYqx+M/Z/EBu+hySpX0PcKY2gg+
5ggvHZ9cNCoH3TvowlXnTVKtl5Iw2nUZdA7e4Aa9mbkcGXCdri+Oqd+aKRvlhwRc
DNoDGtYMlJuqyCsNGACWCdv7A48ujORIDLGFiTD0Ra+ROKdNuCg+Wwzvju3NKIBR
TEXTTPxSp4wjpeNQALuGNN5kscRsrp+sDK23lJzEPvLmBhUmxqcr9w7j3dOQodwD
6H3EeJ1HpDZ7SiuS+xZHIIIsHSyD/BUCoLq0zxAdWia/ale0kZjEpwZ2Cmv1qfrS
HCu2GRVsO2F1r3pNDWNrSNf797MRzJbMsNVCkzF040LoUn/VPWDHUhIdDBOUx+LO
j+dVBoYpd5QjzJUbrN2tbUHr30gfNDLxuN7q0trHvHOvsDI7M5XNY/0xaMVwHKWq
zz+4/RsNHFhDSnVLN1SWB7YPRZPpHNWKnRM4H2mPAy2wMGTYm2M=
=JIO6
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
