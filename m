Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C00C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC9C21917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222598;
	bh=SqEmwlOz8sUN+LtJt3OLjM1dSzGgFu+ctbHtAufAWeQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EhkiPnE+W/mQP1EIUoUvyBV1ZS1sIjMLhRxBfHUcOSzXIARP1suE8fckJJHZi2dvz
	 SfNEk3n4uFDAndfms69BCDlOEy0gKghPI2PYDD/lhrHMqOklzy3/Ck29c3M0Rhs70b
	 xk76CwolLukygTZHI1PnRjREaonbNvR2wBwMtUJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbfBOJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:23:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389631AbfBOJXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:23:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A5421917;
        Fri, 15 Feb 2019 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222584;
        bh=SqEmwlOz8sUN+LtJt3OLjM1dSzGgFu+ctbHtAufAWeQ=;
        h=Date:From:To:Cc:Subject:From;
        b=CMzMITd9l70gHjBvIvS5F5nITNwAssJWCDG9GUvXmg7IGCh8goc/KZghtQmuSabaO
         Zj3Z8bdW4qLtw8zOoZ7uHMOniUvuihWWNGpm1X4sbnldR03e3Rqt9F9hnHORv9lCNB
         b6aCxCMHmdO1N1UjITppookyrnruv38nSQd5gVOA=
Date:   Fri, 15 Feb 2019 10:22:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.100
Message-ID: <20190215092249.GA1082@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.100 kernel.

No one should use this, use 4.14.101 instead.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                         |    2=20
 arch/arm/mach-iop32x/n2100.c                     |    3=20
 arch/arm/mach-tango/pm.c                         |    6=20
 arch/arm/mach-tango/pm.h                         |    7=20
 arch/arm/mach-tango/setup.c                      |    2=20
 arch/mips/kernel/mips-cm.c                       |    2=20
 arch/mips/pci/pci-octeon.c                       |   10 -
 arch/mips/vdso/Makefile                          |    4=20
 drivers/gpu/drm/drm_modes.c                      |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c              |    9 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c          |    2=20
 drivers/hid/hid-debug.c                          |  122 +++++--------
 drivers/iio/adc/axp288_adc.c                     |   76 ++++++--
 drivers/iio/chemical/atlas-ph-sensor.c           |    7=20
 drivers/misc/vexpress-syscfg.c                   |    2=20
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c            |   15 -
 drivers/uio/uio.c                                |  206 +++++++++++++++++-=
-----
 fs/debugfs/inode.c                               |    7=20
 fs/ext4/fsync.c                                  |   13 -
 include/linux/hid-debug.h                        |    9 -
 include/linux/uio_driver.h                       |    4=20
 kernel/signal.c                                  |   58 ++++++
 kernel/trace/trace_uprobe.c                      |    2=20
 net/batman-adv/hard-interface.c                  |    5=20
 net/batman-adv/soft-interface.c                  |    2=20
 net/ceph/messenger.c                             |    5=20
 net/mac80211/tx.c                                |   12 +
 net/xfrm/xfrm_user.c                             |   13 +
 samples/mei/mei-amt-version.c                    |    2=20
 tools/perf/tests/attr/base-record                |    2=20
 tools/perf/tests/attr/test-record-group          |    1=20
 tools/perf/tests/attr/test-record-group-sampling |    2=20
 tools/perf/tests/attr/test-record-group1         |    1=20
 tools/perf/tests/attr/test-stat-C0               |    1=20
 tools/perf/tests/attr/test-stat-basic            |    1=20
 tools/perf/tests/attr/test-stat-default          |    4=20
 tools/perf/tests/attr/test-stat-detailed-1       |    8=20
 tools/perf/tests/attr/test-stat-detailed-2       |   13 +
 tools/perf/tests/attr/test-stat-detailed-3       |   13 +
 tools/perf/tests/attr/test-stat-group            |    2=20
 tools/perf/tests/attr/test-stat-group1           |    2=20
 tools/perf/tests/attr/test-stat-no-inherit       |    1=20
 42 files changed, 460 insertions(+), 200 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Andreas Ziegler (1):
      tracing: uprobes: Fix typo in pr_fmt string

Dan Carpenter (1):
      misc: vexpress: Off by one in vexpress_syscfg_exec()

Eric W. Biederman (2):
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

Felix Fietkau (1):
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Westphal (1):
      xfrm: refine validation of template and selector families

Greg Kroah-Hartman (2):
      debugfs: fix debugfs_rename parameter checking
      Linux 4.14.100

Hailong Liu (1):
      uio: fix wrong return value from uio_mmap()

Hamish Martin (2):
      uio: Reduce return paths from uio_write()
      uio: Prevent device destruction while fds are open

Hans de Goede (1):
      iio: adc: axp288: Fix TS-pin handling

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Jiri Olsa (3):
      perf tests attr: Fix task term values
      perf tests attr: Fix group stat tests
      perf tests attr: Make hw events optional

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Paul Burton (1):
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Sven Eckelmann (2):
      batman-adv: Avoid WARN on net_device without parent in netns
      batman-adv: Force mac header to start of data on xmit

Theodore Ts'o (1):
      Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

Thomas Hellstrom (2):
      drm/vmwgfx: Fix setting of dma masks
      drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Tina Zhang (1):
      drm/modes: Prevent division by zero htotal

Tomas Winkler (1):
      samples: mei: use /dev/mei0 instead of /dev/mei

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

Xiubo Li (5):
      uio: use request_threaded_irq instead
      uio: change to use the mutex lock instead of the spin lock
      uio: fix crash after the device is unregistered
      uio: fix possible circular locking dependency
      Revert "uio: use request_threaded_irq instead"


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhOkACgkQONu9yGCS
aT5t8RAAqRVzMebDHl/2Y/qx+/3QvdWQvtDGYJKZ1E01frhYW7yqjIUtqLana9Nr
m85h69A/gfdVijCzMHBQ+dBSfNCWjz8Z4EP8eIvZElkJjNn3mz+5aqZyzmy1aFAL
giCCux03LFAEsi0INySHQLolyvvrgQ3DBbXfp/k/JDxhdW1XbUOPIZXC8ygQEIXY
HSEEzzm05DewM++ogdkXxxAAfvVdKu2MBrbZ3RcCyUtWHIh51cjhqAq/Q/cduK9J
8mmoBGJPlhGSLmntRKPwNsokbBIu/Vuq2Eyro4Aww/fFgjoq5GkyY/OqfXuZY4nR
BPdnQ3aIPmZmYzh0NTsEZ79AhyKJXme78KHJ1WO1+QzjGjk45nYj6lLT35g7Cc04
zJVJvCvgorAnLBKSg9onTPu8W+9goJ0boxUPccaaZuSwG19D5SwmqrRv5X0eXVyq
VxYuCQ9o/sumofG1zuifyAofRVBlL6IJjKAs7d3RWGiKevGwJxrVVEHCm0crtJrk
5keFaybF/CKq6hKlrtfwGKdqmb1gEC/94eQIMZo26D6elyxl8kSsS3xjxk9y37j9
grOeqZbgLs8CMLkFp/Zqzs2/TA7ZfhcbREEcLo38fP4rMwIw/BS466q3nIwmph6V
Dg6zl44H48uY8aacxdUGPfi/tUtNZSRn2CWrFfr1bcTrbLhDVJ0=
=Qc1Z
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
