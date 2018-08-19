Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9DFC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC82C20BED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 22:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC82C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeHTCMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 22:12:31 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:57196
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbeHTCMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 22:12:30 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Aug 2018 22:12:30 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DUAQCJ83lb/6+vqnwNThwBAQEEAQE?=
 =?us-ascii?q?KAQGEMoEng3CUcAEBAQEBAQaBCAiJAY07gXomhFGDaTYWAQIBAQEBAQECgQm?=
 =?us-ascii?q?FRicVQTUCJgJsCAEBgx4BgXSjc2+BLopYgQuIJHmBB4E5DIgqgjSCVwKICYU?=
 =?us-ascii?q?+jTUIAYYpiTEbgT6EL4hLlHAHgXwzGggoCIMkCYsMhVBdjkgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2DUAQCJ83lb/6+vqnwNThwBAQEEAQEKAQGEMoEng3CUc?=
 =?us-ascii?q?AEBAQEBAQaBCAiJAY07gXomhFGDaTYWAQIBAQEBAQECgQmFRicVQTUCJgJsC?=
 =?us-ascii?q?AEBgx4BgXSjc2+BLopYgQuIJHmBB4E5DIgqgjSCVwKICYU+jTUIAYYpiTEbg?=
 =?us-ascii?q?T6EL4hLlHAHgXwzGggoCIMkCYsMhVBdjkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.53,262,1531756800"; 
   d="scan'208";a="122830334"
Received: from 124-170-175-175.dyn.iinet.net.au (HELO [192.168.0.106]) ([124.170.175.175])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 20 Aug 2018 06:50:03 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu fixes for v4.19
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <cb438b4c-2539-b49b-6a4d-c43b734d8d90@linux-m68k.org>
Date:   Mon, 20 Aug 2018 08:50:02 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only two changes. One cleans up warnings in the ColdFire DMA code,
the other stubs out (with warnings) ColdFire clock api functions not
normally used.

Regards
Greg



The following changes since commit acb1872577b346bd15ab3a3f8dff780d6cca4b70:

   Linux 4.18-rc7 (2018-07-29 14:44:52 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to 58064e1f46b174e108c11323c2b1011064fd3efe:

   m68knommu: Fix typos in Coldfire 5272 DMA debug code (2018-07-30 09:15:01 +1000)

----------------------------------------------------------------
Geert Uytterhoeven (2):
       m68k: coldfire: Normalize clk API
       m68knommu: Fix typos in Coldfire 5272 DMA debug code

  arch/m68k/coldfire/clk.c    | 29 +++++++++++++++++++++++++++++
  arch/m68k/include/asm/dma.h |  4 ++--
  2 files changed, 31 insertions(+), 2 deletions(-)
