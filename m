Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C893263C7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C893263C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935334AbeFZBKn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:10:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934552AbeFZBKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:10:38 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25FE2D97;
        Tue, 26 Jun 2018 01:10:36 +0000 (UTC)
Date:   Tue, 26 Jun 2018 09:10:32 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.52
Message-ID: <20180626011032.GA25330@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.52 kernel.

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

 Makefile                                       |    2=20
 arch/x86/kernel/cpu/intel_rdt.c                |    2=20
 arch/x86/kernel/cpu/mcheck/mce-inject.c        |    2=20
 block/blk-mq.c                                 |    3=20
 drivers/ata/libata-core.c                      |    3=20
 drivers/ata/libata-zpodd.c                     |    2=20
 drivers/base/core.c                            |   14 ++
 drivers/block/nbd.c                            |   17 ++
 drivers/cpufreq/cpufreq.c                      |    2=20
 drivers/cpufreq/cpufreq_governor.c             |   12 --
 drivers/hid/intel-ish-hid/ipc/pci-ish.c        |   22 +--
 drivers/hid/wacom_sys.c                        |    8 +
 drivers/net/bonding/bond_options.c             |    1=20
 drivers/net/hyperv/netvsc_drv.c                |    4=20
 drivers/net/tap.c                              |    5=20
 drivers/net/tun.c                              |    3=20
 drivers/net/usb/cdc_ncm.c                      |    4=20
 drivers/net/virtio_net.c                       |    3=20
 drivers/net/wireless/intel/iwlwifi/fw/paging.c |   49 ++++++--
 drivers/vhost/vhost.c                          |    3=20
 drivers/w1/masters/mxc_w1.c                    |   20 ++-
 fs/binfmt_misc.c                               |   12 +-
 fs/btrfs/inode.c                               |    4=20
 fs/btrfs/ioctl.c                               |   18 +--
 fs/btrfs/scrub.c                               |    2=20
 fs/cifs/cifsacl.h                              |   14 ++
 fs/cifs/smb2ops.c                              |   68 +++++++----
 fs/cifs/smb2pdu.c                              |    4=20
 fs/ext4/indirect.c                             |   14 +-
 fs/ext4/inline.c                               |    6 +
 fs/ext4/inode.c                                |   46 ++++---
 fs/ext4/resize.c                               |    2=20
 fs/ext4/xattr.c                                |    2=20
 fs/nfs/nfs4_fs.h                               |    2=20
 fs/nfs/nfs4proc.c                              |  148 +++++++++++++++++---=
-----
 fs/orangefs/inode.c                            |    7 +
 fs/orangefs/namei.c                            |    7 +
 include/linux/virtio_net.h                     |   11 -
 include/net/transp_v6.h                        |   11 +
 include/net/udp.h                              |    5=20
 mm/backing-dev.c                               |   18 ++-
 mm/page_alloc.c                                |    1=20
 net/dsa/tag_trailer.c                          |    3=20
 net/ipv4/tcp_ipv4.c                            |    4=20
 net/ipv4/udp.c                                 |    2=20
 net/ipv4/udp_diag.c                            |    2=20
 net/ipv6/datagram.c                            |    6 -
 net/ipv6/route.c                               |    3=20
 net/ipv6/tcp_ipv6.c                            |    4=20
 net/ipv6/udp.c                                 |    3=20
 net/packet/af_packet.c                         |    4=20
 net/sched/act_simple.c                         |   15 +-
 net/socket.c                                   |   18 ++-
 net/tls/tls_sw.c                               |   26 ++--
 sound/pci/hda/hda_controller.c                 |    4=20
 sound/pci/hda/patch_conexant.c                 |    3=20
 sound/pci/hda/patch_realtek.c                  |    6 -
 57 files changed, 472 insertions(+), 214 deletions(-)

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

Even Xu (1):
      HID: intel_ish-hid: ipc: register more pm callbacks to support hibern=
ation

Frank van der Linden (1):
      tcp: verify the checksum of the first data segment in a new connection

Greg Kroah-Hartman (1):
      Linux 4.14.52

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

Takashi Iwai (1):
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

Tony Luck (2):
      x86/MCE: Fix stack out-of-bounds write in mce-inject.c: Flags_read()
      x86/intel_rdt: Enable CMT and MBM on new Skylake stepping

Trond Myklebust (1):
      NFSv4.1: Fix up replays of interrupted requests

Vlastimil Babka (1):
      mm, page_alloc: do not break __GFP_THISNODE by zonelist reset

Willem de Bruijn (1):
      net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload ho=
lds vlan

Xiangning Yu (1):
      bonding: re-evaluate force_primary when the primary slave name changes

Zhouyang Jia (1):
      net: dsa: add error handling for pskb_trim_rcsum


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsxkocACgkQONu9yGCS
aT7UShAAj2o0rUIxt5XUsa6/n9OoacdrpyxLlYAGxR1Is+QxOwWCsD1+irLBy1/u
jP1JZjk0g9imZ1S1NeV7IFg1D48o46EBYTTqnc6dd3j3xk2VZD9pgy2PeBeVIivg
V6V+nPY+th97gA8624Km6JjAqZvhK7FXdPrKBfvNPrmi5L/pORX++O99I6BIv9yQ
beqcZ55VIVIvKV8tK3BPMX4Co2Og5TDI2vC5M1D5fTQYK+wd67OK9oSh9fdHeYJm
9e/tLIX45b449hNqXpxOz3Z4pp1avMi4wI931omV79o70caGSstsA5lUg6P01eIL
dtY7a7Jcdl9rgIK5/nlBrUsWkcqyFpFUYNDJgDq3ILypJCyyW2kiTlBrdiurZCDY
aGWDPci/+d3Oq2ISfe3r+D77ITC2TfFsUsdRgi6SgXs64zJMh8hkdPfvfNxgBSXu
BN0ZfjOT/3RKKDc3viQP4LS9GO1aGeIYIO0byhZ2+vGFNZrQskFPKiICXYXJsra9
6t3p4LHeHdbYQkoUPFb6hlLHVQf05K5cxNCRyS0YJfRVEbovIGsVGZTmYlRaW4uk
jazDhXGkkkOHjqrsje1um/Ikp6MyGkyX7WGtpdAJJgBACoUKOtyWZp++quq00SAQ
IcawqEn5a05ULJqk7ksoeAULHdHc4SQTy9Y/WcljzaM7PwimljM=
=X9GH
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
