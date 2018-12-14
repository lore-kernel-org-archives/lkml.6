Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EC5206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeLNRVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:21:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55578 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbeLNRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:21:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E47BEBD;
        Fri, 14 Dec 2018 09:21:21 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E7083F575;
        Fri, 14 Dec 2018 09:21:20 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:21:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.20
Message-ID: <20181214172115.GA46313@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3238c359acee4ab57f15abb5a82b8ab38a661ee7:

  arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing (2018-12-11 11:55:32 +0000)

----------------------------------------------------------------
- Invalidate the caches before clearing the DMA buffer via the
  non-cacheable alias in the FORCE_CONTIGUOUS case

----------------------------------------------------------------
Robin Murphy (1):
      arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

 arch/arm64/mm/dma-mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Catalin
