Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3553123-1521485687-2-4749656369675796756
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485686; b=lql/OZck6j6Q2LkdqB786AK6mLJC1MrTgvae9sfvf6bRGJF
    IFLIersQGzR1nlSckiZWIVnFCYU+FIO9WvMVGUu/hF4pTi36jvj6ZxC3sNRbjujS
    9KIdOBfhUJc2KeQECnFgNO2ioZWnlc/ydFXwl+rbArvTPOLAOzG+3D9H5AYHQ+Vp
    ltS7upfzsyCqlUsO4dKD2ZbdikmUNQtVPf/x3SALobIJ2T2w3/GrFlGFHteGcMXt
    cGcIUd94S2T3BYiPJyZkltATx1ZmLWd9wrhmrbrmh2dSNePsjDG59DnI4RbfDiPQ
    rk9iyawsk2S1BFkJ09er2lVUpAOdXJ7i7wUqEkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1521485686; bh=nbkLfO2q3aPXq3qq0l48cz+8BZ
    q7KG/xj9f50rKVX8o=; b=s7hUjiheaWULySZTMGNH/VebMuYu9/Dvl+2aK4NpRW
    oagHrhOP2pOILxZ/5xsIEQB3cz92BspDauVvslPAam4Ya7IlCY4L0/u6XfSO/HLJ
    BEL63MChjvy4c27t0DlvFLZCEIM4X33Ap2K/TuJRXLxst8pzzAqbWFQ/N4+jMATO
    juQyJA4WbrjPYbKHyztzTxjdw9GzfryrGoi4ADjzn0YK7pN+Od62Dmdf3Ze949rt
    RAObt3sXw0zBil2q5GiFwwz8TBqUg9ZBLWZDrqcN+pNAtsgtPhYEvS4DQ4g+76FZ
    cAVzdRzs0VVMLzT5gats+4dfiolSZBR+EvSLlXzqPjrA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleektdeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogggftgfgshhpjeesthekfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleektdeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935360AbeCSSaN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:30:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53094 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970158AbeCSSaJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:30:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/41] 4.14.29-stable review
Date: Mon, 19 Mar 2018 19:08:00 +0100
Message-Id: <20180319180732.195217948@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.29-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.29-rc1
X-KernelTest-Deadline: 2018-03-21T18:07+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.29 release.
There are 41 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Mar 21 18:07:09 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.29-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.29-rc1

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Wei Yongjun <weiyongjun1@huawei.com>
    USB: gadget: udc: Add missing platform_device_put() on error in bdc_pci_probe()

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix crashes in qla2x00_probe_one on probe failure

Himanshu Madhani <hmadhani@redhat.com>
    scsi: qla2xxx: Fix logo flag for qlt_free_session_done()

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix NULL pointer access for fcport structure

Himanshu Madhani <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix smatch warning in qla25xx_delete_{rsp|req}_que

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix memory barriers usage with device stats counters

Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
    btrfs: remove spurious WARN_ON(ref->count < 0) in find_parent_nodes

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device

Hans van Kranenburg <hans.van.kranenburg@mendix.com>
    btrfs: alloc_chunk: fix DUP stripe size handling

Edmund Nadolski <enadolski@suse.com>
    btrfs: add missing initialization in btrfs_check_shared

Dmitriy Gorokh <Dmitriy.Gorokh@wdc.com>
    btrfs: Fix NULL pointer exception in find_bio_stripe

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Tejun Heo <tj@kernel.org>
    RDMAVT: Fix synchronization around percpu_ref

Tejun Heo <tj@kernel.org>
    fs/aio: Use RCU accessors for kioctx_table->table[]

Tejun Heo <tj@kernel.org>
    fs/aio: Add explicit RCU grace period when freeing kioctx

Al Viro <viro@zeniv.linux.org.uk>
    lock_parent() needs to recheck if dentry got __dentry_kill'ed under it

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: vgic: Don't populate multiple LRs with the same vintid

Marc Zyngier <marc.zyngier@arm.com>
    kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    KVM: arm/arm64: Reduce verbosity of KVM init log

Eric W. Biederman <ebiederm@xmission.com>
    fs: Teach path_connected to handle nfs filesystems with multiple roots.

Michel Dänzer <michel.daenzer@amd.com>
    drm/amdgpu/dce: Don't turn off DP sink when disconnected

Christian König <christian.koenig@amd.com>
    drm/radeon: fix prime teardown order

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix prime teardown order

