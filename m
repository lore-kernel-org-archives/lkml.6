Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B5C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCFA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCFA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeHMT4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:56:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:38961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbeHMT4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:56:37 -0400
Received: from ls3530.fritz.box ([92.116.162.22]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIzGn-1frBHe3usj-002Zkr; Mon, 13
 Aug 2018 19:13:24 +0200
Date:   Mon, 13 Aug 2018 19:13:19 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v4.19
Message-ID: <20180813171319.GA16531@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:6SLwahUSUulgy7kl6rKdIgBa5477TpF9AZ8xCpcVZeo2Bd5NydJ
 gfrZPim5S6oWi1/wGslyvEuYMvciHbTr60o5DcMXlP4wl0LhMKHjsLbeXCoLdu6flfxM0n1
 lVXfB+VskJ59+5Pv/vDQ0iYUd7y/qEr7Ouhuz8oKgdR4GfrKX25wWpBmndZXQL2Ctmt4Eq5
 Otdta1LBTUBqPe/dOpihw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Cn5srQvsU/U=:jRzj6Z8TJ+4cLlc4Mrhzy3
 oACwnfhAw11DAfcF1dW/tpLBlWRItTA80Hy8cqTMA2QIvcFoRw726NL5ZygXiFcmh/Vw9RKed
 4ZFH2SojAm++TAIMjqgmvDaDlfhsGu5jN5m6RSxktmOSKgnh8UDnG7pC89iXScfiywOTjT7lC
 NGmL6qPm22m+3Z4Wuf+FL8itK29vVM+v6eSVcd57/B9m19GJXhEURefKYf1AbHSqDNcqEszox
 YnoBrTtOpBAitav//PQvOrw7WyF4H2Cxiqk4ZiOMiDY987dJNi/iu4uy6Afg9WOjMEdNaJztD
 xx1OLISwQ9pzk62m34dQsP+7jK+aCudtqXz9BOTGb/OwwL3OipDB0H7Ur9KbISq33ryIvA17h
 LME69VyLbn8GjBPJHH6FHeJ2bAa4IDfbT3LIfDPuWJqCQBIBoSCxNTn/0GI7VXY9xRPkqZ4Ho
 Fnv8HfPhDu54PzuHd1mb2k3MrFQvofnwONkdCfVSYWcneYkgQhZrbp3Iarnh//AMon/qsLJ0W
 uWwuutA/wnlLjaMtciuozbbQHk5puoizobnuT+pcdaHNLnvlQVcikPZ0odDz2kJ7hkw8Tw84K
 rxE6jKWhlk1Oe8qqOaImUP2KdmLdvpFFNYx3fUxqIfk1lKrOXtCpF6RqUpb7yevq1683URKaX
 gyQru5PRNHI33fyeL4KdF8fp4cJV9ReAS27d9L6yFlgVOlFtUalmgvzngcUwf3F/zUtWGU5hB
 l7LkUZja6FsUS7pW2HmoAAMHzpa3Z+S4lRJNVctas3RfU98lNxbkXI8BaV4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull fixes and updates for the parisc architecture for kernel 4.19 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-1

Changes include:
- parisc now uses the generic dma_noncoherent_ops implementation, by Christoph Hellwig.
- further memory barrier and spinlock improvements, by John David Anglin.
- prepare removal of current_text_addr() functions, by Nick Desaulniers.
- improve kernel stack unwinding on parisc, by me.
- drop ENOTSUP which was defined on parisc only, by me.

Thanks,
Helge

----------------------------------------------------------------
Christoph Hellwig (3):
      parisc: merge pcx_dma_ops and pcxl_dma_ops
      parisc: always use flush_kernel_dcache_range for DMA cache maintainance
      parisc: use generic dma_noncoherent_ops

Helge Deller (3):
      parisc: Drop architecture-specific ENOTSUP define
      parisc: Add HAVE_REGS_AND_STACK_ACCESS_API feature
      parisc: Fix and improve kernel stack unwinding

John David Anglin (2):
      parisc: Remove ordered stores from syscall.S
      parisc: Remove unnecessary barriers from spinlock.h

Nick Desaulniers (1):
      parisc: prefer _THIS_IP_ and _RET_IP_ statement expressions

 arch/parisc/Kconfig                        |   5 +
 arch/parisc/include/asm/assembly.h         |   2 +
 arch/parisc/include/asm/dma-mapping.h      |   5 -
 arch/parisc/include/asm/linkage.h          |  17 ++-
 arch/parisc/include/asm/ptrace.h           |  11 ++
 arch/parisc/include/asm/spinlock.h         |   8 +-
 arch/parisc/include/asm/unwind.h           |   3 +
 arch/parisc/include/uapi/asm/errno.h       |   1 -
 arch/parisc/kernel/entry.S                 |  53 +++-----
 arch/parisc/kernel/pacache.S               | 125 ------------------
 arch/parisc/kernel/pci-dma.c               | 199 +++++------------------------
 arch/parisc/kernel/process.c               |   2 +-
 arch/parisc/kernel/ptrace.c                | 100 +++++++++++++++
 arch/parisc/kernel/real2.S                 |   6 -
 arch/parisc/kernel/setup.c                 |   8 +-
 arch/parisc/kernel/syscall.S               |  24 ++--
 arch/parisc/kernel/traps.c                 |   2 +-
 arch/parisc/kernel/unwind.c                |  93 ++++++++------
 arch/parisc/lib/lusercopy.S                |  21 ---
 arch/parisc/mm/init.c                      |  11 +-
 kernel/time/posix-timers.c                 |  13 +-
 tools/arch/parisc/include/uapi/asm/errno.h |   1 -
 22 files changed, 262 insertions(+), 448 deletions(-)
