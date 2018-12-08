Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75649C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C6E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544271219;
	bh=+0HKNAz3oOVwuy/QMbHteyR9uRfsGip6y/1Ymf7IH/o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=IODUvb3bBaoIPkHWdHErngbJOecubsj0//xbXD5YHrjQfoPzGMtcRERoIjW1gJk95
	 Y/rK5yJHq+vLdEdsr6kqlw7YWif/SSm5T2QJUNO+NhuKt1W4FxHBvNWgpCXnPfzpDX
	 kHb8yCg6PVqNgaXB1JZlU0uwyxuMuHKZBkVA8J60=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C6E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeLHMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:13:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHMNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:13:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8376A2082D;
        Sat,  8 Dec 2018 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544271216;
        bh=+0HKNAz3oOVwuy/QMbHteyR9uRfsGip6y/1Ymf7IH/o=;
        h=Date:From:To:Cc:Subject:From;
        b=yamSmAxhpyOvUlEYDvPFRVDi2iE+w8Q4pzUWx6scnJGoy8AGRl4qPsUtszsh7RQCI
         O2RmcmR2ILuSlb0ppRRawDaEFVqCqbU+XrHs3IFe/qqR1RDWiz7EedHGpiSyu0AkMA
         jd7Zau9HKwfYSCUFtd7FDLi35S/bT1ZHrSakr+c0=
Date:   Sat, 8 Dec 2018 13:13:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.8
Message-ID: <20181208121333.GA23029@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.8 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 arch/arc/Kconfig                                            |    2=20
 arch/arc/Makefile                                           |    2=20
 arch/arc/configs/axs101_defconfig                           |    2=20
 arch/arc/configs/axs103_defconfig                           |    1=20
 arch/arc/configs/axs103_smp_defconfig                       |    1=20
 arch/arc/configs/hsdk_defconfig                             |    1=20
 arch/arc/configs/nps_defconfig                              |    2=20
 arch/arc/configs/nsim_700_defconfig                         |    1=20
 arch/arc/configs/nsimosci_defconfig                         |    2=20
 arch/arc/configs/nsimosci_hs_defconfig                      |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig                  |    1=20
 arch/arc/configs/tb10x_defconfig                            |    1=20
 arch/arc/configs/vdk_hs38_defconfig                         |    1=20
 arch/arc/configs/vdk_hs38_smp_defconfig                     |    1=20
 arch/arm64/include/asm/ftrace.h                             |   13 ++
 arch/mips/include/asm/syscall.h                             |    2=20
 arch/mips/ralink/mt7620.c                                   |    2=20
 arch/x86/kvm/svm.c                                          |   19 ++--
 block/blk-mq.c                                              |    7 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |    2=20
 drivers/gpu/drm/ast/ast_main.c                              |    3=20
 drivers/gpu/drm/drm_auth.c                                  |    2=20
 drivers/gpu/drm/meson/meson_crtc.c                          |   27 +++++
 drivers/gpu/drm/meson/meson_dw_hdmi.c                       |    1=20
 drivers/gpu/drm/meson/meson_venc.c                          |    3=20
 drivers/gpu/drm/meson/meson_viu.c                           |   12 +-
 drivers/infiniband/hw/mlx5/main.c                           |   29 ++----
 drivers/infiniband/ulp/iser/iser_verbs.c                    |    7 -
 drivers/input/joystick/xpad.c                               |   16 +--
 drivers/input/keyboard/cros_ec_keyb.c                       |    3=20
 drivers/input/keyboard/matrix_keypad.c                      |   23 ++--
 drivers/input/mouse/elan_i2c_core.c                         |    3=20
 drivers/input/mouse/synaptics.c                             |    1=20
 drivers/mtd/nand/bbt.c                                      |    3=20
 drivers/net/ethernet/intel/i40e/i40e_main.c                 |    2=20
 drivers/scsi/lpfc/lpfc_init.c                               |    6 +
 drivers/scsi/lpfc/lpfc_sli.c                                |    1=20
 drivers/tty/serial/kgdboc.c                                 |   43 ++++---=
--
 fs/btrfs/tree-checker.c                                     |    8 -
 include/linux/tracepoint.h                                  |    6 -
 include/trace/events/sched.h                                |   12 ++
 kernel/events/uprobes.c                                     |   12 ++
 kernel/trace/trace.h                                        |   57 +++++++=
++++-
 kernel/trace/trace_functions_graph.c                        |    4=20
 kernel/trace/trace_irqsoff.c                                |    2=20
 kernel/trace/trace_sched_wakeup.c                           |    2=20
 lib/test_hexdump.c                                          |    2=20
 mm/hugetlb.c                                                |    2=20
 mm/shmem.c                                                  |   31 +++++-
 mm/userfaultfd.c                                            |   47 +++++++=
