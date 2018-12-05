Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795D1C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224A0208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039257;
	bh=FdUyiuBhh+2n0mzio6w5zbdhP0iMBjRoK2GjTPsXmeQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PasuoVvF3cvZ4Z3RLQ9+NsJS7kJFk8oySgfxTWnrWZh404ADJlwmHhNoS842KxeKA
	 O8CxMDtzWE/fjdc+2A2SS36WALuCFb2H41EXrU0dWXz5Dna6W/yCnjuExSWdqcOHMa
	 sEO56DCkbbgxxyyl4EiWQ4728ioePi0R6hCdBKs8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224A0208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeLETrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbeLETrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:47:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C463820892;
        Wed,  5 Dec 2018 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544039251;
        bh=FdUyiuBhh+2n0mzio6w5zbdhP0iMBjRoK2GjTPsXmeQ=;
        h=Date:From:To:Cc:Subject:From;
        b=AjdY4BH4gxNActoA3QOcbSqHa3tSnIc+Di8tFTMb7+Y2CXIcn91/RUzteM/urrAzG
         zzahf7rmyWy5lqsq6i/JoCui686bni64yL/NbjlW0jWdW+oa3iQEVk2o0Ai+3/Ia0D
         ozbx0ndZiYMCWykSxUMXw1gtJz33nF270P4s7Vqc=
Date:   Wed, 5 Dec 2018 20:47:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.86
Message-ID: <20181205194728.GA20623@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.86 kernel.

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

 Documentation/admin-guide/kernel-parameters.txt               |   56=20
 Documentation/userspace-api/spec_ctrl.rst                     |    9=20
 Makefile                                                      |    2=20
 arch/arm/boot/dts/rk3288-veyron.dtsi                          |    6=20
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts           |    2=20
 arch/x86/Kconfig                                              |   12=20
 arch/x86/Makefile                                             |    5=20
 arch/x86/events/core.c                                        |   20=20
 arch/x86/events/intel/core.c                                  |   52=20
 arch/x86/events/perf_event.h                                  |   13=20
 arch/x86/include/asm/cpufeatures.h                            |    2=20
 arch/x86/include/asm/msr-index.h                              |    5=20
 arch/x86/include/asm/nospec-branch.h                          |   44=20
 arch/x86/include/asm/spec-ctrl.h                              |   20=20
 arch/x86/include/asm/switch_to.h                              |    3=20
 arch/x86/include/asm/thread_info.h                            |   20=20
 arch/x86/include/asm/tlbflush.h                               |    8=20
 arch/x86/kernel/cpu/amd.c                                     |    4=20
 arch/x86/kernel/cpu/bugs.c                                    |  510 +++++=
