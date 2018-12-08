Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B3C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A7620868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544271281;
	bh=N4BpTbXEGgC6BlXdDqOQgrajbVIWhe2YypS5SwfS1KE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G+qS/vBtbXR5OKmsME+UP4u9EIAhfqm2abx50T903t8PgUoseRBkQvLUDim/LeW9S
	 Q84Bb3OPHFKLOkWAJSAQmvOobwDyvmn23c1p23u+24AWBpiV2pilpBrT8TBB3dr18m
	 xS2rnqMCLEHLdoA1KAAxe4hGHKqYsUFMG6kHdtIw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A7620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLHMOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 07:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbeLHMOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 07:14:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4EB32082D;
        Sat,  8 Dec 2018 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544271278;
        bh=N4BpTbXEGgC6BlXdDqOQgrajbVIWhe2YypS5SwfS1KE=;
        h=Date:From:To:Cc:Subject:From;
        b=wH8SmmImINEC2VBQ/NmxoB+zxARfJ5xawaDwFQ07xXD7+Q/l+H+wkebAkht6IP5cu
         cdoHXnSQh/qC9MXfqUkcX6O+GX7StL7EqqLjWyw5AxW/VBehqIbLdOYNOmj38iOMqt
         wX7IdMJAKTtlDkItbjL1RQ+DnteasZDgOzf8Qg9I=
Date:   Sat, 8 Dec 2018 13:14:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.144
Message-ID: <20181208121436.GA23228@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.144 kernel.

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

 Makefile                                     |    5=20
 arch/arc/Kconfig                             |    2=20
 arch/arc/Makefile                            |    2=20
 arch/arc/configs/axs101_defconfig            |    2=20
 arch/arc/configs/axs103_defconfig            |    1=20
 arch/arc/configs/axs103_smp_defconfig        |    1=20
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
 arch/x86/include/asm/suspend_64.h            |    5=20
 arch/x86/kvm/svm.c                           |   19=20
 arch/x86/power/hibernate_64.c                |    6=20
 drivers/android/binder.c                     |   41 +
 drivers/gpu/drm/ast/ast_main.c               |    3=20
 drivers/gpu/drm/drm_auth.c                   |    2=20
 drivers/gpu/drm/gma500/mdfld_intel_display.c |    2=20
 drivers/gpu/drm/mediatek/mtk_hdmi.c          |    5=20
 drivers/infiniband/hw/mlx5/main.c            |   29 -
 drivers/infiniband/ulp/iser/iser_verbs.c     |    7=20
 drivers/input/joystick/xpad.c                |   16=20
 drivers/input/keyboard/matrix_keypad.c       |   23=20
 drivers/input/mouse/elan_i2c_core.c          |    3=20
 drivers/net/ethernet/qlogic/qed/qed_debug.c  |    8=20
 drivers/net/wireless/ath/wil6210/wmi.c       |    8=20
 drivers/reset/core.c                         |   79 ++-
 drivers/scsi/bfa/bfa_fcbuild.c               |    8=20
 drivers/scsi/bfa/bfa_fcs.c                   |   78 +--
 drivers/scsi/bfa/bfa_fcs_lport.c             |   62 --
 drivers/scsi/bfa/bfa_ioc.c                   |    2=20
 drivers/scsi/bfa/bfa_svc.c                   |    4=20
 drivers/scsi/bfa/bfad.c                      |   20=20
 drivers/scsi/bfa/bfad_attr.c                 |    2=20
 drivers/scsi/bfa/bfad_bsg.c                  |    6=20
 drivers/scsi/csiostor/csio_lnode.c           |   43 +
 drivers/scsi/scsi_devinfo.c                  |   22=20
 drivers/staging/rts5208/sd.c                 |    6=20
 drivers/tty/serial/kgdboc.c                  |   43 -
 drivers/usb/gadget/udc/dummy_hcd.c           |    9=20
 fs/btrfs/Makefile                            |    2=20
 fs/btrfs/ctree.h                             |  128 ++---
 fs/btrfs/disk-io.c                           |  162 ------
 fs/btrfs/extent-tree.c                       |   86 +++
 fs/btrfs/extent_io.c                         |   24=20
 fs/btrfs/extent_io.h                         |   19=20
 fs/btrfs/free-space-cache.c                  |    2=20
 fs/btrfs/struct-funcs.c                      |    9=20
 fs/btrfs/tree-checker.c                      |  649 ++++++++++++++++++++++=
