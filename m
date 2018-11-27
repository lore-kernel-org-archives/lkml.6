Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505E208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2505E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbeK1IPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:15:45 -0500
Received: from relay64.bu.edu ([128.197.228.104]:55672 "EHLO relay64.bu.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbeK1IPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:15:45 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Nov 2018 03:15:45 EST
X-Envelope-From: ates@bu.edu
X-BU-AUTH: dhcp-wifi-8021x-155-41-65-75.bu.edu [155.41.65.75]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated bits=0)
        by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id wARL5MrF014822
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Nov 2018 16:05:27 -0500
From:   Emre Ates <ates@bu.edu>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, ates@bu.edu
Subject: [PATCH] Small typo fix
Date:   Tue, 27 Nov 2018 16:04:59 -0500
Message-Id: <20181127210459.11809-1-ates@bu.edu>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 mm/vmstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 9c624595e904..cc7d04928c2e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1106,7 +1106,7 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 					TEXT_FOR_HIGHMEM(xx) xx "_movable",

 const char * const vmstat_text[] = {
-	/* enum zone_stat_item countes */
+	/* enum zone_stat_item counters */
 	"nr_free_pages",
 	"nr_zone_inactive_anon",
 	"nr_zone_active_anon",
--
2.19.1

Signed-off-by: Emre Ates <ates@bu.edu>
