Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B2C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30308217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeLPNdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:33:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39859 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeLPNdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:33:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gYWXk-000704-9W; Sun, 16 Dec 2018 13:33:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bonding: fix indentation issues, remove extra spaces
Date:   Sun, 16 Dec 2018 13:33:15 +0000
Message-Id: <20181216133315.5269-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two statements that are indented too much by one space each,
fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/bonding/bond_3ad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 93dfcef8afc4..7c46d9f4fefd 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1220,7 +1220,7 @@ static void ad_churn_machine(struct port *port)
 		port->sm_churn_partner_state = AD_CHURN_MONITOR;
 		port->sm_churn_actor_timer_counter =
 			__ad_timer_to_ticks(AD_ACTOR_CHURN_TIMER, 0);
-		 port->sm_churn_partner_timer_counter =
+		port->sm_churn_partner_timer_counter =
 			 __ad_timer_to_ticks(AD_PARTNER_CHURN_TIMER, 0);
 		return;
 	}
@@ -2128,7 +2128,7 @@ void bond_3ad_unbind_slave(struct slave *slave)
 				if ((new_aggregator->lag_ports == port) &&
 				    new_aggregator->is_active) {
 					netdev_info(bond->dev, "Removing an active aggregator\n");
-					 select_new_active_agg = 1;
+					select_new_active_agg = 1;
 				}
 
 				new_aggregator->is_individual = aggregator->is_individual;
-- 
2.19.1

