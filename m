Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABEC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C39D21738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39D21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeGDLuT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:50:19 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:52810 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933882AbeGDLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:50:16 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id 6bqE1y00R3XaVaC06bqEWC; Wed, 04 Jul 2018 13:50:14 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0005pj-CX; Wed, 04 Jul 2018 13:50:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0007Jf-AQ; Wed, 04 Jul 2018 13:50:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] net: ethernet: Miscellaneous Kconfig and Makefile cleanups
Date:   Wed,  4 Jul 2018 13:50:10 +0200
Message-Id: <20180704115013.28078-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains a few Kconfig and Makefile cleanups w.r.t.
Ethernet vendors.

Thanks!

Geert Uytterhoeven (3):
  net: ethernet: Make NET_VENDOR_AURORA default to yes
  net: ethernet: Add missing VENDOR to Cadence and Packet Engines
    symbols
  net: ethernet: sfc: Make subdir logic consistent with other vendors

 drivers/net/ethernet/Makefile              | 7 +++----
 drivers/net/ethernet/aurora/Kconfig        | 1 +
 drivers/net/ethernet/cadence/Kconfig       | 6 +++---
 drivers/net/ethernet/packetengines/Kconfig | 6 +++---
 drivers/net/ethernet/sfc/Makefile          | 2 ++
 5 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