+-
 arch/x86/kernel/cpu/common.c                                  |    9=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                          |   19=20
 arch/x86/kernel/fpu/signal.c                                  |    4=20
 arch/x86/kernel/process.c                                     |  101 +
 arch/x86/kernel/process.h                                     |   39=20
 arch/x86/kernel/process_32.c                                  |   10=20
 arch/x86/kernel/process_64.c                                  |   10=20
 arch/x86/kvm/cpuid.c                                          |   10=20
 arch/x86/kvm/mmu.c                                            |   27=20
 arch/x86/kvm/svm.c                                            |   28=20
 arch/x86/kvm/x86.c                                            |    4=20
 arch/x86/mm/tlb.c                                             |  115 +
 arch/xtensa/kernel/asm-offsets.c                              |   16=20
 arch/xtensa/kernel/process.c                                  |    5=20
 arch/xtensa/kernel/ptrace.c                                   |   42=20
 drivers/android/binder.c                                      |   21=20
 drivers/android/binder_alloc.c                                |   14=20
 drivers/android/binder_alloc.h                                |    3=20
 drivers/dma/at_hdmac.c                                        |   10=20
 drivers/hv/channel.c                                          |    8=20
 drivers/iio/magnetometer/st_magn_buffer.c                     |   12=20
 drivers/media/usb/em28xx/em28xx-dvb.c                         |    3=20
 drivers/misc/mic/scif/scif_rma.c                              |    2=20
 drivers/mtd/ubi/vtbl.c                                        |   20=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c              |    9=20
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c            |    4=20
 drivers/net/rionet.c                                          |    2=20
 drivers/net/usb/ipheth.c                                      |   10=20
 drivers/net/virtio_net.c                                      |   13=20
 drivers/net/wireless/ath/wil6210/wmi.c                        |    8=20
 drivers/net/wireless/ti/wlcore/cmd.c                          |    6=20
 drivers/pci/dwc/pci-layerscape.c                              |    2=20
 drivers/s390/net/qeth_core_main.c                             |   27=20
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c             |    2=20
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c |    7=20
 drivers/usb/core/quirks.c                                     |    3=20
 drivers/usb/dwc3/gadget.c                                     |    5=20
 drivers/usb/storage/unusual_realtek.h                         |   10=20
 fs/btrfs/Makefile                                             |    2=20
 fs/btrfs/disk-io.c                                            |  153 --
 fs/btrfs/extent-tree.c                                        |   86 +
 fs/btrfs/relocation.c                                         |    1=20
 fs/btrfs/super.c                                              |    1=20
 fs/btrfs/transaction.c                                        |    6=20
 fs/btrfs/tree-checker.c                                       |  649 +++++=
+++++
 fs/btrfs/tree-checker.h                                       |   38=20
 fs/btrfs/volumes.c                                            |   30=20
 fs/btrfs/volumes.h                                            |    2=20
 fs/ceph/mds_client.c                                          |   11=20
 fs/direct-io.c                                                |    4=20
 fs/ext2/xattr.c                                               |    2=20
 fs/f2fs/checkpoint.c                                          |   43=20
 fs/f2fs/data.c                                                |   52=20
 fs/f2fs/f2fs.h                                                |   41=20
 fs/f2fs/file.c                                                |   21=20
 fs/f2fs/inode.c                                               |   78 +
 fs/f2fs/node.c                                                |   11=20
 fs/f2fs/recovery.c                                            |    6=20
 fs/f2fs/segment.c                                             |   13=20
 fs/f2fs/segment.h                                             |   24=20
 fs/f2fs/super.c                                               |   96 +
 fs/xfs/libxfs/xfs_attr.c                                      |    9=20
 include/linux/bpf_verifier.h                                  |    1=20
 include/linux/ceph/auth.h                                     |    8=20
 include/linux/ceph/ceph_features.h                            |    7=20
 include/linux/ceph/messenger.h                                |    6=20
 include/linux/ceph/msgr.h                                     |    2=20
 include/linux/jump_label.h                                    |    7=20
 include/linux/ptrace.h                                        |    4=20
 include/linux/sched.h                                         |    9=20
 include/linux/sched/smt.h                                     |   20=20
 include/linux/skbuff.h                                        |   18=20
 include/net/tls.h                                             |    4=20
 include/uapi/linux/btrfs_tree.h                               |    1=20
 include/uapi/linux/prctl.h                                    |    1=20
 kernel/bpf/verifier.c                                         |   62=20
 kernel/cpu.c                                                  |   14=20
 kernel/jump_label.c                                           |   12=20
 kernel/sched/core.c                                           |   19=20
 kernel/sched/fair.c                                           |    4=20
 kernel/sched/sched.h                                          |    4=20
 lib/test_kmod.c                                               |    1=20
 mm/huge_memory.c                                              |   79 -
 mm/khugepaged.c                                               |  129 +
 mm/shmem.c                                                    |   12=20
 net/ceph/auth.c                                               |   16=20
 net/ceph/auth_x.c                                             |  223 ++-
 net/ceph/auth_x_protocol.h                                    |    7=20
 net/ceph/messenger.c                                          |   93 -
 net/ceph/osd_client.c                                         |   11=20
 net/core/skbuff.c                                             |    4=20
 net/packet/af_packet.c                                        |    4=20
 net/tls/tls_main.c                                            |  124 +
 net/tls/tls_sw.c                                              |   13=20
 scripts/Makefile.build                                        |    2=20
 sound/core/control.c                                          |   80 -
 sound/isa/wss/wss_lib.c                                       |    2=20
 sound/pci/ac97/ac97_codec.c                                   |    2=20
 sound/pci/hda/patch_realtek.c                                 |    9=20
 sound/sparc/cs4231.c                                          |    8=20
 119 files changed, 2926 insertions(+), 908 deletions(-)

