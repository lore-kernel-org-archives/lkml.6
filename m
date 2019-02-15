Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB817C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A376218FF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550222661;
	bh=3gRJt3oba1OJspLbt2wGI7CLeLWI0/H0v9S8r8vRzx0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wWjrIb83AUadQNi1hDlRe/VrtvykNut8+UKy6RpZvWapx8q+mqsH7/1cuInmA4/gm
	 uD3gM/c+XaNVZdY+8g6AskdsAwAmYu4tVa8grXLIuepb/CA4Y+NdD8vgzh5yoXsPzU
	 nnq6ux3pY41Gkfjz/UKpl97wxVbkihR8U429aVfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbfBOJYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388265AbfBOJYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:24:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADA8421925;
        Fri, 15 Feb 2019 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550222647;
        bh=3gRJt3oba1OJspLbt2wGI7CLeLWI0/H0v9S8r8vRzx0=;
        h=Date:From:To:Cc:Subject:From;
        b=0oTYPrguBzFAOod7k+5SJMlXMyJkQJaasFYaurcqMSGJhIEkOiTZNEpW/am0ddlIZ
         NnLFA4r2ds1ReynmwbWaYKCAoGbUZuOiteuQwNkWNQgsB5BzjEE71MCfJRPo/txIuj
         VW4vdQyuCYOV7L3wiFY9lHV/UzNyhXvX8H1Un0gU=
Date:   Fri, 15 Feb 2019 10:23:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.22
Message-ID: <20190215092349.GA1305@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.22 kernel.

Don't use this, use 4.19.23 instead.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                          |    2=20
 arch/arm/boot/dts/da850.dtsi                      |    2=20
 arch/arm/mach-iop32x/n2100.c                      |    3=20
 arch/arm/mach-tango/pm.c                          |    6 -
 arch/arm/mach-tango/pm.h                          |    7 +
 arch/arm/mach-tango/setup.c                       |    2=20
 arch/mips/kernel/mips-cm.c                        |    2=20
 arch/mips/loongson64/common/reset.c               |    7 +
 arch/mips/pci/pci-octeon.c                        |   10 +-
 arch/mips/vdso/Makefile                           |    5 -
 arch/powerpc/include/asm/book3s/64/pgtable.h      |   22 +---
 arch/powerpc/mm/pgtable-book3s64.c                |   22 ++++
 drivers/ata/libata-core.c                         |    1=20
 drivers/firmware/arm_scmi/bus.c                   |    9 +
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |    1=20
 drivers/gpu/drm/drm_modes.c                       |    2=20
 drivers/gpu/drm/i915/intel_ddi.c                  |    2=20
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c               |    9 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |    2=20
 drivers/iio/adc/axp288_adc.c                      |   76 ++++++++++++---
 drivers/iio/adc/ti-ads8688.c                      |    3=20
 drivers/iio/chemical/atlas-ph-sensor.c            |    7 -
 drivers/misc/mei/hw-me-regs.h                     |    2=20
 drivers/misc/mei/pci-me.c                         |    2=20
 drivers/misc/mic/vop/vop_main.c                   |    4=20
 drivers/misc/vexpress-syscfg.c                    |    2=20
 drivers/mtd/mtdpart.c                             |    4=20
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c         |   13 +-
 drivers/mtd/nand/spi/core.c                       |   46 ++++-----
 drivers/pinctrl/intel/pinctrl-cherryview.c        |    8 -
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c         |    2=20
 fs/debugfs/inode.c                                |    7 +
 fs/ext4/fsync.c                                   |   13 --
 include/linux/sunrpc/xprt.h                       |    5 +
 kernel/signal.c                                   |   58 +++++++++++-
 kernel/trace/trace_uprobe.c                       |    2=20
 net/batman-adv/hard-interface.c                   |    5 -
 net/batman-adv/soft-interface.c                   |    2=20
 net/ceph/messenger.c                              |    5 -
 net/mac80211/tx.c                                 |   12 +-
 net/sunrpc/clnt.c                                 |    6 -
 net/sunrpc/xprtrdma/svc_rdma_sendto.c             |  105 +++++++++++++++++=
+++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c          |   13 +-
 net/xfrm/xfrm_policy.c                            |    5 -
 net/xfrm/xfrm_user.c                              |   13 +-
 samples/mei/mei-amt-version.c                     |    2=20
 tools/iio/iio_generic_buffer.c                    |    2=20
 47 files changed, 401 insertions(+), 139 deletions(-)

