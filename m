Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B25C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DCF20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DCF20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeIJQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:14:15 -0400
Received: from shell.v3.sk ([90.176.6.54]:35597 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbeIJQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:14:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D3308B82BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 13:20:38 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nWuhPvSmGcSa; Mon, 10 Sep 2018 13:20:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 60A0FB82BA;
        Mon, 10 Sep 2018 13:20:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id otJfbKnbxAID; Mon, 10 Sep 2018 13:20:36 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id CDE2CB82B7;
        Mon, 10 Sep 2018 13:20:35 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] dt-bindings: mrvl,intc: fix a trivial typo
Date:   Mon, 10 Sep 2018 13:20:33 +0200
Message-Id: <20180910112033.40465-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/whold/whole/.

Jiri Kosina <trivial@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../devicetree/bindings/interrupt-controller/mrvl,intc.txt      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
index 8b53273cb22f..608fee15a4cf 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
@@ -5,7 +5,7 @@ Required properties:
   "mrvl,mmp2-mux-intc"
 - reg : Address and length of the register set of the interrupt controller.
   If the interrupt controller is intc, address and length means the range
-  of the whold interrupt controller. If the interrupt controller is mux-intc,
+  of the whole interrupt controller. If the interrupt controller is mux-intc,
   address and length means one register. Since address of mux-intc is in the
   range of intc. mux-intc is secondary interrupt controller.
 - reg-names : Name of the register set of the interrupt controller. It's
-- 
2.17.1

