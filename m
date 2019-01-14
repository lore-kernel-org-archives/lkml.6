Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A3BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D072A206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 15:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfANPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 10:48:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49365 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 10:48:38 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gj4Ta-0003ZH-CZ; Mon, 14 Jan 2019 15:48:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: mcr20a: fix indentation, remove tabs
Date:   Mon, 14 Jan 2019 15:48:34 +0000
Message-Id: <20190114154834.18693-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The are a couple of statments that are one level too deep, fix this by
removing tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ieee802154/mcr20a.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 44de81e5f140..c589f5ae75bb 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -905,9 +905,9 @@ mcr20a_irq_clean_complete(void *context)
 		}
 		break;
 	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
-			/* rx is starting */
-			dev_dbg(printdev(lp), "RX is starting\n");
-			mcr20a_handle_rx(lp);
+		/* rx is starting */
+		dev_dbg(printdev(lp), "RX is starting\n");
+		mcr20a_handle_rx(lp);
 		break;
 	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
 		if (lp->is_tx) {
-- 
2.19.1