+++++
 fs/btrfs/tree-checker.h                      |   38 +
 fs/btrfs/volumes.c                           |   30 +
 fs/btrfs/volumes.h                           |    2=20
 fs/ceph/mds_client.c                         |   15=20
 fs/f2fs/checkpoint.c                         |   46 +
 fs/f2fs/data.c                               |   33 +
 fs/f2fs/f2fs.h                               |   41 +
 fs/f2fs/file.c                               |   21=20
 fs/f2fs/inode.c                              |   68 ++
 fs/f2fs/node.c                               |   73 ++-
 fs/f2fs/recovery.c                           |    6=20
 fs/f2fs/segment.c                            |   34 +
 fs/f2fs/segment.h                            |   48 +
 fs/f2fs/super.c                              |  107 ++++
 fs/hugetlbfs/inode.c                         |   30 +
 fs/kernfs/symlink.c                          |    2=20
 fs/udf/super.c                               |   16=20
 fs/udf/unicode.c                             |   14=20
 fs/xfs/libxfs/xfs_attr.c                     |    9=20
 include/linux/bpf_verifier.h                 |    1=20
 include/linux/ceph/auth.h                    |   13=20
 include/linux/ceph/ceph_features.h           |    4=20
 include/linux/ceph/messenger.h               |    8=20
 include/linux/ceph/msgr.h                    |    2=20
 include/linux/reset.h                        |   92 +--
 include/uapi/linux/btrfs_tree.h              |    1=20
 kernel/bpf/verifier.c                        |   90 ++-
 kernel/debug/kdb/kdb_support.c               |    4=20
 kernel/events/uprobes.c                      |   12=20
 lib/kobject.c                                |    2=20
 lib/test_hexdump.c                           |    2=20
 mm/hugetlb.c                                 |   10=20
 mm/truncate.c                                |    8=20
 net/ceph/auth.c                              |   20=20
 net/ceph/auth_x.c                            |  225 +++++++--
 net/ceph/auth_x_protocol.h                   |    7=20
 net/ceph/messenger.c                         |  101 ++--
 net/ceph/osd_client.c                        |   15=20
 net/ipv4/ip_tunnel.c                         |    4=20
 net/tipc/subscr.c                            |    2=20
 scripts/Makefile.extrawarn                   |    3=20
 scripts/unifdef.c                            |    4=20
 sound/pci/trident/trident.c                  |    2=20
 97 files changed, 2157 insertions(+), 777 deletions(-)

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Alexei Starovoitov (1):
      bpf: Prevent memory disambiguation attack

Alexey Brodkin (1):
      arc: [devboards] Add support of NFSv3 ACL

Andrea Parri (1):
      uprobes: Fix handle_swbp() vs. unregister() + register() race once mo=
re

Arnd Bergmann (7):
      drm: gma500: fix logic error
      scsi: bfa: convert to strlcpy/strlcat
      staging: rts5208: fix gcc-8 logic error warning
      kdb: use memmove instead of overlapping memcpy
      usb: gadget: dummy: fix nonsensical comparisons
      net: qed: use correct strncpy() size
      btrfs: tree-checker: use %zu format string for size_t

Ben Hutchings (3):
      bpf/verifier: Add spi variable to check_stack_write()
      bpf/verifier: Pass instruction index to check_mem_access() and check_=
xadd()
      f2fs: Add sanity_check_inode() function

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Chao Yu (9):
      f2fs: fix race condition in between free nid allocator/initializer
      f2fs: clean up with is_valid_blkaddr()
      f2fs: introduce and spread verify_blkaddr
      f2fs: fix to do sanity check with secs_per_zone
      f2fs: fix to do sanity check with user_block_count
      f2fs: fix to do sanity check with node footer and iblocks
      f2fs: fix to do sanity check with block address in main area
      f2fs: fix to do sanity check with block address in main area v2
      f2fs: fix to do sanity check with cp_pack_start_sum

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Darrick J. Wong (1):
      xfs: don't fail when converting shortform attr to long form during AT=
TR_REPLACE

David Sterba (1):
      btrfs: tree-check: reduce stack consumption in check_dir_item

Dmitry V. Levin (1):
      mips: fix mips_get_syscall_arg o32 check

Filipe Manana (1):
      Btrfs: fix use-after-free when dumping free space

Greg Kroah-Hartman (1):
      Linux 4.9.144

Gu Jinxiang (1):
      btrfs: validate type when reading a chunk

Guenter Roeck (2):
      kobject: Replace strncpy with memcpy
      kernfs: Replace strncpy with memcpy

Guoqing Jiang (1):
      tipc: use destination length for copy string

Heiner Kallweit (1):
      reset: core: fix reset_control_put

Ilya Dryomov (10):
      libceph: drop len argument of *verify_authorizer_reply()
      libceph: no need to drop con->mutex for ->get_authorizer()
      libceph: store ceph_auth_handshake pointer in ceph_connection
      libceph: factor out __prepare_write_connect()
      libceph: factor out __ceph_x_decrypt()
      libceph: factor out encrypt_authorizer()
      libceph: add authorizer challenge
      libceph: implement CEPHX_V2 calculation mode
      libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()
      libceph: check authorizer reply/challenge length before reading

Jaegeuk Kim (6):
      f2fs: detect wrong layout
      f2fs: return error during fill_super
      f2fs: sanity check on sit entry
      f2fs: enhance sanity_check_raw_super() to avoid potential overflow
      f2fs: fix missing up_read
      f2fs: free meta pages if sanity check for ckpt is failed

Jan Kara (1):
      udf: Allow mounting volumes with incorrect identification strings

Jeff Mahoney (1):
      btrfs: struct-funcs, constify readers

Johan Hovold (1):
      drm/mediatek: fix OF sibling-node lookup

