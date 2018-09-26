Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE24C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9F420843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbeIZQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:44:52 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:57722 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIZQow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:44:52 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id gAYY1y00t3XaVaC06AYYz4; Wed, 26 Sep 2018 12:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g577Q-0006dR-G6; Wed, 26 Sep 2018 12:32:32 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g55Pe-0004y1-VG; Wed, 26 Sep 2018 10:43:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jiri Kosina <trivial@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] xen/balloon: Grammar s/Is it/It is/
Date:   Wed, 26 Sep 2018 10:43:13 +0200
Message-Id: <20180926084313.19052-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 90d387b50ab747f5..7f42d41f66ee98e3 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -86,7 +86,7 @@ config XEN_SCRUB_PAGES_DEFAULT
 	help
 	  Scrub pages before returning them to the system for reuse by
 	  other domains.  This makes sure that any confidential data
-	  is not accidentally visible to other domains.  Is it more
+	  is not accidentally visible to other domains.  It is more
 	  secure, but slightly less efficient. This can be controlled with
 	  xen_scrub_pages=0 parameter and
 	  /sys/devices/system/xen_memory/xen_memory0/scrub_pages.
-- 
2.17.1

