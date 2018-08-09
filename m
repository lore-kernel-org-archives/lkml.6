Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798F8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A944208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A944208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbeHIPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:02:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbeHIPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:02:17 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 037E5D0E;
        Thu,  9 Aug 2018 12:37:33 +0000 (UTC)
Date:   Thu, 9 Aug 2018 14:37:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.119
Message-ID: <20180809123730.GA8259@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.119 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                 |    2 +-
 drivers/i2c/busses/i2c-imx.c             |    3 +--
 drivers/infiniband/hw/hfi1/rc.c          |    2 +-
 drivers/infiniband/hw/hfi1/uc.c          |    4 ++--
 drivers/infiniband/hw/hfi1/ud.c          |    4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.c |    4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.h |    4 ++--
 drivers/pci/pci-acpi.c                   |    2 +-
 drivers/scsi/qla2xxx/qla_init.c          |    7 +++----
 drivers/scsi/qla2xxx/qla_os.c            |    5 +++--
 fs/btrfs/extent_io.c                     |    3 +++
 fs/ext4/super.c                          |    4 ++--
 fs/jfs/xattr.c                           |   10 ++++++----
 include/linux/ring_buffer.h              |    1 +
 include/linux/thread_info.h              |    7 +------
 kernel/fork.c                            |    3 +++
 kernel/irq/manage.c                      |    9 ++++++++-
 kernel/time/tick-sched.c                 |    2 +-
 kernel/trace/ring_buffer.c               |   16 ++++++++++++++++
 kernel/trace/trace.c                     |    6 ++++++
 net/ipv4/tcp_input.c                     |   23 +++++++++++++++++++++--
 net/netlink/af_netlink.c                 |    5 +++++
 22 files changed, 91 insertions(+), 35 deletions(-)

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Dmitry Safonov (3):
      netlink: Do not subscribe to non-existent groups
      netlink: Don't shift with UB on nlk->ngroups
      netlink: Don't shift on 64 for ngroups

Eric Dumazet (1):
      tcp: add tcp_ooo_try_coalesce() helper

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Filipe Manana (1):
      Btrfs: fix file data corruption after cloning a range and fsync

Greg Kroah-Hartman (1):
      Linux 4.9.119

Kees Cook (1):
      fork: unconditionally clear stack on fork

Konstantin Khlebnikov (1):
      kmemleak: clear stale pointers from task stacks

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer

Michael J. Ruhl (1):
      IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Quinn Tran (1):
      scsi: qla2xxx: Fix ISP recovery on unload

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Theodore Ts'o (1):
      ext4: fix false negatives *and* false positives in ext4_check_descriptors()

Thomas Gleixner (1):
      genirq: Make force irq threading setup more robust

Vitaly Kuznetsov (1):
      ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI handle


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltsNYoACgkQONu9yGCS
aT4J/xAAoRsCzC6g3khY/y2q7787pnwXFxOeJ9rMAowRPlX9Pb2zYF84+4sFvWh2
UiPs84yjCXwVyB6a2Dhz+BaIdcVU2PEHO2F9spvuGXOehJvYzcSzEZPEndDeeh3/
V2ivv7IwucRwAQS4BXe28NILznO04owPSZPLwKWjusqnBMzPF1l/olXMH2v4jRmn
ngGTzUvZH+G6ljuctMW7yr1xsu+ijbRit6KGY4F1jteWtIOdOYei0qlDKt2Z9+we
K8WFIxJuhzEqAaKXz8q6HDFYAyTbD8O9dX7KMv2QNqfYVXd09MDF/bR9MtIj8P1Y
huHOTRueJLGrkG5UHat1sxddHmRI0Oacxf/Hc2FfV0ihMIPCifrt1DS6E6RiDNY/
RMJ6wy9wSOLKWzEp3dNsu/tNhJ51dI0UxxiCupcGughgyGvyS0OfJLm5NWHGYjz6
CS6ELjCanNw+hylRORAfo1sTl00dgPJV5FI4N28+TTfdLnw/qniJX67KodgN22Ho
/FuZX09m9k/cuLbNUllXzaZUvaxm+H/nsuiqGWLIkk+homvjXleBGwBvIzsagu+f
wfgDixe4t9oMHJ7qgEP6C4B/Sye1RyvV4h3mH1T/87YqH+WUuNnz03UNwXNrJKSL
laCsPe8ZgwZfMqKHqoGqSozLgDxly18rGipzvXHH7CKSB8Ws8+o=
=j3pl
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