Alexei Starovoitov (1):
      bpf: Prevent memory disambiguation attack

Anisse Astier (1):
      ALSA: hda/realtek - fix headset mic detection for MSI MS-B171

Arnd Bergmann (1):
      btrfs: tree-checker: use %zu format string for size_t

Ben Hutchings (1):
      f2fs: Add sanity_check_inode() function

Ben Wolsieffer (1):
      staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION

Bernd Eckstein (1):
      usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Boris Pismenny (1):
      tls: Use correct sk->sk_prot for IPV6

Borislav Petkov (1):
      x86/MCE/AMD: Fix the thresholding machinery initialization order

Chao Yu (9):
      f2fs: clean up with is_valid_blkaddr()
      f2fs: introduce and spread verify_blkaddr
      f2fs: fix to do sanity check with secs_per_zone
      f2fs: fix to do sanity check with extra_attr feature
      f2fs: fix to do sanity check with user_block_count
      f2fs: fix to do sanity check with node footer and iblocks
      f2fs: fix to do sanity check with block address in main area
      f2fs: fix to do sanity check with i_extra_isize
      f2fs: fix to do sanity check with cp_pack_start_sum

Christoph Muellner (1):
      arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Darrick J. Wong (1):
      xfs: don't fail when converting shortform attr to long form during AT=
TR_REPLACE

David Sterba (1):
      btrfs: tree-check: reduce stack consumption in check_dir_item

Dexuan Cui (1):
      Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpad=
l()

Felipe Balbi (1):
      Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Filipe Manana (1):
      Btrfs: ensure path name is null terminated at btrfs_control_ioctl

Greg Kroah-Hartman (1):
      Linux 4.14.86

Gu Jinxiang (1):
      btrfs: validate type when reading a chunk

Heiko Stuebner (1):
      ARM: dts: rockchip: Remove @0 from the veyron memory node

Hou Zhiqiang (1):
      PCI: layerscape: Fix wrong invocation of outbound window disable acce=
ssor

Hugh Dickins (9):
      mm/huge_memory: rename freeze_page() to unmap_page()
      mm/huge_memory: splitting set mapping+index before unfreeze
      mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()
      mm/khugepaged: collapse_shmem() stop if punched or truncated
      mm/khugepaged: fix crashes due to misaccounted holes
      mm/khugepaged: collapse_shmem() remember to clear holes
      mm/khugepaged: minor reorderings in collapse_shmem()
      mm/khugepaged: collapse_shmem() without freezing new_page
      mm/khugepaged: collapse_shmem() do not crash on Compound

Ilya Dryomov (8):
      libceph: store ceph_auth_handshake pointer in ceph_connection
      libceph: factor out __prepare_write_connect()
      libceph: factor out __ceph_x_decrypt()
      libceph: factor out encrypt_authorizer()
      libceph: add authorizer challenge
      libceph: implement CEPHX_V2 calculation mode
      libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()
      libceph: check authorizer reply/challenge length before reading

Ilya Lesokhin (4):
      tls: Add function to update the TLS socket configuration
      tls: Fix TLS ulp context leak, when TLS_TX setsockopt is not used.
      tls: Avoid copying crypto_info again after cipher_type check.
      tls: don't override sk_write_space if tls_set_sw_offload fails.

Jaegeuk Kim (3):
      f2fs: sanity check on sit entry
      f2fs: enhance sanity_check_raw_super() to avoid potential overflow
      f2fs: fix missing up_read

