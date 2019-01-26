Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DADC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE07218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548494985;
	bh=Vqj8x9K+DfAdzfkG7/VdFOwGG5WqcPr4kVpfUd4ABDg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rTOrDjZEnbcpbhGCnG2qt6WaSbemYOQiOd446uLOpVvfH2lJ3rvA8nmhuuZ24fSZV
	 v23LfwDBYNsT0/SZHfF9fW3tKMFIqfYIA2tTLEVgjf5/9jedq4bzEdYQNXYEy2EYFo
	 dLaN4wWktZw9pPzuWcG4ZPEVEh+hgj42TB/fAwjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfAZJ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:29:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfAZJ3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:29:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31A4218F0;
        Sat, 26 Jan 2019 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548494981;
        bh=Vqj8x9K+DfAdzfkG7/VdFOwGG5WqcPr4kVpfUd4ABDg=;
        h=Date:From:To:Cc:Subject:From;
        b=B3TXtQw3uUTVkjsPV8iqhm+yUAIdbcdTcVAYkgT5ONyATfo0n3IBD9LrrNoOQgLze
         w6OuGFgQVTTwANlk7P6p77Jz/Bob5xFbp0SytK96VjaxwTLimkSVr1V4VMsrG+03Ii
         ik/2VlMgiMwPu6VOz0syT1OmM7oR59TdzM8AtWN4=
Date:   Sat, 26 Jan 2019 10:29:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.172
Message-ID: <20190126092938.GA23417@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.172 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/filesystems/proc.txt               |    4=20
 Makefile                                         |    2=20
 arch/arm64/include/asm/kvm_arm.h                 |    3=20
 arch/arm64/kernel/head.S                         |    3=20
 arch/arm64/kernel/perf_event.c                   |    1=20
 arch/arm64/kvm/hyp.S                             |    2=20
 arch/mips/Kconfig                                |    4=20
 arch/mips/pci/msi-octeon.c                       |    4=20
 arch/mips/sibyte/common/Makefile                 |    1=20
 arch/mips/sibyte/common/dma.c                    |   14 +
 crypto/authenc.c                                 |   14 +
 crypto/authencesn.c                              |    2=20
 drivers/base/bus.c                               |    7=20
 drivers/block/loop.c                             |   79 +++++-----
 drivers/block/loop.h                             |    1=20
 drivers/char/ipmi/ipmi_ssif.c                    |   25 ++-
 drivers/clk/imx/clk-imx6q.c                      |    6=20
 drivers/cpuidle/cpuidle-pseries.c                |    8 -
 drivers/gpu/drm/drm_fb_helper.c                  |    7=20
 drivers/md/dm-kcopyd.c                           |   19 +-
 drivers/md/dm-snap.c                             |   22 +++
 drivers/media/firewire/firedtv-avc.c             |    6=20
 drivers/media/firewire/firedtv.h                 |    6=20
 drivers/media/platform/vivid/vivid-kthread-cap.c |    5=20
 drivers/media/platform/vivid/vivid-kthread-out.c |    5=20
 drivers/media/platform/vivid/vivid-vid-common.c  |    2=20
 drivers/media/usb/em28xx/em28xx-video.c          |    4=20
 drivers/media/v4l2-core/videobuf2-core.c         |   14 +
 drivers/mfd/tps6586x.c                           |   24 +++
 drivers/mmc/host/atmel-mci.c                     |    3=20
 drivers/net/ethernet/intel/e1000e/ptp.c          |   13 +
 drivers/net/ethernet/realtek/r8169.c             |    2=20
 drivers/platform/x86/asus-wmi.c                  |    3=20
 drivers/scsi/megaraid/megaraid_sas_fp.c          |    2=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c      |    2=20
 drivers/scsi/sd.c                                |    6=20
 drivers/target/target_core_spc.c                 |   17 +-
 drivers/tty/tty_ldsem.c                          |   10 +
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c  |    2=20
 fs/btrfs/disk-io.c                               |    8 +
 fs/f2fs/checkpoint.c                             |  168 ++++++++++++------=
-----
 fs/f2fs/data.c                                   |  118 +++++++++-------
 fs/f2fs/dir.c                                    |   87 ++++++-----
 fs/f2fs/f2fs.h                                   |   77 ++++++++--
 fs/f2fs/file.c                                   |   21 ++
 fs/f2fs/inline.c                                 |  115 +++++++++++++++
 fs/f2fs/inode.c                                  |   68 ++++++++-
 fs/f2fs/node.c                                   |  103 ++++++++------
 fs/f2fs/node.h                                   |   77 ++++++----
 fs/f2fs/recovery.c                               |  165 +++++++++++-------=
