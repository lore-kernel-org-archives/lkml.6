Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62445C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D7E2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545061704;
	bh=gU527jOOxuP85d9wT+d1s+jqAtp8LCbMqE19Mi61e6w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nzYd6Leo2gjQLjknN+qQWKVa3aZeNXpMxnnkt688E1i05YRsA525fEpiVjEU/Oqje
	 33krrxHFIgOpYy4zS7YGmqOQKHhCpqlzh9bEzpTyjFeKZWVKtbCZiELhSCZ6NOxVp4
	 mD7LOyr2yjIoZ9cWLBrTXP1nDykRpy8VS3CdjsqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbeLQPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:48:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387831AbeLQPsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:48:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2189A2133F;
        Mon, 17 Dec 2018 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545061699;
        bh=gU527jOOxuP85d9wT+d1s+jqAtp8LCbMqE19Mi61e6w=;
        h=Date:From:To:Cc:Subject:From;
        b=aShs+pUuUUQ0CzvfnQkzPlnRq+ePm2R7JTSFVxGOCrEo5CF+ipkHBxBwS91LglUdE
         mAW/oJgAAhykxdoyw9d4PYh4ic6qCoB1qtgWp7sCvE0fYKikOqvqB8RpzVsTLVS9id
         RD+uFXPyot7zp0XwctWjgvJ/mBNKbN7yxusUBi4o=
Date:   Mon, 17 Dec 2018 16:48:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.130
Message-ID: <20181217154817.GA10391@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.130 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/Makefile                                            |    3=
=20
 Documentation/networking/Makefile                                 |    1=
=20
 Documentation/networking/timestamping/.gitignore                  |    3=
=20
 Documentation/networking/timestamping/Makefile                    |   14=
=20
 Documentation/networking/timestamping/hwtstamp_config.c           |  134 --
 Documentation/networking/timestamping/timestamping.c              |  528 -=
---------
 Documentation/networking/timestamping/txtimestamp.c               |  469 -=
-------
 Makefile                                                          |    2=
=20
 arch/arm/mach-omap1/board-ams-delta.c                             |    3=
=20
 arch/arm/mach-omap2/prm44xx.c                                     |    2=
=20
 arch/s390/kernel/perf_cpum_cf.c                                   |    2=
=20
 arch/x86/kvm/lapic.c                                              |    2=
=20
 drivers/gpu/drm/ast/ast_mode.c                                    |   36=
=20
 drivers/hwmon/w83795.c                                            |    2=
=20
 drivers/net/ethernet/realtek/8139cp.c                             |    5=
=20
 drivers/net/tun.c                                                 |    6=
=20
 drivers/staging/rts5208/sd.c                                      |    3=
=20
 drivers/staging/speakup/kobjects.c                                |    4=
=20
 drivers/usb/gadget/udc/omap_udc.c                                 |   87 -
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c                      |    2=
=20
 drivers/vme/bridges/vme_ca91cx42.c                                |    2=
=20
 drivers/vme/bridges/vme_ca91cx42.h                                |    2=
=20
 fs/btrfs/send.c                                                   |   11=
=20
 fs/cachefiles/rdwr.c                                              |    3=
=20
 fs/exec.c                                                         |    7=
=20
 fs/exportfs/expfs.c                                               |    2=
=20
 fs/fscache/object.c                                               |    3=
=20
 fs/hfs/btree.c                                                    |    3=
=20
 fs/hfsplus/btree.c                                                |    3=
=20
 fs/ocfs2/export.c                                                 |    2=
=20
 fs/ocfs2/move_extents.c                                           |   47=
=20
 fs/pstore/platform.c                                              |    4=
=20
 fs/sysv/inode.c                                                   |    2=
=20
 include/linux/sched.h                                             |    7=
=20
 include/net/neighbour.h                                           |   28=
=20
 lib/debugobjects.c                                                |    3=
=20
 net/core/rtnetlink.c                                              |    3=
=20
 net/ipv6/ip6_output.c                                             |   42=
=20
 net/sched/sch_netem.c                                             |    3=
=20
 scripts/kconfig/confdata.c                                        |    2=
=20
 sound/soc/omap/omap-dmic.c                                        |    9=
=20
 sound/soc/omap/omap-mcpdm.c                                       |   43=
=20
 tools/testing/selftests/networking/timestamping/.gitignore        |    3=
=20
 tools/testing/selftests/networking/timestamping/Makefile          |    8=
=20
 tools/testing/selftests/networking/timestamping/hwtstamp_config.c |  134 ++
 tools/testing/selftests/networking/timestamping/timestamping.c    |  528 +=
