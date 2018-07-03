Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1AFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B2D24EB3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2D24EB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeGCBGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:06:41 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:14259
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752771AbeGCBGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:06:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BKAQBXyzpb/zXSMGcNTxwBAQEEAQEKA?=
 =?us-ascii?q?QGEK4Eng3mVDgEBAQEBAQaBCAiXQCaEUYNXOBQBAgEBAQEBAQKBCYVFJxVBKA0?=
 =?us-ascii?q?CJgJsCAEBgxwBgXKobG6CHBqIO4E6gQuIcIEHgTYMhx+BBII0glUCh2CFKYw9C?=
 =?us-ascii?q?AGGBokRgUaEDIJZhTCTX4FzMxoIKAiDJAmLC4VQXY45gkgBAQ?=
X-IPAS-Result: =?us-ascii?q?A2BKAQBXyzpb/zXSMGcNTxwBAQEEAQEKAQGEK4Eng3mVDgE?=
 =?us-ascii?q?BAQEBAQaBCAiXQCaEUYNXOBQBAgEBAQEBAQKBCYVFJxVBKA0CJgJsCAEBgxwBg?=
 =?us-ascii?q?XKobG6CHBqIO4E6gQuIcIEHgTYMhx+BBII0glUCh2CFKYw9CAGGBokRgUaEDIJ?=
 =?us-ascii?q?ZhTCTX4FzMxoIKAiDJAmLC4VQXY45gkgBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,301,1526313600"; 
   d="scan'208";a="138736206"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 03 Jul 2018 09:06:36 +0800
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu fixes for v4.18
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <c166ef5e-89a9-1078-6a82-53c506c26f6e@linux-m68k.org>
Date:   Tue, 3 Jul 2018 11:06:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
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

It contains a single fix, for breakage introduced in 4.18-rc1.

Regards
Greg




The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

   Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-linus

for you to fetch changes up to ecd60532e060e45c63c57ecf1c8549b1d656d34d:

   m68k: fix "bad page state" oops on ColdFire boot (2018-07-02 10:05:13 +1000)

----------------------------------------------------------------
Greg Ungerer (1):
       m68k: fix "bad page state" oops on ColdFire boot

  arch/m68k/include/asm/mcf_pgalloc.h | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