+-
 net/tipc/topsrv.c                                           |    2=20
 scripts/unifdef.c                                           |    4=20
 security/selinux/nlmsgtab.c                                 |   13 ++
 54 files changed, 332 insertions(+), 123 deletions(-)

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Alexey Brodkin (1):
      arc: [devboards] Add support of NFSv3 ACL

Andrea Arcangeli (4):
      userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fai=
ls
      userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
      userfaultfd: shmem: add i_size checks
      userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is no=
t set

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Brian Norris (1):
      Input: cros_ec_keyb - fix button/switch capability reports

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Frieder Schrempf (1):
      mtd: nand: Fix memory allocation in nanddev_bbt_init()

Greg Kroah-Hartman (1):
      Linux 4.19.8

Guoqing Jiang (1):
      tipc: use destination length for copy string

Jens Axboe (2):
      blk-mq: fix corruption with direct issue
      blk-mq: punt failed direct issue to dispatch list

Kevin Hilman (1):
      ARC: change defconfig defaults to ARCv2

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Lihong Yang (1):
      i40e: Fix deletion of MAC filters

Linus Torvalds (2):
      test_hexdump: use memcpy instead of strncpy
      unifdef: use memcpy instead of strncpy

Lyude Paul (4):
      drm/amd/dm: Don't forget to attach MST encoders
      drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config
      drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()
      Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Martin Wilck (1):
      scsi: lpfc: fix block guard enablement on SLI3 adapters

Masami Hiramatsu (1):
      arm64: ftrace: Fix to enable syscall events on arm64

Mathias Kresin (1):
      MIPS: ralink: Fix mt7620 nd_sd pinmux

Michael Guralnik (1):
      IB/mlx5: Avoid load failure due to unknown link width

Neil Armstrong (1):
      drm/meson: Fixes for drm_crtc_vblank_on/off support

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Paul Moore (1):
      selinux: add support for RTM_NEWCHAIN, RTM_DELCHAIN, and RTM_GETCHAIN

Pavankumar Kondeti (1):
      sched, trace: Fix prev_state output in sched_switch tracepoint

Qu Wenruo (1):
      btrfs: tree-checker: Don't check max block group size as current max =
chunk size limit is unreliable

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Sam Bobroff (1):
      drm/ast: Fix incorrect free on ioregs

Sergio Correia (1):
      drm: set is_master to 0 upon drm_new_set_master() failure

Steven Rostedt (VMware) (1):
      tracing/fgraph: Fix set_graph_function from showing interrupts

Wei Wang (1):
      svm: Add mutex_lock to protect apic_access_page_done on AMD systems

Zenghui Yu (1):
      tracepoint: Use __idx instead of idx in DO_TRACE macro to make it uni=
que


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwLtW0ACgkQONu9yGCS
aT4Oew//cABhzR/kzakeWT+8/JlpGdnwq14plxf42zdRZJs0qvziUgeFcvo8Vlsb
pj+2yEgUyVeIdIozqLUCpgYAalB24UF1bBn8J6mUAHDqRtVxj0IeSBBlAHrHbpt9
IoXv7GVYOV6SVCBDStNJiMUSnzcoFjE/6fiEE8flqZiREzqijZBsXZW9C0dfxSSw
QA2fV5vxdaA6ph8os0IDA2gxDU57dvSjqri7eZu2ZnDJPeKRprU1ejmazKy6afkC
rlxqPyEn0Z8AGcI6WPVbsAEe5rRZTdLZ5+IMxmHMLfQu7v95RZoyqHW2wRzlc7Xz
6XP7fuAd1orfyIy+4q2Sz9yLyGhLzOcqgXY2B1PAJBZHbrrACUSPM4bVofNAPs2o
CEd4A3qz1XMp6z/GNG2i++DHeTcy19vPFgW+SjQSFFmGIHiiRf6j1UZimqIMp5p7
dVX54/0doO793E7ZX7XiJptHPrt3kb1dZxcwh2EpFt4c8U1nO3j5aqGCj/XzYmCw
CugpjHjd0k8FIH0OmF6+G22cz0y9Kb3cqPMhiVqxSYnRnx0xzkkg9dB+GEA0Tj/5
13MG8wRvqdh6HhthuNcs8hP5X772qI1lm6X9jovrRajABsZcIrhICTNrD+L7ft5z
/5K3pkrNIiBxgrh0tvRnlhCJdl1MbXFgV1yP3gqGuJ/ZcNZSOAY=
=quMO
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
