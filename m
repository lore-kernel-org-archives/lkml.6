Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D906C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D822263C8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D822263C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965130AbeFZBLI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:11:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935055AbeFZBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 21:11:04 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6BDB3D85;
        Tue, 26 Jun 2018 01:11:02 +0000 (UTC)
Date:   Tue, 26 Jun 2018 09:10:51 +0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.110
Message-ID: <20180626011051.GA25477@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.110 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/dsa/b53.txt |    1=20
 Makefile                                          |    2 -
 drivers/ata/libata-core.c                         |    3 -
 drivers/ata/libata-zpodd.c                        |    4 +-
 drivers/atm/zatm.c                                |    4 +-
 drivers/base/core.c                               |   14 +++++++-
 drivers/cpufreq/cpufreq.c                         |    2 +
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |   22 ++++---------
 drivers/net/bonding/bond_options.c                |    1=20
 drivers/net/dsa/b53/b53_common.c                  |   13 +++++++
 drivers/net/dsa/b53/b53_mdio.c                    |    5 ++-
 drivers/net/dsa/b53/b53_priv.h                    |    1=20
 drivers/net/ethernet/natsemi/sonic.c              |    2 -
 drivers/net/usb/qmi_wwan.c                        |    1=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c   |   10 +++---
 drivers/platform/x86/asus-wmi.c                   |   23 +++++++-------
 drivers/usb/musb/musb_host.c                      |    5 ++-
 drivers/usb/musb/musb_host.h                      |    7 +++-
 drivers/usb/musb/musb_virthub.c                   |   25 +++++++++------
 drivers/vhost/vhost.c                             |    3 +
 drivers/w1/masters/mxc_w1.c                       |   20 +++++++-----
 fs/binfmt_misc.c                                  |   12 +++++--
 fs/btrfs/ioctl.c                                  |   18 ++++++-----
 fs/btrfs/scrub.c                                  |    2 -
 fs/cifs/smb2pdu.c                                 |    1=20
 fs/ext4/indirect.c                                |   14 ++++++--
 fs/ext4/inode.c                                   |   36 +++++++++++------=
-----
 fs/ext4/resize.c                                  |    2 -
 fs/orangefs/namei.c                               |    7 ++++
 net/bridge/netfilter/ebtables.c                   |    3 +
 net/ipv4/tcp_input.c                              |    2 -
 net/ipv4/tcp_ipv4.c                               |    4 ++
 net/ipv6/route.c                                  |    3 -
 net/ipv6/tcp_ipv6.c                               |    4 ++
 net/ipv6/xfrm6_policy.c                           |    2 -
 net/netfilter/ipvs/ip_vs_ctl.c                    |   21 +++++++++---
 net/sched/act_simple.c                            |   15 +++------
 sound/pci/hda/hda_controller.c                    |    4 +-
 sound/pci/hda/patch_conexant.c                    |    2 +
 sound/pci/hda/patch_realtek.c                     |    8 ++++
 tools/objtool/.gitignore                          |    2 -
 41 files changed, 211 insertions(+), 119 deletions(-)

Bo Chen (1):
      ALSA: hda - Handle kzalloc() failure in snd_hda_attach_pcm_stream()

Colin Ian King (1):
      libata: zpodd: make arrays cdb static, reduces object code size

Damien Th=E9bault (1):
      net: dsa: b53: Add BCM5389 support

Dan Carpenter (1):
      libata: zpodd: small read overflow in eject_tray()

Daniel Gl=F6ckner (1):
      usb: musb: fix remote wakeup racing with suspend

Davide Caratti (1):
      net/sched: act_simple: fix parsing of TCA_DEF_DATA

Dennis Wassenberg (2):
      ALSA: hda: add dock and led support for HP EliteBook 830 G5
      ALSA: hda: add dock and led support for HP ProBook 640 G4

Eric Dumazet (2):
      xfrm6: avoid potential infinite loop in _decode_session6()
      tcp: do not overshoot window_clamp in tcp_rcv_space_adjust()

