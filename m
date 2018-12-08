Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD5EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B78B2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544271241;
	bh=gSQEvGGRI8hqJ1rz6on0x52L0Tu2WsZ+6EkHi1WTIzc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jVGiHMR2iC6duBZ/3z2AEpamodTnvQSDp05SQHZEU4h7krQccpW0tpurtd83xpl1a
	 fCXM1iUunpYzzvbuYuAQuBNmWePx7ngW5xNM+DGeGWrEru77uLLtnq+OC4LjImWkAh
	 zACYE8Cf8fzsRwADpb5aCMvYg3mXT1MEhDIk/MhE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B78B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLHMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:13:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A13D2082D;
        Sat,  8 Dec 2018 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544271237;
        bh=gSQEvGGRI8hqJ1rz6on0x52L0Tu2WsZ+6EkHi1WTIzc=;
        h=Date:From:To:Cc:Subject:From;
        b=rmqhiq46n8UiNBFgLJxDwntdJYeSe81sYWxZ5Rmne0SaLgFjRY1/XgLENE2paTU7Q
         5Qmg/UxlLzcPERwTRuHywOPHACAxlpMPJ/mCB7qHfgZ9aWSLOBpruAIKbbufdeDuWT
         3s/MtahiBOa1M7eEi37So96nmnpvbb7nsWAxcvSs=
Date:   Sat, 8 Dec 2018 13:13:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.87
Message-ID: <20181208121355.GA23108@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.87 kernel.

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

 Makefile                                     |    5=20
 arch/arc/Kconfig                             |    2=20
 arch/arc/Makefile                            |    2=20
 arch/arc/configs/axs101_defconfig            |    2=20
 arch/arc/configs/axs103_defconfig            |    1=20
 arch/arc/configs/axs103_smp_defconfig        |    1=20
 arch/arc/configs/hsdk_defconfig              |    1=20
 arch/arc/configs/nps_defconfig               |    2=20
 arch/arc/configs/nsim_700_defconfig          |    1=20
 arch/arc/configs/nsimosci_defconfig          |    2=20
 arch/arc/configs/nsimosci_hs_defconfig       |    1=20
 arch/arc/configs/nsimosci_hs_smp_defconfig   |    1=20
 arch/arc/configs/tb10x_defconfig             |    1=20
 arch/arc/configs/vdk_hs38_defconfig          |    1=20
 arch/arc/configs/vdk_hs38_smp_defconfig      |    1=20
 arch/mips/include/asm/syscall.h              |    2=20
 arch/mips/ralink/mt7620.c                    |    2=20
 arch/x86/kvm/svm.c                           |   19 -
 drivers/gpu/drm/ast/ast_main.c               |    3=20
 drivers/gpu/drm/drm_auth.c                   |    2=20
 drivers/gpu/drm/gma500/mdfld_intel_display.c |    2=20
 drivers/gpu/drm/meson/meson_dw_hdmi.c        |    1=20
 drivers/gpu/drm/meson/meson_viu.c            |   12 -
 drivers/gpu/drm/msm/adreno/adreno_device.c   |    5=20
 drivers/infiniband/hw/mlx5/main.c            |   29 --
 drivers/infiniband/ulp/iser/iser_verbs.c     |    7=20
 drivers/input/joystick/xpad.c                |   16 -
 drivers/input/keyboard/cros_ec_keyb.c        |    3=20
 drivers/input/keyboard/matrix_keypad.c       |   23 +
 drivers/input/mouse/elan_i2c_core.c          |    3=20
 drivers/input/mouse/synaptics.c              |    1=20
 drivers/net/ethernet/qlogic/qed/qed_debug.c  |    6=20
 drivers/reset/core.c                         |    9=20
 drivers/scsi/bfa/bfa_fcbuild.c               |    8=20
 drivers/scsi/bfa/bfa_fcs.c                   |   78 +++---
 drivers/scsi/bfa/bfa_fcs_lport.c             |   62 ++---
 drivers/scsi/bfa/bfa_ioc.c                   |    2=20
 drivers/scsi/bfa/bfa_svc.c                   |    4=20
 drivers/scsi/bfa/bfad.c                      |   20 -
 drivers/scsi/bfa/bfad_attr.c                 |    2=20
 drivers/scsi/bfa/bfad_bsg.c                  |    6=20
 drivers/scsi/scsi_devinfo.c                  |   22 -
 drivers/staging/rts5208/sd.c                 |    6=20
 drivers/thermal/hisi_thermal.c               |  318 ++++++++++++++--------=
-----
 drivers/tty/serial/kgdboc.c                  |   43 +--
 fs/btrfs/disk-io.c                           |   10=20
 fs/btrfs/tree-checker.c                      |    8=20
 fs/kernfs/symlink.c                          |    2=20
 fs/udf/super.c                               |   16 -
 fs/udf/unicode.c                             |   14 -
 fs/userfaultfd.c                             |   15 +
 include/linux/reset.h                        |   34 +-
 kernel/debug/kdb/kdb_support.c               |    4=20
 kernel/events/uprobes.c                      |   12 -
 lib/kobject.c                                |    2=20
 lib/test_hexdump.c                           |    2=20
 mm/hugetlb.c                                 |    2=20
 mm/shmem.c                                   |   31 ++
 mm/truncate.c                                |    8=20
 mm/userfaultfd.c                             |   62 +++--
 mm/vmstat.c                                  |    4=20
 net/ipv4/ip_tunnel.c                         |    4=20
 net/tipc/subscr.c                            |    2=20
 scripts/Makefile.extrawarn                   |    3=20
 scripts/unifdef.c                            |    4=20
 sound/pci/trident/trident.c                  |    2=20
 sound/x86/intel_hdmi_audio.c                 |    2=20
 67 files changed, 537 insertions(+), 446 deletions(-)

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Alexey Brodkin (1):
      arc: [devboards] Add support of NFSv3 ACL

