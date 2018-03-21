Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521638443-2-4432163409800681297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521638442; b=JT0mPfWBgUA0iNZc9jKMvN7iRTLC3IDt/Gm4PgXWr1BNWhB
    KCJjQEnXaat78zUzC9pXyMPGMlTWdvh0QwAuRwEn7a0hoeBs3kvWbQIQM9SmBZn1
    XQrT6NULN4xFfof2PUD4UkA6OV7Xf68IRDOgtLY322ddvSj9W1Kd8dGwGc/suIY/
    eIpLTydvKN3Cw0z7EzyLH8iFIbv8lfLdacwuuPwSl0qFaGLNkSPRX9MvuYzhQm9V
    JWuqFBiNjGfCaT/D4kdGCP2OJUprob63DJ11z6ojhQL9cBzzZgGa2iKOa+CzpYQP
    GndtbAJY41ivVrStOIq2g1V7bw4cWQ22gyp51hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521638442; bh=qXlYwschKl2+8NhZGyouKdIKRAw4abAMEIk+DmJQzI4=; b=W
    M1IRd5KMQnunmB6xugLSzjSRRLMwlgsr662hIgBBjZavEJFGlLKXhId83D2mWKNl
    QTEhLoAWmtljhOVS8+J1nUwR4zp/LHh/5ql0EITzrh/1kEm5tjAxhgGLmi5GBNSj
    Yi7wrQ6e8bUzbHs+Z6+NhtbceR7qyt4EN01pm0ZxBqI8xUvWPPu9261YwvOH5ELQ
    G6hWpk08JXiMV2XO/16okKyDPQHIkw0EXqDMGz9VVhBAkSBjolpY7umDWZuoeku8
    P3Pi1pPvhcWcrpRa8sZhdRPplmdbjzQiMIy5xGaEI5wBfs4g6LUras6tJf/ntgre
    iVJeHAnc2G7FZpZbrT09Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCUNUk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:20:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCUNUj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:20:39 -0400
Date: Wed, 21 Mar 2018 14:20:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.12
Message-ID: <20180321132037.GA27329@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.12 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/usb/dwc2.txt |    2=20
 Makefile                                       |    2=20
 arch/parisc/kernel/cache.c                     |   41 +++++++++--
 arch/x86/include/asm/cpufeatures.h             |    2=20
 arch/x86/include/asm/nospec-branch.h           |    5 +
 arch/x86/kernel/cpu/intel.c                    |    3=20
 arch/x86/kernel/vm86_32.c                      |    3=20
 arch/x86/kvm/mmu.c                             |    4 -
 arch/x86/mm/fault.c                            |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   31 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c        |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |    2=20
 drivers/gpu/drm/nouveau/nouveau_backlight.c    |    4 -
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c  |    2=20
 drivers/gpu/drm/radeon/radeon_gem.c            |    2=20
 drivers/gpu/drm/radeon/radeon_object.c         |    2=20
 drivers/infiniband/sw/rdmavt/mr.c              |   10 +-
 drivers/irqchip/irq-gic-v3-its.c               |    9 +-
 drivers/nvme/host/core.c                       |   18 ++++-
 drivers/phy/broadcom/phy-brcm-usb-init.c       |   22 ++----
 drivers/phy/broadcom/phy-brcm-usb.c            |    4 -
 drivers/scsi/qla2xxx/qla_init.c                |   13 ++-
 drivers/scsi/qla2xxx/qla_mid.c                 |    6 +
 drivers/scsi/qla2xxx/qla_os.c                  |   59 ++++++++++------
 drivers/scsi/qla2xxx/qla_target.c              |    1=20
 drivers/usb/dwc2/params.c                      |    6 -
 drivers/usb/dwc3/core.c                        |   36 ++++++----
 drivers/usb/dwc3/core.h                        |   16 ++--
 drivers/usb/dwc3/dwc3-of-simple.c              |    1=20
 drivers/usb/gadget/udc/bdc/bdc_pci.c           |    1=20
 drivers/usb/gadget/udc/renesas_usb3.c          |    2=20
 fs/aio.c                                       |   44 ++++++++----
 fs/btrfs/backref.c                             |   12 +++
 fs/btrfs/raid56.c                              |    1=20
 fs/btrfs/volumes.c                             |   30 ++++++--
 fs/btrfs/volumes.h                             |   12 +++
 fs/dcache.c                                    |   11 ++-
 fs/namei.c                                     |    5 -
 fs/nfs/super.c                                 |    2=20
 fs/xfs/xfs_icache.c                            |    2=20
 include/kvm/arm_vgic.h                         |    1=20
 include/linux/fs.h                             |    1=20
 include/linux/irqchip/arm-gic-v3.h             |    1=20
 include/linux/irqchip/arm-gic.h                |    1=20
 sound/core/oss/pcm_oss.c                       |   10 +-
 sound/core/seq/seq_clientmgr.c                 |    4 -
 sound/core/seq/seq_prioq.c                     |   28 ++++----
 sound/core/seq/seq_prioq.h                     |    6 -
 sound/core/seq/seq_queue.c                     |   28 ++------
 sound/pci/hda/hda_intel.c                      |    9 +-
 tools/testing/selftests/x86/entry_from_vm86.c  |   32 ++++++++-
 virt/kvm/arm/arch_timer.c                      |    6 +
 virt/kvm/arm/hyp/vgic-v3-sr.c                  |    3=20
 virt/kvm/arm/mmu.c                             |    6 -
 virt/kvm/arm/vgic/vgic-v2.c                    |   11 ++-
 virt/kvm/arm/vgic/vgic-v3.c                    |    9 ++
 virt/kvm/arm/vgic/vgic.c                       |   87 ++++++++++++++++++++=
