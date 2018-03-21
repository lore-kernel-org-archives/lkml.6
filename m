Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3996454-1521638470-2-11830410603501228373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521638469; b=LVC/EYsNzuXxDWbteUkfewlgBpEs9d2rcvjqBSXm6lsLZ+E
    mnHeXKLAZ+M9AHfvPs5VzCtJBvsE4SDpKbsniYDBZ5e0dAeOwsQ/VIisGbVtLfon
    Ag1XwXRySicG1/fMOruaBl5XdBmTrtjn4FuOrZoNFZ+xz3Qc37iCE5VTWCFf360i
    ITa04AQTDIopoiVzifQzubnj7bt7F2p6W6p/M2WyrkxI5L2zFJZqR7RTK/F/N66D
    v9kdv/BD91l/ryJ3kAuLVKrFZh0LAvEbgF7+LLOYLTBNPaCxi4kcpBLLOS78evhB
    406VpKc3LM8KmV8RlGMqnxLsGBHSEv/awNzD2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521638469; bh=2OkdcAQzYGhNx8TUvXEp+rCnWQohOewd+kXRTxigvPU=; b=w
    NEqjEYEg1bR29W6Vg4wNP/eAblNtjvK3qa0DYQFP2NOcZ2C8PK22Ob18ZeHmjbE7
    emKK9swcfoE6oAltzEN9uSBZ+XBBZCFAOt39uNPYGoqLC2CSq54CagOaYBGhYLZZ
    HYVc5B7fge73ez5ZZ4X6ntFt1ErNWEBOxXWaJkUPChauFKHQ0XStMDCv3wWJz6qc
    itmNaGFPPw5a4KzFj5RPKuOrvzCeoKJaS8eJYl1lMExKqb0q2ReY+nUol5CIx8UQ
    NJajjArIBPFZKnBMDPl09vS8Ck9qPKCLI0X3lpwDdmIxMZZM1PPMkZxpHs3h7A/9
    NYs9+Dk7/nSLGN/f5dxwg==
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
        id S1752029AbeCUNVG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 09:21:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCUNVB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 09:21:01 -0400
Date: Wed, 21 Mar 2018 14:20:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.29
Message-ID: <20180321132058.GA27415@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.29 kernel.

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

 Makefile                                       |    2=20
 arch/parisc/kernel/cache.c                     |   41 ++++++--
 arch/x86/include/asm/cpufeatures.h             |    2=20
 arch/x86/include/asm/nospec-branch.h           |    5 -
 arch/x86/kernel/cpu/intel.c                    |    3=20
 arch/x86/kernel/vm86_32.c                      |    3=20
 arch/x86/kvm/mmu.c                             |    4=20
 arch/x86/mm/fault.c                            |    6 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |   31 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c        |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |    2=20
 drivers/gpu/drm/nouveau/nouveau_backlight.c    |    4=20
 drivers/gpu/drm/radeon/radeon_gem.c            |    2=20
 drivers/gpu/drm/radeon/radeon_object.c         |    2=20
 drivers/infiniband/sw/rdmavt/mr.c              |   10 +-
 drivers/irqchip/irq-gic-v3-its.c               |    9 -
 drivers/scsi/qla2xxx/qla_init.c                |   13 +-
 drivers/scsi/qla2xxx/qla_mid.c                 |    6 -
 drivers/scsi/qla2xxx/qla_os.c                  |   59 +++++++-----
 drivers/scsi/qla2xxx/qla_target.c              |    1=20
 drivers/usb/dwc3/core.h                        |   16 +--
 drivers/usb/gadget/udc/bdc/bdc_pci.c           |    1=20
 fs/aio.c                                       |   44 ++++++---
 fs/btrfs/backref.c                             |   12 ++
 fs/btrfs/raid56.c                              |    1=20
 fs/btrfs/volumes.c                             |   30 ++++--
 fs/btrfs/volumes.h                             |   12 ++
 fs/dcache.c                                    |   11 +-
 fs/namei.c                                     |    5 -
 fs/nfs/super.c                                 |    2=20
 include/linux/fs.h                             |    1=20
 include/linux/irqchip/arm-gic-v3.h             |    1=20
 include/linux/irqchip/arm-gic.h                |    1=20
 sound/core/oss/pcm_oss.c                       |   10 +-
 sound/core/seq/seq_clientmgr.c                 |    4=20
 sound/core/seq/seq_prioq.c                     |   28 ++---
 sound/core/seq/seq_prioq.h                     |    6 -
 sound/core/seq/seq_queue.c                     |   28 +----
 sound/pci/hda/hda_intel.c                      |    9 +
 tools/testing/selftests/x86/entry_from_vm86.c  |  117 ++++++++++++++++++++=
