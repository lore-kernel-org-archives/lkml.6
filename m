Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0065EC04ABF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B653A20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B653A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeIJQOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:14:25 -0400
Received: from shell.v3.sk ([90.176.6.54]:35627 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbeIJQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:14:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 53A45B82BF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:20:49 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sJS0hBTkvgMB; Mon, 10 Sep 2018 13:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 30A7AB82B7;
        Mon, 10 Sep 2018 13:20:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t-lnwGxxl8QW; Mon, 10 Sep 2018 13:20:46 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B8C6EB82BF;
        Mon, 10 Sep 2018 13:20:46 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: marvell,mmp2: fix a typo in bindings doc
Date:   Mon, 10 Sep 2018 13:20:45 +0200
Message-Id: <20180910112045.40736-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial one, but it's annoying that copy & paste of the link
doesn't work.

Jiri Kosina <trivial@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/clock/marvell,mmp2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
index af376a01f2b7..b0447d9896bc 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2.txt
@@ -18,4 +18,4 @@ Required Properties:
 Each clock is assigned an identifier and client nodes use this identifier
 to specify the clock which they consume.
 
-All these identifier could be found in <dt-bindings/clock/marvell-mmp2.h>.
+All these identifier could be found in <dt-bindings/clock/marvell,mmp2.h>.
-- 
2.17.1

