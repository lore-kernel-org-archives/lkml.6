Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDEC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EAC208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EAC208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbeHIPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:01:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbeHIPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:01:24 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 337A9D2F;
        Thu,  9 Aug 2018 12:36:40 +0000 (UTC)
Date:   Thu, 9 Aug 2018 14:36:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.14
Message-ID: <20180809123637.GB7954@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.17.14 kernel.

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

 Makefile                             |    2=20
 arch/x86/events/intel/uncore.h       |    2=20
 arch/x86/events/intel/uncore_snbep.c |   10 +++-
 block/blk-core.c                     |    5 +-
 drivers/i2c/busses/i2c-imx.c         |    3 -
 drivers/scsi/qla2xxx/qla_attr.c      |    1=20
 drivers/scsi/qla2xxx/qla_gbl.h       |    1=20
 drivers/scsi/qla2xxx/qla_gs.c        |    4 +
 drivers/scsi/qla2xxx/qla_init.c      |    7 +--
 drivers/scsi/qla2xxx/qla_inline.h    |    2=20
 drivers/scsi/qla2xxx/qla_isr.c       |    3 +
 drivers/scsi/qla2xxx/qla_mbx.c       |    6 ++
 drivers/scsi/qla2xxx/qla_mid.c       |   11 ++++-
 drivers/scsi/qla2xxx/qla_os.c        |   51 ++++++++++--------------
 drivers/scsi/qla2xxx/qla_sup.c       |    3 +
 fs/btrfs/extent_io.c                 |    3 +
 fs/jfs/jfs_dinode.h                  |    7 +++
 fs/jfs/jfs_incore.h                  |    1=20
 fs/jfs/super.c                       |    3 -
 fs/jfs/xattr.c                       |   10 ++--
 fs/xfs/libxfs/xfs_attr_leaf.c        |    5 --
 fs/xfs/xfs_icache.c                  |   73 +++++++++++++++++++++++-------=
-----
 include/linux/ring_buffer.h          |    1=20
 kernel/irq/manage.c                  |    9 +++-
 kernel/softirq.c                     |    2=20
 kernel/time/tick-sched.c             |    2=20
 kernel/trace/ring_buffer.c           |   16 +++++++
 kernel/trace/trace.c                 |    6 ++
 net/netlink/af_netlink.c             |    4 -
 29 files changed, 170 insertions(+), 83 deletions(-)

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Dave Chinner (1):
      xfs: validate cached inodes are free when allocated

Dmitry Safonov (1):
      netlink: Don't shift on 64 for ngroups

Eric Sandeen (1):
      xfs: don't call xfs_da_shrink_inode with NULL bp

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Filipe Manana (1):
      Btrfs: fix file data corruption after cloning a range and fsync

Frederic Weisbecker (1):
      nohz: Fix missing tick reprogram when interrupting an inline softirq

Greg Kroah-Hartman (1):
      Linux 4.17.14

Kan Liang (1):
      perf/x86/intel/uncore: Fix hardcoded index of Broadwell extra PCI dev=
ices

Kees Cook (1):
      jfs: Fix usercopy whitelist for inline inode data

Linus Torvalds (1):
      Partially revert "block: fail op_is_write() requests to read-only par=
titions"

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer

Quinn Tran (4):
      scsi: qla2xxx: Fix unintialized List head crash
      scsi: qla2xxx: Fix NPIV deletion by calling wait_for_sess_deletion
      scsi: qla2xxx: Fix driver unload by shutting down chip
      scsi: qla2xxx: Fix ISP recovery on unload

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Thomas Gleixner (1):
      genirq: Make force irq threading setup more robust


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltsNVIACgkQONu9yGCS
aT754w/9HL24FaWkMtV6+Q+3oC8mc+DVTeYTtF7jyt39cbi9p6in4fHPyiYpCS1d
qONqHWpORoU/pme+BpRoSnAUNETbD9jmu5fnVat1UHXJJMAKu/1yIs4qDhnczSSS
SMty6pzNTdGvvNHKaS1ShaPU10VXDTuDL7lI4DgMEfNHTRwQiTUCTwRF3wqiyP4h
0UIgWSLmzKqQlXKqTz9r9N7lXslSHMqS0XAubZ+Go8qSoXqKihJBFdYXOzUMTKRz
Om5kGgpuNlDZvp4EDEi32lrsYdEp0lMMOFo0VQ15Fawsruky9Bfb8nvvpDswfmgH
3nIhnLkMOTxjffivrqV64ejLQ5Ahw92Fv5nRRIlP+DqGeF6dBWK7iAGv9n7/cc6/
74dQOdfCLr3yuLL0WSAaf5WZZMbvl0JvRuaUrJgx2wwpIO600d9vkGigJJwCZKw2
T/mXV748IbsCu4NjeiOEQZzkgRKu7P0ivHI3nmqxdmZAEdUKjWVf/2YD58V8HQnP
G5ia4XKI3qQgaqvcYIe4g15HS8w6CqAs9G/TrRl10b69carx4J5fT4CZ+CrudNe7
+VIFxjzitiR9WrS1y+hebuIXguhs4UNOWavVvYSYqDIAHghjqFBspzosQHFAWnkH
V4p3uZjMtZ7YXEL8SjGCcwzW7NforB81ngKQvSXhx9HiY6Zj+/k=
=Z4Xs
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