----
 fs/f2fs/segment.c                                |   93 ++++++------
 fs/f2fs/segment.h                                |   48 +++++-
 fs/f2fs/super.c                                  |  134 +++++++++++++++---
 fs/jffs2/super.c                                 |    3=20
 fs/ocfs2/localalloc.c                            |    9 -
 fs/proc/array.c                                  |    2=20
 fs/pstore/ram_core.c                             |    5=20
 fs/xfs/libxfs/xfs_attr.c                         |    9 +
 include/linux/backing-dev-defs.h                 |    8 +
 include/linux/f2fs_fs.h                          |    3=20
 mm/page-writeback.c                              |   35 ++--
 net/bridge/br_netfilter_hooks.c                  |    2=20
 net/can/gw.c                                     |   30 +++-
 net/core/skbuff.c                                |   11 -
 net/core/sock.c                                  |    1=20
 net/ipv4/ip_sockglue.c                           |   12 -
 net/ipv6/af_inet6.c                              |   14 +
 net/ipv6/datagram.c                              |   11 -
 net/packet/af_packet.c                           |    4=20
 net/sctp/ipv6.c                                  |    5=20
 net/sctp/protocol.c                              |    4=20
 net/sunrpc/rpcb_clnt.c                           |    8 +
 net/tipc/netlink_compat.c                        |   50 ++++++
 scripts/kconfig/zconf.l                          |    4=20
 security/security.c                              |    7=20
 security/selinux/ss/policydb.c                   |    3=20
 security/yama/yama_lsm.c                         |    4=20
 sound/firewire/bebob/bebob.c                     |    2=20
 tools/perf/arch/x86/util/intel-pt.c              |   11 +
 tools/perf/util/parse-events.c                   |    2=20
 tools/perf/util/svghelper.c                      |    2=20
 81 files changed, 1334 insertions(+), 563 deletions(-)

Adrian Hunter (1):
      perf intel-pt: Fix error with config term "pt=3D0"

Anders Roxell (2):
      writeback: don't decrement wb->refcnt if !wb->bdi
      arm64: perf: set suppress_bind_attrs flag to true

Arnaldo Carvalho de Melo (2):
      perf svghelper: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()

Arnd Bergmann (1):
      mips: fix n32 compat_ipc_parse_version

Ben Hutchings (2):
      f2fs: Add sanity_check_inode() function
      media: em28xx: Fix misplaced reset of dev->v4l::field_count

Breno Leitao (1):
      powerpc/pseries/cpuidle: Fix preempt warning

Brian Foster (1):
      mm/page-writeback.c: don't break integrity writeback on ->writepage()=
 error

Chao Yu (17):
      f2fs: clean up argument of recover_data
      f2fs: fix to convert inline directory correctly
      f2fs: factor out fsync inode entry operations
      f2fs: fix inode cache leak
      f2fs: fix to avoid reading out encrypted data in page cache
      f2fs: avoid unneeded loop in build_sit_entries
      f2fs: fix race condition in between free nid allocator/initializer
      f2fs: clean up with is_valid_blkaddr()
      f2fs: introduce and spread verify_blkaddr
      f2fs: fix to do sanity check with secs_per_zone
      f2fs: fix to do sanity check with user_block_count
      f2fs: fix to do sanity check with node footer and iblocks
      f2fs: fix to do sanity check with reserved blkaddr of inline inode
      f2fs: fix to do sanity check with block address in main area
      f2fs: fix to do sanity check with block address in main area v2
      f2fs: fix to do sanity check with cp_pack_start_sum
      f2fs: fix invalid memory access

Corey Minyard (1):
      ipmi:ssif: Fix handling of multi-part return messages

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

Darrick J. Wong (1):
      xfs: don't fail when converting shortform attr to long form during AT=
TR_REPLACE

David Ahern (2):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped a=
ddress
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Disseldorp (1):
      scsi: target: use consistent left-aligned ASCII INQUIRY data

Dmitry Safonov (1):
      tty/ldsem: Wake up readers after timed out down_write()

Eric Biggers (1):
      crypto: authenc - fix parsing key with misaligned rta_len

Eric Dumazet (2):
      ipv6: fix kernel-infoleak in ipv6_local_error()
      net: speed up skb_rbtree_purge()

Greg Kroah-Hartman (1):
      Linux 4.4.172

Gwendal Grignou (1):
      proc: Remove empty line in /proc/self/status

Hans Verkuil (3):
      media: vivid: fix error handling of kthread_run
      media: vivid: set min width/height to a value > 0
      media: vb2: vb2_mmap: move lock up

Harsh Jain (1):
      crypto: authencesn - Avoid twice completion call in decrypt path

Ivan Mironov (2):
      scsi: sd: Fix cache_type_store()
      drm/fb-helper: Ignore the value of fb_var_screeninfo.pixclock

J. Bruce Fields (1):
      sunrpc: handle ENOMEM in rpcb_getport_async

Jaegeuk Kim (12):
      f2fs: cover more area with nat_tree_lock
      f2fs: give -EINVAL for norecovery and rw mount
      f2fs: remove an obsolete variable
      f2fs: use crc and cp version to determine roll-forward recovery
      f2fs: put directory inodes before checkpoint in roll-forward recovery
      f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack
      f2fs: detect wrong layout
      f2fs: free meta pages if sanity check for ckpt is failed
      f2fs: return error during fill_super
      f2fs: sanity check on sit entry
      f2fs: enhance sanity_check_raw_super() to avoid potential overflow
      f2fs: fix missing up_read

