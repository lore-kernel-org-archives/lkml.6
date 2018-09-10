Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364D3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DB720865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DB720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIJQO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:14:29 -0400
Received: from shell.v3.sk ([90.176.6.54]:35636 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeIJQO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:14:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 72FDCB82BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:20:53 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PUBTvl1RQ-VJ; Mon, 10 Sep 2018 13:20:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9DBA9B82C0;
        Mon, 10 Sep 2018 13:20:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j4Rg-rXvfGwE; Mon, 10 Sep 2018 13:20:50 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2F434B82BC;
        Mon, 10 Sep 2018 13:20:50 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mac80211: a trivial open80211s web site URL fix
Date:   Mon, 10 Sep 2018 13:20:48 +0200
Message-Id: <20180910112048.40838-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <trivial@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 net/mac80211/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 76e30f4797fb..7dc77fc91891 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -79,7 +79,7 @@ config MAC80211_MESH
 	 The implementation is based on Draft 2.08 of the Mesh Networking
 	 amendment.  However, no compliance with that draft is claimed or even
 	 possible, as drafts leave a number of identifiers to be defined after
-	 ratification.  For more information visit http://o11s.org/.
+	 ratification.  For more information visit http://open80211s.org/.
 
 config MAC80211_LEDS
 	bool "Enable LED triggers"
-- 
2.17.1