Jason Wang (2):
      virtio-net: disable guest csum during XDP set
      virtio-net: fail XDP set if guest csum is negotiated

Jim Mattson (1):
      kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Jiri Kosina (3):
      x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation
      x86/speculation: Apply IBPB more strictly to avoid cross-process data=
 leak
      x86/speculation: Propagate information about RSB filling mitigation t=
o sysfs

Jiri Olsa (2):
      perf/x86/intel: Move branch tracing setup to the Intel-specific sourc=
e file
      perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts=
()

Josef Bacik (1):
      btrfs: release metadata before running delayed refs

Julian Wiedmann (1):
      s390/qeth: fix length check in SNMP processing

Junaid Shahid (1):
      kvm: mmu: Fix race in emulated page table writes

Kai-Heng Feng (1):
      USB: usb-storage: Add new IDs to ums-realtek

Kailang Yang (1):
      ALSA: hda/realtek - Support ALC300

Konrad Rzeszutek Wilk (3):
      x86/bugs: Add AMD's variant of SSB_NO
      x86/bugs: Add AMD's SPEC_CTRL MSR usage
      x86/bugs: Switch the selection of mitigation from CPU vendor to CPU f=
eatures

Konstantin Khlebnikov (1):
      mm/huge_memory.c: reorder operations in __split_huge_page_tail()

Larry Finger (1):
      staging: rtl8723bs: Add missing return for cfg80211_rtw_get_station

Lior David (1):
      wil6210: missing length check in wmi_set_ie

Liran Alon (1):
      KVM: x86: Fix kernel info-leak in KVM_HC_CLOCK_PAIRING hypercall

Lorenzo Bianconi (2):
      net: thunderx: set xdp_prog to NULL if bpf_prog_add fails
      net: thunderx: set tso_hdrs pointer to NULL in nicvf_free_snd_queue

Luis Chamberlain (1):
      lib/test_kmod.c: fix rmmod double free

Martin Kelly (1):
      iio:st_magn: Fix enable device after trigger

Matthias Schwarzott (1):
      media: em28xx: Fix use-after-free when disconnecting

Max Filippov (3):
      xtensa: enable coprocessors that are being flushed
      xtensa: fix coprocessor context offset definitions
      xtensa: fix coprocessor part of ptrace_{get,set}xregs

Maximilian Heyne (1):
      fs: fix lost error code in dio_complete

Michael Niew=F6hner (1):
      usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream seri=
es

Pan Bian (3):
      rapidio/rionet: do not free skb before reading its length
      btrfs: relocation: set trans to be NULL after ending transaction
      ext2: fix potential use after free

Peter Zijlstra (1):
      sched/core: Fix cpu.max vs. cpuhotplug deadlock

Peter Zijlstra (Intel) (1):
      sched/smt: Make sched_smt_present track topology

Petr Machata (1):
      net: skb_scrub_packet(): Scrub offload_fwd_mark

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

Richard Genoud (2):
      dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
      dmaengine: at_hdmac: fix module unloading

Richard Weinberger (1):
      ubi: Initialize Fastmap checkmapping correctly

Sasha Levin (1):
      Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_=
timeout()"

Sebastian Andrzej Siewior (1):
      x86/fpu: Disable bottom halves while loading FPU registers

Shaokun Zhang (1):
      btrfs: tree-checker: Fix misleading group system information

Takashi Iwai (4):
      ALSA: wss: Fix invalid snd_free_pages() at error path
      ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write
      ALSA: control: Fix race between adding and removing a user element
      ALSA: sparc: Fix invalid snd_free_pages() at error path

Thomas Gleixner (21):
      x86/speculation: Rename SSBD update functions
      x86/Kconfig: Select SCHED_SMT if SMP enabled
      sched/smt: Expose sched_smt_present static key
      x86/speculation: Rework SMT state change
      x86/l1tf: Show actual SMT state
      x86/speculation: Reorder the spec_v2 code
      x86/speculation: Mark string arrays const correctly
      x86/speculataion: Mark command line parser data __initdata
      x86/speculation: Unify conditional spectre v2 print functions
      x86/speculation: Add command line control for indirect branch specula=