James Morris (1):
      LSM: Check for NULL cred-security on free

Jan Kara (2):
      loop: Fold __loop_release into loop_release
      loop: Get rid of loop_index_mutex

Jason Gunthorpe (1):
      packet: Do not leak dev refcounts on error exit

JianJhen Chen (1):
      net: bridge: fix a bug on using a neighbour cache entry without check=
ing its state

Joel Fernandes (Google) (1):
      pstore/ram: Do not treat empty buffers as valid

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Jonathan Hunter (1):
      mfd: tps6586x: Handle interrupts on suspend

Josef Bacik (1):
      btrfs: wait on ordered extents on abort cleanup

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Tell the EC the OS will handle the display of=
f hotkey

Junxiao Bi (1):
      ocfs2: fix panic due to unrecovered local alloc

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kees Cook (1):
      Yama: Check for pid death before checking ancestry

Lucas Stach (1):
      clk: imx6q: reset exclusive gates on init

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Mark Rutland (2):
      arm64/kvm: consistently handle host HCR_EL2 flags
      arm64: Don't trap host pointer auth use to EL2

Martin Blumenstingl (1):
      f2fs: fix validation of the block count in sanity_check_raw_super

Masahiro Yamada (2):
      kconfig: fix file name and line number of warn_ignored_character()
      kconfig: fix memory leak when EOF is encountered in quotation

Mauro Carvalho Chehab (1):
      media: vb2: be sure to unlock mutex on errors

Michal Hocko (1):
      mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/sma=
ps

Miroslav Lichvar (1):
      e1000e: allow non-monotonic SYSTIM readings

Nathan Chancellor (1):
      media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Nikos Tsironis (2):
      dm kcopyd: Fix bug causing workqueue stalls
      dm snapshot: Fix excessive memory usage and workqueue stalls

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification

Qian Cai (1):
      scsi: megaraid: fix out-of-bound array accesses

Shawn Lin (1):
      f2fs: move sanity checking of cp into get_valid_checkpoint

Stephen Smalley (1):
      selinux: fix GPF on invalid policy

Takashi Sakamoto (1):
      ALSA: bebob: fix model-id of unit for Apogee Ensemble

Tetsuo Handa (2):
      block/loop: Use global lock for ioctl() operation.
      loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Tiezhu Yang (1):
      f2fs: introduce get_checkpoint_version for cleanup

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

Willem de Bruijn (1):
      ip: on queued skb use skb_header_pointer instead of pskb_may_pull

Xin Long (1):
      sctp: allocate sctp_sockaddr_entry with kzalloc

Ying Xue (5):
      tipc: fix uninit-value in tipc_nl_compat_link_reset_stats
      tipc: fix uninit-value in tipc_nl_compat_bearer_enable
      tipc: fix uninit-value in tipc_nl_compat_link_set
      tipc: fix uninit-value in tipc_nl_compat_name_table_dump
      tipc: fix uninit-value in tipc_nl_compat_doit

YunQiang Su (1):
      Disable MSI also when pcie-octeon.pcie_disable on

Yunlei He (2):
      f2fs: not allow to write illegal blkaddr
      f2fs: check blkaddr more accuratly before issue a bio

yupeng (1):
      net: call sk_dst_reset when set SO_DONTROUTE


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxMKIIACgkQONu9yGCS
aT7nyg/9E4VvtT3MdNUUzlBHLIqgsCww6o0DRPiceV18gIg950jOBCQAUEC/XeC6
k/Zlha9so0IvH3mwU2TsTQwrrajDicqgPiliKJQmDknbFQf/wcV8/Q74pfHpUp4i
NCv9qfjmnbEz4Vj/MsIlQ9kNA9qeQTqufAdst1beAw4cOBx5XSK/MyrloOhxbo02
EPuoMi3+gkO+0yBUV+8l4aLpjKVJuXeqxM3inn4VdOiiO7R9wNM19rj1q9jDs1RD
OeraPeZd6SY9CAKLdGdEdCTkKLbmPjkJsXuxIDtwYmfdIu4Cl5qIrIjmb1h2Ay2K
9P1yh2Zr6hLo3lLz5fHB7Vrh6mLXAGn0oyk+k4Jp7xdPIdNvvp1JYKjUvCsDVqgM
JAwd41QrX2QlbtYbwXGOfKT1AiCq8CnsRxmF+T1tMYrifLB3sAHSXFC8MFlpVbTm
CW/RjtiLOVnTWIZ4Y6PQ3P+Mxm6leavKPU95CvpvCQxwpjTufPhAWTjZT15JGrFs
pF3TmCn8ozrEp5k5Uoa15TpDvtZ6oNAIOdqjJhMbfg/lay/DmDSU5ln+0xLy+mV3
sjF/gUHs802qDLA7MJF1R8C4LHpXlt+119YGzj50pNVX6HyTmoLj5eAQdui3IeNu
rydxQ3mB3vbaIeqvq/LRzsN7sNE0nhdonb0NUeoEfuv6Z9EU5z4=
=R83J
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