Lukas Wunner <lukas@wunner.de>
    drm/nouveau/bl: Fix oops on driver unbind

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Clear client entry before deleting else at closing

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix possible UAF in snd_seq_check_queue()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Revert power_save option default value

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Fix UAF in snd_pcm_oss_get_formats()

John David Anglin <dave.anglin@bell.net>
    parisc: Handle case where flush_cache_range is called with no context

Toshi Kani <toshi.kani@hpe.com>
    x86/mm: Fix vmalloc_fault to use pXd_large

Tom Lendacky <thomas.lendacky@amd.com>
    KVM: x86: Fix device passthrough when SME is active

Alexander Sergeyev <sergeev917@gmail.com>
    x86/speculation: Remove Skylake C2 from Speculation Control microcode blacklist

Andy Whitcroft <apw@canonical.com>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool on 32-bit kernels

Andy Lutomirski <luto@kernel.org>
    x86/vm86/32: Fix POPF emulation

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Add test cases for POPF

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for the STR and SLDT instructions

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    selftests/x86: Add tests for User-Mode Instruction Prevention

Andy Lutomirski <luto@kernel.org>
    selftests/x86/entry_from_vm86: Exit with 1 if we fail

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/cpufeatures: Add Intel PCONFIG cpufeature

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/cpufeatures: Add Intel Total Memory Encryption cpufeature


-------------

Diffstat:

 Makefile                                       |   4 +-
 arch/parisc/kernel/cache.c                     |  41 +++++++--
 arch/x86/include/asm/cpufeatures.h             |   2 +
 arch/x86/include/asm/nospec-branch.h           |   5 +-
 arch/x86/kernel/cpu/intel.c                    |   3 +-
 arch/x86/kernel/vm86_32.c                      |   3 +-
 arch/x86/kvm/mmu.c                             |   4 +-
 arch/x86/mm/fault.c                            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  31 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c        |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c     |   2 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c    |   4 +-
 drivers/gpu/drm/radeon/radeon_gem.c            |   2 -
 drivers/gpu/drm/radeon/radeon_object.c         |   2 +
 drivers/infiniband/sw/rdmavt/mr.c              |  10 ++-
 drivers/irqchip/irq-gic-v3-its.c               |   9 +-
 drivers/scsi/qla2xxx/qla_init.c                |  13 ++-
 drivers/scsi/qla2xxx/qla_mid.c                 |   6 +-
 drivers/scsi/qla2xxx/qla_os.c                  |  59 ++++++++-----
 drivers/scsi/qla2xxx/qla_target.c              |   1 +
 drivers/usb/dwc3/core.h                        |  16 ++--
 drivers/usb/gadget/udc/bdc/bdc_pci.c           |   1 +
 fs/aio.c                                       |  44 +++++++---
 fs/btrfs/backref.c                             |  12 ++-
 fs/btrfs/raid56.c                              |   1 +
 fs/btrfs/volumes.c                             |  30 +++++--
 fs/btrfs/volumes.h                             |  12 +++
 fs/dcache.c                                    |  11 ++-
 fs/namei.c                                     |   5 +-
 fs/nfs/super.c                                 |   2 +
 include/linux/fs.h                             |   1 +
 include/linux/irqchip/arm-gic-v3.h             |   1 +
 include/linux/irqchip/arm-gic.h                |   1 +
 sound/core/oss/pcm_oss.c                       |  10 ++-
 sound/core/seq/seq_clientmgr.c                 |   4 +-
 sound/core/seq/seq_prioq.c                     |  28 +++---
 sound/core/seq/seq_prioq.h                     |   6 +-
 sound/core/seq/seq_queue.c                     |  28 ++----
 sound/pci/hda/hda_intel.c                      |   9 +-
 tools/testing/selftests/x86/entry_from_vm86.c  | 117 ++++++++++++++++++++++++-
 virt/kvm/arm/arch_timer.c                      |   2 +-
 virt/kvm/arm/hyp/vgic-v3-sr.c                  |   3 +-
 virt/kvm/arm/mmu.c                             |   6 +-
 virt/kvm/arm/vgic/vgic-v2.c                    |  11 ++-
 virt/kvm/arm/vgic/vgic-v3.c                    |   9 +-
 virt/kvm/arm/vgic/vgic.c                       |  61 ++++++++++---
 virt/kvm/arm/vgic/vgic.h                       |   2 +
 47 files changed, 456 insertions(+), 186 deletions(-)
