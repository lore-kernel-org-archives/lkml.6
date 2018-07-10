Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BDEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7F920883
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7F920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933618AbeGJO11 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:27:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933280AbeGJO1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:27:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 718C0859AE;
        Tue, 10 Jul 2018 14:27:25 +0000 (UTC)
Received: from emilne.com (unknown [10.18.25.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51788111AF28;
        Tue, 10 Jul 2018 14:27:25 +0000 (UTC)
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] qed: fix spelling mistake "successffuly" -> "successfully"
Date:   Tue, 10 Jul 2018 10:27:24 -0400
Message-Id: <1531232844-23004-1-git-send-email-emilne@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 10 Jul 2018 14:27:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 10 Jul 2018 14:27:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'emilne@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ewan D. Milne" <emilne@redhat.com>

Trivial fix to spelling mistake in qed_probe message.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 0cbc74d..758a9a51 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -371,7 +371,7 @@ static struct qed_dev *qed_probe(struct pci_dev *pdev,
 		goto err2;
 	}
 
-	DP_INFO(cdev, "qed_probe completed successffuly\n");
+	DP_INFO(cdev, "qed_probe completed successfully\n");
 
 	return cdev;
 
-- 
2.1.0