+++++++++
 tools/testing/selftests/networking/timestamping/txtimestamp.c     |  469 +=
+++++++
 47 files changed, 1384 insertions(+), 1297 deletions(-)

Aaro Koskinen (4):
      USB: omap_udc: use devm_request_irq()
      USB: omap_udc: fix crashes on probe error and module removal
      USB: omap_udc: fix omap_udc_start() on 15xx machines
      USB: omap_udc: fix USB gadget functionality on Palm Tungsten E

Arnd Bergmann (2):
      exec: avoid gcc-8 warning for get_task_comm
      staging: rts5208: fix gcc-8 logic error warning

Augusto Mecking Caringi (1):
      vme: Fix wrong pointer utilization in ca91cx42_slave_get

Christoph Paasch (1):
      net: Prevent invalid access to skb->prev in __qdisc_drop_all

Colin Ian King (1):
      fscache, cachefiles: remove redundant variable 'cache'

Dmitry Kalinkin (1):
      vme: ca91cx42: fix LM_CTL address mask

Eric Dumazet (1):
      rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices

Greg Kroah-Hartman (1):
      Linux 3.18.130

Guenter Roeck (1):
      staging: speakup: Replace strncpy with memcpy

Huacai Chen (1):
      hwmon: (w83795) temp4_type has writable permission

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Larry Chen (1):
      ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Namhyung Kim (1):
      pstore: Convert console write to use ->write_buf

Nathan Chancellor (2):
      ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_i=
o_wakeup
      kconfig: Avoid format overflow warning from GCC 8.1

NeilBrown (1):
      fscache: fix race between enablement and dropping of object

Nicolas Dichtel (1):
      tun: forbid iface creation with rtnl ops

Pan Bian (4):
      exportfs: do not read dentry after free
      hfs: do not free node before using
      hfsplus: do not free node before using
      ocfs2: fix potential use after free

Peter Ujfalusi (2):
      ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CP=
U_IDLE
      ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Qian Cai (1):
      debugobjects: avoid recursive calls with kmemleak

Robbie Ko (1):
      Btrfs: send, fix infinite loop due to directory rename dependencies

Shuah Khan (1):
      selftests: Move networking/timestamping from Documentation

Stefano Brivio (2):
      neighbour: Avoid writing before skb->head in neigh_hh_output()
      ipv6: Check available headroom in ip6_xmit() even without options

Su Yanjun (1):
      net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Sudip Mukherjee (1):
      matroxfb: fix size of memcpy

Thomas Richter (1):
      s390/cpum_cf: Reject request for sampling in event initialization

Y.C. Chen (1):
      drm/ast: fixed reading monitor EDID not stable issue

Yi Wang (1):
      KVM: x86: fix empty-body warnings

YueHaibing (1):
      sysv: return 'err' instead of 0 in __sysv_write_inode


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwXxT8ACgkQONu9yGCS
aT7u5g/6Azpx8YZqoAO6ri3IoWzyqoCz3MsSK96nILJZadS6MfFq1BBcM6BEzT+x
M7nhfp9rh6E9rSpuPjclcetQovi1VTxZqXi3VGbPRYUPswkRcItBB2Hdi9G7AaZo
6wQGG86S4TvAjOfv8tg3n7Kqw2YIV8QX7As3CQ+8ZNfW1Hb/xBonG46D0ZVSuNHz
pdUVlJlPjWnjTpnj0OxPeBX2hWbwELOzjXO8//44Bdq9TZXoHxaCAbk4uGYuR7TY
pspdKcS4v31BPUWHSG4txWKFnt58QjomU2v6ma3uDoJFi8xPu0kl5z1qds50zG2T
dnr1ZPst0GeQHCVIU+qehtQJ1rtT6u8wmfgyFUzzTu+6ISAV8YoBnHp7+1xqH10Y
D1AkerfdbMFdoCUCyddo+5Gg+CRzneaAkDunQSMWktORh5BXK5ngzzry4hS0Rg8c
opuV4+rp4wAmIqiDXj7AKnxT5nwb2osc8d+r3DKJIfqjxxDhB3i1jf1XlWUi5Rmn
n8TKEZ2Mo/joNVHUKBLk9GZkNm0Pvy9TkoSScXO8If0YPCsMz9OVdQ2g8NDkCSbP
Cpl3d/zTCp1uI3lewUx1LVhH80o9VJ7RfQDWT111+PqE8ps7cuL78YGwheyxS9aG
5n7J+DFdTAzDqO+JdRMHQb8eVzULBocVpMLbKveoLxnWkvmDkWo=
=prA3
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