++++-
 virt/kvm/arm/arch_timer.c                      |    2=20
 virt/kvm/arm/hyp/vgic-v3-sr.c                  |    3=20
 virt/kvm/arm/mmu.c                             |    6 -
 virt/kvm/arm/vgic/vgic-v2.c                    |   11 +-
 virt/kvm/arm/vgic/vgic-v3.c                    |    9 +
 virt/kvm/arm/vgic/vgic.c                       |   61 ++++++++++---
 virt/kvm/arm/vgic/vgic.h                       |    2=20
 47 files changed, 455 insertions(+), 185 deletions(-)

Al Viro (1):
      lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Alexander Sergeyev (1):
      x86/speculation: Remove Skylake C2 from Speculation Control microcode=
 blacklist

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

Christian K=F6nig (2):
      drm/amdgpu: fix prime teardown order
      drm/radeon: fix prime teardown order

Dmitriy Gorokh (1):
      btrfs: Fix NULL pointer exception in find_bio_stripe

Edmund Nadolski (1):
      btrfs: add missing initialization in btrfs_check_shared

Eric W. Biederman (1):
      fs: Teach path_connected to handle nfs filesystems with multiple root=
s.

Greg Kroah-Hartman (1):
      Linux 4.14.29

Hans van Kranenburg (1):
      btrfs: alloc_chunk: fix DUP stripe size handling

Himanshu Madhani (2):
      scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que
      scsi: qla2xxx: Fix logo flag for qlt_free_session_done()

John David Anglin (1):
      parisc: Handle case where flush_cache_range is called with no context

Kirill A. Shutemov (2):
      x86/cpufeatures: Add Intel Total Memory Encryption cpufeature
      x86/cpufeatures: Add Intel PCONFIG cpufeature

Lukas Wunner (1):
      drm/nouveau/bl: Fix oops on driver unbind

Marc Zyngier (2):
      kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 =
on v3
      KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid

Michel D=E4nzer (1):
      drm/amdgpu/dce: Don't turn off DP sink when disconnected

Nikolay Borisov (2):
      btrfs: Fix use-after-free when cleaning up fs_devs with a single stal=
e device
      btrfs: Fix memory barriers usage with device stats counters

Quinn Tran (1):
      scsi: qla2xxx: Fix NULL pointer access for fcport structure

Ricardo Neri (2):
      selftests/x86: Add tests for User-Mode Instruction Prevention
      selftests/x86: Add tests for the STR and SLDT instructions

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

Zygo Blaxell (1):
      btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlqyXDoACgkQONu9yGCS
aT5qqg/4rDpiUC9OPc4tHS/d1gMN0FpRWOAAGC7q7CiB3aVAEDzT45Yb+tvkcxGK
bR7BqdH5Tt/RIYph26XjtfdgRewWvj3D8JTOT9p/9yu/KsI3+cZUIWqtO8BoNih/
d+yQwPew5yYFsQQV9fX6aQFE3mebdxAJnhV9WgOV9HrloekxpkjL8FVBzta07mlx
Lq1ur2zSV9O6EH199wsKCxa7WyAzBQngLKqoD5HXzYIPv1rfDarsH//puV9gWV7o
aCudjX8f47Is0+tlZUFMy8NbDKnwoDWk1n8EycvVgb2Mox/phwEdciAv8FbupLQC
X03dQUGQM8iUOPD/SsdDs6+3AT6wfsKenhh2vXd1vC7O/g9Zw80pjAbCcxy7R5ZI
hue62I4Som94EnCxrU/wc8os8jPp8Oa8X+j+Sgk3F9R43kigzIxdkBnE3+Qkp5Dd
8GrUlH2SPOHcr/PgOEMoYVCkz+9Gi5nM1cHUEsPyQ9RdPci+kSqqt3jVaKkffXpD
B93p8sNGDMr/YLg4EgQ3+mN4hu9WgX4sBXG2oAElSfkAA7aKDCtSBIxID0j1NEf/
1nA15v2ioPq+DH8EhnjT6WS07MTj0FS8Bj1eA/g+EQuli0CVYeCrIhUrJ92HicqH
ohs38CT4Z9WshUAa9nhmBRoNe0oGz/AtVigPk4qmB4EX9cP8Hg==
=56Hb
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