-----
 virt/kvm/arm/vgic/vgic.h                       |    2=20
 58 files changed, 460 insertions(+), 221 deletions(-)

Al Cooper (4):
      phy: phy-brcm-usb: Fix two DT properties to match bindings doc
      phy: phy-brcm-usb-init: Some Low Speed keyboards fail on 7271
      phy: phy-brcm-usb-init: DRD mode can cause crash on startup
      phy: phy-brcm-usb-init: Power down USB 3.0 PHY when XHCI disabled

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control microcode=
 blacklist

Amelie Delaunay (2):
      usb: dwc2: fix STM32F7 USB OTG HS compatible
      dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding

Amir Goldstein (1):
      xfs: preserve i_rdev when recycling a reclaimable inode

Andy Lutomirski (3):
      selftests/x86/entry_from_vm86: Exit with 1 if we fail
      selftests/x86/entry_from_vm86: Add test cases for POPF
      x86/vm86/32: Fix POPF emulation

Andy Whitcroft (1):
      x86/speculation, objtool: Annotate indirect calls/jumps for objtool o=
n 32-bit kernels

Ard Biesheuvel (2):
      KVM: arm/arm64: Reduce verbosity of KVM init log
      irqchip/gic-v3-its: Ensure nr_ites >=3D nr_lpis

Bill Kuzeja (1):
      scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure

Christian K=C3=B6nig (2):
      drm/amdgpu: fix prime teardown order
      drm/radeon: fix prime teardown order

Christoffer Dall (1):
      KVM: arm/arm64: Reset mapped IRQs on VM reset

Dmitriy Gorokh (1):
      btrfs: Fix NULL pointer exception in find_bio_stripe

Edmund Nadolski (1):
      btrfs: add missing initialization in btrfs_check_shared

Enric Balletbo i Serra (1):
      usb: dwc3: of-simple: fix oops by unbalanced clk disable call

Eric W. Biederman (1):
      fs: Teach path_connected to handle nfs filesystems with multiple root=
s.

Greg Kroah-Hartman (1):
      Linux 4.15.12

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling

Himanshu Madhani (2):
      scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que
      scsi: qla2xxx: Fix logo flag for qlt_free_session_done()

Israel Rukshin (1):
      nvme: fix subsystem multiple controllers support check

John David Anglin (1):
      parisc: Handle case where flush_cache_range is called with no context

Kirill A. Shutemov (2):
      x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
      x86/cpufeatures: Add Intel PCONFIG cpufeature

Lukas Wunner (1):
      drm/nouveau/bl: Fix oops on driver unbind

Manu Gautam (1):
      usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode

Marc Zyngier (2):
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 =
on v3
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid

Michel D=C3=A4nzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

M=C4=81ris Narti=C5=A1s (1):
      drm/nouveau/mmu: ALIGN_DOWN correct variable

Nikolay Borisov (2):
      btrfs: Fix use-after-free when cleaning up fs_devs with a single stal=
e device
      btrfs: Fix memory barriers usage with device stats counters

Quinn Tran (1):
      scsi: qla2xxx: Fix NULL pointer access for fcport structure

Takashi Iwai (4):
      ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()
      ALSA: hda - Revert power_save option default value
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing

Tejun Heo (3):
      fs/aio: Add explicit RCU grace period when freeing kioctx
      fs/aio: Use RCU accessors for kioctx_table->table[]
      RDMAVT: Fix synchronization around percpu_ref

Thinh Nguyen (1):
      usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Tom Lendacky (1):
      KVM: x86: Fix device passthrough when SME is active

Toshi Kani (1):
      x86/mm: Fix vmalloc_fault to use pXd_large

Wei Yongjun (1):
      USB: gadget: udc: Add missing platform_device_put() on error in bdc_p=
ci_probe()

Yoshihiro Shimoda (1):
      usb: gadget: udc: renesas_usb3: fix oops in renesas_usb3_remove()

Zygo Blaxell (1):
      btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqyXCQACgkQONu9yGCS
aT797g//TvMjevdSvbcKPNywASKk+OTMnIYO6egSso/98G8jsg8NcCSIJNYDtdgZ
Izm5/K9qBVKFNhgYJVnXGU2igtWoXT0l/D4J8o0T4W4AwOFXQ3O00Hxq3YJSJFWS
kLYmQzsPu2hI89QnK6x5f0lJhyeMOUNI5wKh2P24G8TpYSgzVIGT1VeVc9SJ+N6j
VdQnlalbHOCp2ROKSm7H/lbct6DAviDfKcjuWSKTYLgguPABXnh0EPE+0/MYJ/LU
vZfo2wEx8sC17uVd0W9YQtrYOd6hri9EsYPF8Z7hW1qI9exNdLbpz1HGOSVTfgea
L31LH/O+jmXogvxG/0ZKmKtd5V8YM7QZnWpVyH3hPBhPP6Md8jZ8yxK06xARhsns
Bpa4xL+Hd6FAx75zghgt/P+VutHyUsCbBW/awjc2G7iADJiGrfvB5kHwUlAmKkcs
Z0AUG8wQM3govliCFKiPfbITNMnSL3wQVojhW4HSRzUKQs/dl5YgG/1nq9q8e+lG
8Qx3cON3qTQhHsf/7WccTI3Ull1bL9wmCrB46OQB70qDb6fSt+6mSBPX10FxJljS
knTc95WxhnlhK+2BHz1pmn9VNNa+A8wFr5ABKRNjSGZHm7+46avrvkTl5w9jDKEp
5apnpIzAbC+WFyXPXL+UXEzz06SJnO+6vbhxH4sds3wFmwvWKgo=
=AT0T
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
