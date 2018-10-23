Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A4C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD0F207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD0F207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeJWXY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:24:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:46519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeJWXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:24:28 -0400
Received: from ls3530.fritz.box ([92.116.150.172]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1gKAAl3KGL-00CNkl; Tue, 23
 Oct 2018 17:00:30 +0200
Received: from ls3530.fritz.box ([92.116.150.172]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M93Jp-1gKAAl3KGL-00CNkl; Tue, 23
 Oct 2018 17:00:30 +0200
Date:   Tue, 23 Oct 2018 17:00:26 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [GIT PULL] parisc architecture updates for kernel v4.20
Message-ID: <20181023150026.GA15165@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:mWp9nssy0REcduZHJI/SgkNRPUaDB7hrNFxZMxRhDo3rDvLlHuw
 BIYVy7W5Emze0PnHkBRhLKXAMrCq+MQh2FBfF/D363MC85hRXrBqmi/g0ZE8szBfBWECb2B
 qU32ZAn4sRYbYti0UTCbrsYMDIb3quuT1bk4HbFELsfA00M9WVTQOzUe6HMbQ2a8bo6NPAI
 m/3rgGZ4OBzsd8PAmIMDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gi+X7BqLZTI=:aBf7SPrlvRqDa5JS1e/tU9
 hRCsO1D+adVn10fYToHnjTY03o2q8ULSh/86CI69ZkgDbeOOs/oRnMUlr1ANhy8Chji6UJ7x7
 lQyFLUTtmNqFyHjjQFYmFH6i5QUV3otKZZrVMwndt8zrG54Yr8F0CAkHjCmghNiinx0Y5noC6
 BjsxTEp3fJiNde31j7W9ZpX1+0kt+WikOVSXpYGP+o+E9ao7GQbf2bqnqSSuyhPAondIyEAd2
 FciJfBbSZ1Rkd7AJTOwKYS3G+1lqS0uz0p0qbMDPiV1bGN91JQBdOsEX4ZTcY0qu7ucmSMJAt
 SiPqnmTVNuUFr4YnOwIU3j63pjdACmlazZcqrMAKW5GJsCtfqJZZ+ua4IpUOQ1e+CSdkaK2iv
 xoQogncEeCPZ0IUcrX1X3DzphhGrw5byKwNGHdSV7KtL6FhCtvYw4lcdoT5P8Rig7PoRzAZs9
 8aLbYtcoisLvJJUgOxjBWfMoT3OCtHMPwGammmaUaKtFreG3GaSkBj/zk+kPaifmKw9evQmx3
 MBXwnekFzY3Y8GqNRAr2rsLxh7ZMjJUlulSJq2ODLsC75pSIjqGW32PpbvKBk096wHbrCoYpg
 JwYRhBzmIKC6aoJG1oXPJKMJDHU9aZqTT87x6Pv0I8nC9cDM0PHCbJthy4jsdaQ/CkTsTBtTc
 RISlPV87scnO5DjogeV0ZwN31M8IbRdta2MGS+niKmSYuNeTHm+vN2h/J7Xh/uHuogWQ8eUU6
 4aAsbWC70b/OZVBULEEz0iK7DhWXHe5bJCOCJ/J/CbtjFfnWPlfAFuO8AW1ajslCbfK7G/wjz
 wOgZiviv9lgR3SgaKi/Ej+04cXt+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture patches and fixes for 4.20-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.20-1

Lots of small fixes and enhancements, most noteably:

- Many TLB and cache flush optimizations (Dave)
- Fixed HPMC/crash handler on 64-bit kernel (Dave and myself)
- Added alternative infrastructre. The kernel now live-patches itself
  for various situations, e.g. replace SMP code when running on one CPU
  only or drop cache flushes when system has no cache installed.
- vmlinuz now contains a full copy of the compressed vmlinux file. This
  simplifies debugging the currently booted kernel.
- Unused driver removal (Christoph)
- Reduced warnings of Dino PCI bridge when running in qemu
- Removed gcc version check (Masahiro)

Thanks,
Helge

----------------------------------------------------------------
Christoph Hellwig (1):
      parisc: remove the dead ccio-rm-dma driver

Helge Deller (14):
      parisc: Use PARISC_ITLB_TRAP constant in entry.S
      parisc: Add SYSTEM_INFO and REGISTER TOC PAT functions
      parisc: Clean up crash header output
      parisc: dino: Utilize DINO_MASK_IRQ() macro
      parisc: Ratelimit dino stuck interrupt warnings
      parisc: Fix map_pages() to not overwrite existing pte entries
      parisc: Fix exported address of os_hpmc handler
      extract-vmlinux: Check for uncompressed image as fallback
      parisc: Include compressed vmlinux file in vmlinuz boot kernel
      parisc: Add alternative coding infrastructure
      parisc: Use zdep for shlw macro on PA1.1 and PA2.0
      parisc: Drop two instructions from pte lookup code
      parisc: Add PDC PAT cell_info() and pd_get_pdc_revisions() functions
      parisc: Retrieve and display the PDC PAT capabilities

John David Anglin (7):
      parisc: Reorder TLB flush timing calculation
      parisc: Remove PTE load and fault check from L2_ptep macro
      parisc: Release spinlocks using ordered store
      parisc: Purge TLB entries after updating page table entry and set page accessed flag in TLB handler
      parisc: Fix address in HPMC IVA
      parisc: Remove pte_inserted define
      parisc: Optimze cache flush algorithms

Masahiro Yamada (1):
      parisc: remove check for minimum required GCC version

 arch/parisc/Makefile                      |   9 -
 arch/parisc/boot/compressed/Makefile      |   4 +-
 arch/parisc/boot/compressed/misc.c        |  95 ++++++++--
 arch/parisc/boot/compressed/vmlinux.lds.S |  10 +-
 arch/parisc/include/asm/alternative.h     |  47 +++++
 arch/parisc/include/asm/assembly.h        |   9 +-
 arch/parisc/include/asm/cache.h           |  22 ++-
 arch/parisc/include/asm/page.h            |  12 +-
 arch/parisc/include/asm/pdc.h             |   1 +
 arch/parisc/include/asm/pdcpat.h          |  62 +++++--
 arch/parisc/include/asm/pgtable.h         |  33 ++--
 arch/parisc/include/asm/sections.h        |   2 +
 arch/parisc/include/asm/spinlock.h        |   4 +-
 arch/parisc/include/asm/tlbflush.h        |   3 +-
 arch/parisc/kernel/cache.c                |  63 ++++---
 arch/parisc/kernel/entry.S                |  34 ++--
 arch/parisc/kernel/firmware.c             |  57 ++++++
 arch/parisc/kernel/hpmc.S                 |   3 +-
 arch/parisc/kernel/inventory.c            |  10 ++
 arch/parisc/kernel/pacache.S              | 280 ++++++++++++++++++++++++++----
 arch/parisc/kernel/setup.c                |  81 +++++++++
 arch/parisc/kernel/signal.c               |   1 -
 arch/parisc/kernel/syscall.S              |  12 +-
 arch/parisc/kernel/traps.c                |   7 +-
 arch/parisc/kernel/vmlinux.lds.S          |   6 +
 arch/parisc/mm/init.c                     |  23 ++-
 drivers/parisc/Makefile                   |   3 -
 drivers/parisc/ccio-dma.c                 |  12 +-
 drivers/parisc/ccio-rm-dma.c              | 202 ---------------------
 drivers/parisc/dino.c                     |   5 +-
 drivers/parisc/sba_iommu.c                |  17 +-
 scripts/extract-vmlinux                   |   6 +-
 32 files changed, 721 insertions(+), 414 deletions(-)
 create mode 100644 arch/parisc/include/asm/alternative.h
 delete mode 100644 drivers/parisc/ccio-rm-dma.c