Aaro Koskinen (1):
      MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Andreas Ziegler (1):
      tracing: uprobes: Fix typo in pr_fmt string

Aneesh Kumar K.V (1):
      powerpc/radix: Fix kernel crash with mremap()

Bartosz Golaszewski (1):
      ARM: dts: da850: fix interrupt numbers for clocksource

Benedict Wong (1):
      xfrm: Make set-mark default behavior backward compatible

Benjamin Coddington (1):
      SUNRPC: Always drop the XPRT_LOCK on XPRT_CLOSE_WAIT

Boris Brezillon (3):
      mtd: Make sure mtd->erasesize is valid even if the partition is of si=
ze 0
      mtd: spinand: Handle the case where PROGRAM LOAD does not reset the c=
ache
      mtd: spinand: Fix the error/cleanup path in spinand_init()

Chen-Yu Tsai (1):
      pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller

Chuck Lever (2):
      svcrdma: Reduce max_send_sges
      svcrdma: Remove max_sge check at connect time

Dan Carpenter (1):
      misc: vexpress: Off by one in vexpress_syscfg_exec()

Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Dmitry Torokhov (1):
      pinctrl: cherryview: fix Strago DMI workaround

Eric W. Biederman (2):
      signal: Always notice exiting tasks
      signal: Better detection of synchronous signals

Felix Fietkau (1):
      mac80211: ensure that mgmt tx skbs have tailroom for encryption

Florian Westphal (1):
      xfrm: refine validation of template and selector families

Greg Kroah-Hartman (2):
      debugfs: fix debugfs_rename parameter checking
      Linux 4.19.22

Gustavo A. R. Silva (1):
      drm/amd/powerplay: Fix missing break in switch

Hans de Goede (2):
      libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD
      iio: adc: axp288: Fix TS-pin handling

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Lucas De Marchi (1):
      drm/i915: always return something on DDI clock selection

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Martin Kepplinger (1):
      mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsi=
us

Paul Burton (2):
      MIPS: VDSO: Use same -m%-float cflag as the kernel proper
      MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Sudeep Holla (1):
      firmware: arm_scmi: provide the mandatory device release callback

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

Tomas Winkler (2):
      mei: me: add ice lake point device id.
      samples: mei: use /dev/mei0 instead of /dev/mei

Vincent Whitchurch (1):
      mic: vop: Fix use-after-free on remove

Vladimir Kondratiev (1):
      mips: cm: reprime error cause

Yifeng Li (1):
      mips: loongson64: remove unreachable(), fix loongson_poweroff().


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxmhSUACgkQONu9yGCS
aT6jjQ/+Jcz51SWx3ZbZzXJJm4RyEeiL7MHq9NfsGh5fkNV6J62sbzR9sRai1qgj
zOaXzJJxqrjatAtaI1XStnvc+re45jdAy4ijPS+aiqXo8xBbNFSVnxEIKP/EydB7
DocAryNBpP0OzQlaNWMjEfxR94kyeZa6zo46XwY3nbMnulUok8DXP7Ey7qkZZm3u
1VUFeE7ZgJQl3UdjBTks4fYKCw97gFduWKQHEA7GDjojiTVzTdF/+ZYtb+RJXTo7
6ZUtu1DUGn1rDLZCu56DWIJnJdzdVXQNDuuXpLdpD3KPwmwibkMtqyL2CtCgfEIZ
dBxFGEMi7tLb+XBqVUfSxAFFxX02Mjf9yDr8D1g3yJqWtnYS26kq9LeZTrDePM5M
ZJ/ifTJB0gyEdA3xsf7d3atM3QqG6HIUvhMk/istWcXitszy1vjplJX7CYnsYC4T
4iJKD+hNsSQyGSJaYqKK2/BGb+/MNccjAOcZdeAppm6b+XJFwAY8PQYSPcaYn+HF
2aYAGFqrhvbfx6TTk0oy2erl70Bxq4MndTONZOBCqV4Ij7+1vaePpuWudncd3dvs
MzU3wnN3fSBdmIayHi6+s2MZbywCqxqeAUgHOV/0+FokSSF/LxdAnfc+UWQLn/V2
tz7zPIvowfgjoCi30on3YvuDR4GvZUe3wr2j/GTTbyKaOXw5NzY=
=f5i3
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
