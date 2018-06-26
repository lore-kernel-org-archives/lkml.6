Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A865C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9227E26874
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9227E26874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755067AbeFZXyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:54:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:38513 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbeFZXyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:54:13 -0400
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5QNQ6qe022979;
        Tue, 26 Jun 2018 18:26:54 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/14] fsi: master-gpio: Remove unused definitions
Date:   Wed, 27 Jun 2018 09:25:58 +1000
Message-Id: <20180626232605.13420-8-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626232605.13420-1-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-master-gpio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index a00a85aa6d56..2bc85514bb0c 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -25,9 +25,6 @@
 #define	FSI_INIT_CLOCKS		5000	/* Clock out any old data */
 #define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
 #define	FSI_GPIO_EPOLL_CLOCKS	50      /* Number of clocks for E_POLL retry */
-#define	FSI_GPIO_STD_DELAY	10	/* Standard GPIO delay in nS */
-					/* todo: adjust down as low as */
-					/* possible or eliminate */
 #define FSI_CRC_ERR_RETRIES	10
 
 #define	FSI_GPIO_CMD_DPOLL      0x2
@@ -45,10 +42,7 @@
 
 #define	FSI_GPIO_MAX_BUSY	200
 #define	FSI_GPIO_MTOE_COUNT	1000
-#define	FSI_GPIO_DRAIN_BITS	20
 #define	FSI_GPIO_CRC_SIZE	4
-#define	FSI_GPIO_MSG_ID_SIZE		2
-#define	FSI_GPIO_MSG_RESPID_SIZE	2
 
 #define LAST_ADDR_INVALID		0x1
 
-- 
2.17.1