Even Xu (1):
      HID: intel_ish-hid: ipc: register more pm callbacks to support hibern=
ation

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

Frank van der Linden (1):
      tcp: verify the checksum of the first data segment in a new connection

Greg Kroah-Hartman (2):
      objtool: update .gitignore file
      Linux 4.9.110

Hans de Goede (1):
      libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk

Hao Wei Tee (1):
      iwlwifi: pcie: compare with number of IRQs requested for, not number =
of CPUs

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jan Kara (2):
      ext4: fix hole length detection in ext4_ind_map_blocks()
      ext4: fix fencepost error in check for inode count overflow during re=
size

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Fix NULL pointer dereference

Julian Anastasov (2):
      ipvs: fix buffer overflow with sync daemon and service
      ipv6: allow PMTU exceptions to local routes

Kailang Yang (1):
      ALSA: hda/realtek - New codec support for ALC257

Liu Bo (1):
      Btrfs: make raid6 rebuild retry more

Lukas Czerner (1):
      ext4: update mtime in ext4_punch_hole even if no blocks are released

Martin Brandenburg (1):
      orangefs: set i_size on new symlink

Michael S. Tsirkin (1):
      vhost: fix info leak due to uninitialized memory

Omar Sandoval (2):
      Btrfs: fix clone vs chattr NODATASUM race
      Btrfs: fix memory and mount leak in btrfs_ioctl_rm_dev_v2()

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Qu Wenruo (1):
      btrfs: scrub: Don't use inode pages for device replace

Sasha Levin (1):
      Revert "Btrfs: fix scrub to repair raid6 corruption"

Stefan Potyra (1):
      w1: mxc_w1: Enable clock before calling clk_get_rate() on it

Steve French (1):
      smb3: on reconnect set PreviousSessionId field

Tao Wang (1):
      cpufreq: Fix new policy initialization during limits updates via sysfs

Tetsuo Handa (1):
      driver core: Don't ignore class_dir_create_and_add() failure.

Thadeu Lima de Souza Cascardo (1):
      fs/binfmt_misc.c: do not allow offset overflow

Xiangning Yu (1):
      bonding: re-evaluate force_primary when the primary slave name changes


--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsxkpsACgkQONu9yGCS
aT54HRAAmhoxFDHSdvpMzMjCgo5/gXQcU+/allk/rk0DM+0XkGRVK98sc49/2eGC
tXERN030PLeZEZGnBh2EPReA4PP3oz0b+mVfIvvcpbTylIbm1aUOrfwRKVhDLtZ7
Ie6Jzb/Tgg0VQrF1JFxvlEpsqNazFG949jhY+XE4KdSvFPkjiCplNM/FebqAAmk0
71LjL6KsBJA56mzgBJsVdVYXHLUoEeVTQ3Qr6Bls7IpqBRO7KT2aInz92OpMZzgU
20vc87QXaWXX/1GRUwmcH9Oejgg0BB0CLsySOC/YQ8g2cxIYSYfswj3DGQxt7tqd
lLYnALVJlL62BOUQl38yf9lIWUP4w6rMevTIeqHOyl8K6veDoToVOOgpAmGDhx+a
2b7/aKuPnpGrLGkLOkFJbxA1Rq5j9jhXrEXfGSF4l3WXAUZ9pHNyQoRhpWt3QpAS
Fg7adphUSuxY5iWKqDr3HC5fmw8E3h1CPgtOS/W9VA9OroK93PTtIz5doyFCvmIY
FB21zCIQdTrXMuE1lJAUIp/Y/4XIadUn/j26hhzhNWa0m8fa/ipxNiVnTSSka7Ct
nWgXa8TzbCzGC4H2jJW7TAu28CqAP94LnLbaS3SjtAVhGSUcXz3NAlkDJV29HkmU
F9gtcmn/12CGP6wCvaBn+XtaovKiUkkP7ZkyaSKF2ccpa6KUKLA=
=e7bI
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