Andrea Arcangeli (5):
      userfaultfd: use ENOENT instead of EFAULT if the atomic copy user fai=
ls
      userfaultfd: shmem: allocate anonymous memory for MAP_PRIVATE shmem
      userfaultfd: shmem: add i_size checks
      userfaultfd: shmem: UFFDIO_COPY: set the page dirty if VM_WRITE is no=
t set
      userfaultfd: shmem/hugetlbfs: only allow to register VM_MAYWRITE vmas

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Arnd Bergmann (5):
      drm: gma500: fix logic error
      scsi: bfa: convert to strlcpy/strlcat
      staging: rts5208: fix gcc-8 logic error warning
      kdb: use memmove instead of overlapping memcpy
      net: qed: use correct strncpy() size

Brian Norris (1):
      Input: cros_ec_keyb - fix button/switch capability reports

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Daniel Lezcano (5):
      thermal/drivers/hisi: Remove the multiple sensors support
      thermal/drivers/hisi: Remove pointless lock
      thermal/drivers/hisi: Encapsulate register writes into helpers
      thermal/drivers/hisi: Fix configuration register setting
      thermal/drivers/hisi: Remove costly sensor inspection

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Greg Kroah-Hartman (1):
      Linux 4.14.87

Guenter Roeck (2):
      kobject: Replace strncpy with memcpy
      kernfs: Replace strncpy with memcpy

Guoqing Jiang (1):
      tipc: use destination length for copy string

Jan Kara (1):
      udf: Allow mounting volumes with incorrect identification strings

Johan Hovold (1):
      drm/msm: fix OF child-node lookup

Kevin Hilman (1):
      ARC: change defconfig defaults to ARCv2

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Linus Torvalds (2):
      test_hexdump: use memcpy instead of strncpy
      unifdef: use memcpy instead of strncpy

Lyude Paul (3):
      drm/meson: Enable fast_io in meson_dw_hdmi_regmap_config
      drm/meson: Fix OOB memory accesses in meson_viu_set_osd_lut()
      Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Martin Wilck (1):
      scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Masahiro Yamada (2):
      reset: make device_reset_optional() really optional
      reset: remove remaining WARN_ON() in <linux/reset.h>

Mathias Kresin (1):
      MIPS: ralink: Fix mt7620 nd_sd pinmux

Michael Guralnik (1):
      IB/mlx5: Avoid load failure due to unknown link width

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

Qu Wenruo (1):
      btrfs: tree-checker: Don't check max block group size as current max =
chunk size limit is unreliable

Roman Gushchin (1):
      mm: hide incomplete nr_indirectly_reclaimable in /proc/zoneinfo

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Sam Bobroff (1):
      drm/ast: Fix incorrect free on ioregs

Sergio Correia (1):
      drm: set is_master to 0 upon drm_new_set_master() failure

Stephen Rothwell (1):
      disable stringop truncation warnings for now

Sultan Alsawaf (1):
      ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Takashi Iwai (2):
      ALSA: intel_hdmi: Use strlcpy() instead of strncpy()
      ALSA: trident: Suppress gcc string warning

Wei Wang (1):
      svm: Add mutex_lock to protect apic_access_page_done on AMD systems

Xiongfeng Wang (1):
      Kbuild: suppress packed-not-aligned warning for default setting only


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwLtYMACgkQONu9yGCS
aT40Dg/+MuxsAA6MZ1EKPHdyRYT3aTfNiHAiKuG5xfz/FGoeqpa5QVDEp2rXBJS/
5TSZTi6sNNjZxpdGFPhnSveN6eHERTmBY43daDus19E/GSKskGA2rDcWaRmwztKg
OD4j5GgqDC3N0zpVw6cRNbD807LwjRuPshEXhi+P0tdsbHES1LUpuhYvs/rM+NT6
ShVlj3ih+iwlpXGGd7b9qPvO+SkfvQ9UdMmSyao9QjpacIhdWB0gaQRnMBL5vAas
Xi4ljNFLpbi5wlKOF5oCyA7OERsxngTd37gYWTIvyncinBkFEDBdccexJDejVrRP
fWmR8Y82OoIaHGMWCoCyizo/tmClzPpzfYsLRg1kQ+ZJII5NrVFuYYZ5Q4bBfyRH
EUPyMgDwKeli+fvZCDgmrfCezW+cHt9R955RKsSnKMOjS2p6oN+31W/lASZNim45
mjKvzdS4ag95MSq13V1fpPxVC7km/TJQheXKQ67DLF0Bq2GV2z7ESdHrB4EW7BKz
grboATnA5NcuzJHB4wp0uV6os/n/wZUfXcpYQdutbc1GAEE5+Ps709WNIgKztd6l
4W5dCF/dNrE69wwOPAbCzH/gP39iOr8Qh7ORiHhPVybAbOLfmYZi1SOhaVD1xwWm
XkibCFqdIcqUMzALBHWKq4g/tXdlIi4e8s1FW6AVnApAg3DGUzc=
=bd9Y
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
