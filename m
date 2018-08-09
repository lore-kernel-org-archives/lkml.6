Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9338AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C34208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C34208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeHIPCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:02:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbeHIPCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:02:36 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE1E4D0E;
        Thu,  9 Aug 2018 12:37:52 +0000 (UTC)
Date:   Thu, 9 Aug 2018 14:37:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.147
Message-ID: <20180809123749.GA8356@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.4.147 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                        |    2 +-
 drivers/i2c/busses/i2c-imx.c    |    3 +--
 drivers/pci/pci-acpi.c          |    2 +-
 drivers/scsi/qla2xxx/qla_init.c |    7 +++----
 drivers/scsi/qla2xxx/qla_os.c   |    5 +++--
 fs/ext4/super.c                 |    4 ++--
 fs/jfs/xattr.c                  |   10 ++++++----
 include/linux/ring_buffer.h     |    1 +
 kernel/irq/manage.c             |    9 ++++++++-
 kernel/time/tick-sched.c        |    2 +-
 kernel/trace/ring_buffer.c      |   16 ++++++++++++++++
 kernel/trace/trace.c            |    6 ++++++
 net/netlink/af_netlink.c        |    5 +++++
 13 files changed, 54 insertions(+), 18 deletions(-)

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Dmitry Safonov (3):
      netlink: Do not subscribe to non-existent groups
      netlink: Don't shift with UB on nlk->ngroups
      netlink: Don't shift on 64 for ngroups

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Greg Kroah-Hartman (1):
      Linux 4.4.147

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer

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


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltsNZ0ACgkQONu9yGCS
aT50GBAAn2yfV8qYJ2XTtEATKxZRWeXVwYMFg1lllGgi1SmVjmwrmKfUE2AYeqyw
Yq1g+MHvlAh5EnoE+n9rLShufrmkFz+IqAHR1cg1JZJc+Wi3wfpjIFKaEODL7M/Z
qvDy4b+Rd1yFaF6JR5Ss4cRlYJtHYOngAH6IYPpT70gEQOIveDyIaw63wB6ZfUG/
1ahEg3LWo5XR860DuTK1PsnZzQiFGZ25IU+//kq8eKlOiAyp/q3+Wq09aj4qgXIT
TFzdLZb6GmGYGuSui3oo3if+MbdjCF0pLhf8EpW0e+vPMTNpeiy53WqBhM17Po8q
v/PRoeNdy6Txyo5WWyNXYzsJfttuRc1M+iiWt/KVar6hOGhEm6B14hOCd/yhvW6H
0OHRFgYySKoGbASOP/GKBJhYZtOd1A75zIukTFVhH52UfgFZGzXvIXrUABUdKRkL
ZcsZRDDa/MuaoTdgvwDhaIFyEGCkJHKD+djaVUPnRQVuyBTaTaROhi7dqGiAscSV
MCPn09NoVipCCv8aT4pPkTjc2nCNWpXtvzO4PSSq8XwWOh/9+CjeiL6LaAg4nKwR
mTQd6faGwweHWoKtBb4mmSadv8cEo5bGQKibVJspgl3SjInBwrSqCxKhBLsPddBH
gL4Ci97A0xBuhiFZnsHjVD7gPILUkpSOErWYwepex0ZsZu9A2x8=
=BSN9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