Kees Cook (2):
      x86/power/64: Use char arrays for asm function names
      scsi: csiostor: Avoid content leaks and casts

Kevin Hilman (1):
      ARC: change defconfig defaults to ARCv2

Laura Abbott (2):
      kgdboc: Fix restrict error
      kgdboc: Fix warning with module build

Linus Torvalds (2):
      test_hexdump: use memcpy instead of strncpy
      unifdef: use memcpy instead of strncpy

Lior David (1):
      wil6210: missing length check in wmi_set_ie

Martin Wilck (1):
      scsi: scsi_devinfo: cleanly zero-pad devinfo strings

Masahiro Yamada (2):
      reset: make device_reset_optional() really optional
      reset: remove remaining WARN_ON() in <linux/reset.h>

Mathias Kresin (1):
      MIPS: ralink: Fix mt7620 nd_sd pinmux

Michael Guralnik (1):
      IB/mlx5: Avoid load failure due to unknown link width

Mike Kravetz (4):
      mm/hugetlb.c: don't call region_abort if region_chg fails
      hugetlbfs: fix offset overflow in hugetlbfs mmap
      hugetlbfs: check for pgoff value overflow
      hugetlbfs: fix bug in pgoff overflow checking

Nikolay Borisov (1):
      btrfs: Always try all copies when reading extent buffers

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

Philipp Zabel (2):
      reset: fix optional reset_control_get stubs to return NULL
      reset: add exported __reset_control_get, return NULL if optional

Qu Wenruo (13):
      btrfs: Verify that every chunk has corresponding block group at mount=
 time
      btrfs: Refactor check_leaf function for later expansion
      btrfs: Check if item pointer overlaps with the item itself
      btrfs: Add sanity check for EXTENT_DATA when reading out leaf
      btrfs: Add checker for EXTENT_CSUM
      btrfs: Move leaf and node validation checker to tree-checker.c
      btrfs: tree-checker: Enhance btrfs_check_node output
      btrfs: tree-checker: Fix false panic for sanity test
      btrfs: tree-checker: Add checker for dir item
      btrfs: tree-checker: Verify block_group_item
      btrfs: tree-checker: Detect invalid and empty essential trees
      btrfs: Check that each block group has corresponding chunk at mount t=
ime
      btrfs: tree-checker: Check level for leaves and nodes

Ramiro Oliveira (1):
      reset: make optional functions really optional

Sagi Grimberg (1):
      iser: set sector for ambiguous mr status errors

Sam Bobroff (1):
      drm/ast: Fix incorrect free on ioregs

Sergio Correia (1):
      drm: set is_master to 0 upon drm_new_set_master() failure

Shaokun Zhang (1):
      btrfs: tree-checker: Fix misleading group system information

Stephen Rothwell (1):
      disable stringop truncation warnings for now

Sultan Alsawaf (1):
      ip_tunnel: Fix name string concatenate in __ip_tunnel_create()

Takashi Iwai (1):
      ALSA: trident: Suppress gcc string warning

Todd Kjos (1):
      binder: fix proc->files use-after-free

Wei Wang (1):
      svm: Add mutex_lock to protect apic_access_page_done on AMD systems

Xiongfeng Wang (1):
      Kbuild: suppress packed-not-aligned warning for default setting only

Yunlei He (2):
      f2fs: fix a panic caused by NULL flush_cmd_control
      f2fs: check blkaddr more accuratly before issue a bio


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwLtasACgkQONu9yGCS
aT57oQ/9H7HLPJI8L+SwE8/XGGx8oEHgGX64EXszHoexww3lqZfsVHG9Punwod3s
r50RErksDhPNBIzWmYOxwVCX80CjFBtaZaDgyt6QaCEKNanGtAnVIlZjC7fqJCss
ni3mifDTdh79C2KyPXIpu6lSmPAYJTXOK3TR4cGUnzrGlq7+omTeryrWFAuFrgw6
Ma3VVK35hZL1UYmNHJ66cj3ee4u+2myJYFfxv29LGRCiPvmHwZcGxIXnqx4ksaCm
roY1jj6vW7Y4X+N5yDGMvuK2xXMwRyfPKwqAVsWmYN61Dpx4qgIVu49CECkTR/Yo
GGlnKErkqa4d6v2BbffkDLTAlm66dKvihXy5wcuheHuR1iQlQWqSFR5qoO0uGAjg
SIYQksmH9k6s02FEDWHJneTBXAQcOF16b5WFqBN/yK8rDpbgBbsONz6ctwsiUXPo
IPWMQj1ZJnkSulg2ZCuFR3UBrI8cuf68luII8Xlmzns82Ltv3kSJhk/Q+kD+aGn/
pj+8P+82vwAcGeaudFdisMEI9CVjvHP3ZT/TzPU3mMzWN7fPc8J+wUlO9gjVYqwT
327OeQb/Uwaeus6tpKdNDOnF2TwOqigSoFVyuRjy7GNo9JR5IjppSErVwD5EUf/P
1ezfR+7+s6HOk7lE9OpoyEopI+H4LKP1y3MFKm8TAaYPWLLATvU=
=yfKa
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
