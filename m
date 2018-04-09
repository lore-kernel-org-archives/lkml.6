Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757971AbeDIC3y (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:29:54 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:41109
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754999AbeDIC3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:29:51 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CeAQBvw8pa/zXSMGcNTolLmA2UVx6Ec?=
 =?us-ascii?q?IJcNxUDAQEBAQEBAoZgVigNAoEUCAEBp29tghwaiCGCHoEJhEiELYEuDI0ZApd?=
 =?us-ascii?q?HBwGFVohZgTiDW4JKhGyRKzKBdDMaCCgIk12PGgEB?=
X-IPAS-Result: =?us-ascii?q?A2CeAQBvw8pa/zXSMGcNTolLmA2UVx6EcIJcNxUDAQEBAQE?=
 =?us-ascii?q?BAoZgVigNAoEUCAEBp29tghwaiCGCHoEJhEiELYEuDI0ZApdHBwGFVohZgTiDW?=
 =?us-ascii?q?4JKhGyRKzKBdDMaCCgIk12PGgEB?=
X-IronPort-AV: E=Sophos;i="5.48,426,1517846400";
   d="scan'208";a="63802825"
From: Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v4.17
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <f7e92f49-9ad9-ae33-2298-f55957d374fa@linux-m68k.org>
Date: Mon, 9 Apr 2018 11:17:05 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Can you please pull the m68knommu git tree, for-next branch.

Only a single fix to set the DMA masks in the ColdFire FEC platform
data structure. Stops the warning from dma-mapping.h coming out at
boot time.

Regards
Greg



The following changes since commit 3eb2ce825ea1ad89d20f7a3b5780df850e4be274:

  Linux 4.16-rc7 (2018-03-25 12:44:30 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

for you to fetch changes up to f61e64310b75733d782e930d1fb404b84699eed6:

  m68k: set dma and coherent masks for platform FEC ethernets (2018-03-28 22:27:09 +1000)

----------------------------------------------------------------
Greg Ungerer (1):
      m68k: set dma and coherent masks for platform FEC ethernets

 arch/m68k/coldfire/device.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