tion
      x86/process: Consolidate and simplify switch_to_xtra() code
      x86/speculation: Avoid __switch_to_xtra() calls
      x86/speculation: Prepare for conditional IBPB in switch_mm()
      ptrace: Remove unused ptrace_may_access_sched() and MODE_IBRS
      x86/speculation: Split out TIF update
      x86/speculation: Prevent stale SPEC_CTRL msr content
      x86/speculation: Prepare arch_smt_update() for PRCTL mode
      x86/speculation: Add prctl() control for indirect branch speculation
      x86/speculation: Enable prctl mode for spectre_v2_user
      x86/speculation: Add seccomp Spectre v2 user space protection mode
      x86/speculation: Provide IBPB always command line options

Tim Chen (7):
      x86/speculation: Update the TIF_SSBD comment
      x86/speculation: Clean up spectre_v2_parse_cmdline()
      x86/speculation: Remove unnecessary ret variable in cpu_show_common()
      x86/speculation: Move STIPB/IBPB string conditionals out of cpu_show_=
common()
      x86/speculation: Disable STIBP when enhanced IBRS is in use
      x86/speculation: Reorganize speculation control MSRs update
      x86/speculation: Prepare for per task indirect branch speculation con=
trol

Todd Kjos (1):
      binder: fix race that allows malicious free of live buffer

Tom Lendacky (2):
      x86/bugs: Update when to check for the LS_CFG SSBD mitigation
      x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR

Vakul Garg (1):
      net/tls: Fixed return value when tls_complete_pending_work() fails

Wanpeng Li (1):
      KVM: X86: Fix scan ioapic use-before-initialization

Willem de Bruijn (1):
      packet: copy user buffers before orphan or clone

Yu Zhao (1):
      mm: use swp_offset as key in shmem_replace_page()

YueHaibing (1):
      misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

Yunlei He (1):
      f2fs: check blkaddr more accuratly before issue a bio

Zhenzhong Duan (3):
      x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOS=
PEC variant
      x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
      x86/retpoline: Remove minimal retpoline support


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwIK1AACgkQONu9yGCS
aT7ByQ//RI50ChQnNsoxG828Ssugv2VOcLe+oNEajbkSTcgskIncIjnmIQAzvUK7
lqbMII/gF7KXZirv2D/I1h88AaOA0jYmQuLPAgoyK2ZwQs1yMAcN0AdlixFGBmOm
eYxfPnKJhSjjUPmskcbNDL6lF1/KAdeUu1p5mQIs8aUIaS2ztz+GES1quRfMEpDk
eL1MRKISve9e5BBd4rVJgurJXpyYCX1La9txd+kK5NsPG8LSHrgyDRO3g/hHnVMT
GNA4clJ9+mFGGIflOusCTIP/K+A/Q+dllDKXcPNTfARkpTAU082x3YvVqTtIA5eS
oQAi11n4sxscjZDzXyUnx8jZeNwjJQGyRrd7A0ZOfqknMMcz8AMoKyavSyC1h+Hg
s/ymCepCY412GE6KFmTBCpDQi+xYckbuJh806qM1ZJTRa3KDU/3L1b2YhAUHlkd7
oMrM2WyVxfCCFNI9YItckhzgDLwigjZuzHRzJQnp4TsrdXFep52czjq+dO7YYXH2
j11hj/S/NxPk1tfktWuDokcqOH0BMh0jbDnjOGdpI1An5dmV4I7u4QCsmjrC/JOm
X2lP4a2cBhI8xs1auYrZRxaEwWquyFTdFjjmnbwD4N3SGXKwqb54k/nJu10Vkm1a
mftjLZX3/OoMYbfOo2qkwO9JGPOHDGX5Fh3+xqJuKt941o1XWjg=
=1C8i
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
