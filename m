Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF6C43143
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C8620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C8620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeIGFzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:55:17 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:36006
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbeIGFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:55:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2DeAABs0JFb/zXSMGcNThsBAQEBAwE?=
 =?us-ascii?q?BAQkBAQGEM4Eng3KVBwaKGo9FJoRRg384FAECAQEBAQEBAoEJhUcnFUEoDQI?=
 =?us-ascii?q?mAmwIAQGDHQGBdKQVb4EuGol6gQuJanmBB4E5hzKBBII0glcCiB+FXY11CAG?=
 =?us-ascii?q?GNolDHYFAhD2CagOFfZVUgXYzGggoCIMnCYsMhVBdinWCSwEB?=
X-IPAS-Result: =?us-ascii?q?A2DeAABs0JFb/zXSMGcNThsBAQEBAwEBAQkBAQGEM4Eng?=
 =?us-ascii?q?3KVBwaKGo9FJoRRg384FAECAQEBAQEBAoEJhUcnFUEoDQImAmwIAQGDHQGBd?=
 =?us-ascii?q?KQVb4EuGol6gQuJanmBB4E5hzKBBII0glcCiB+FXY11CAGGNolDHYFAhD2Ca?=
 =?us-ascii?q?gOFfZVUgXYzGggoCIMnCYsMhVBdinWCSwEB?=
X-IronPort-AV: E=Sophos;i="5.53,340,1531756800"; 
   d="scan'208";a="127419882"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 07 Sep 2018 09:16:58 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu fix for v4.19
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <fcd5e6a5-5de9-397d-eb31-c1706f7f2f46@linux-m68k.org>
Date:   Fri, 7 Sep 2018 11:16:56 +1000
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

Can you please pull the m68knommu git tree, for-linus branch.

A single change to fix booting on ColdFire platforms that have RAM
starting at a non-0 address.

Regards
Greg



The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

   Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-linus

for you to fetch changes up to c90bbce9eedd14f9428388d9442b5b3e98a2a6dd:

   m68k: fix early memory reservation for ColdFire MMU systems (2018-09-03 10:19:36 +1000)

----------------------------------------------------------------
Mike Rapoport (1):
       m68k: fix early memory reservation for ColdFire MMU systems

  arch/m68k/mm/mcfmmu.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
