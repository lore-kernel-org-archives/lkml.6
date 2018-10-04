Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946BAC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404FC20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbeJDTEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:04:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJDTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:04:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g82TO-00055t-Ml; Thu, 04 Oct 2018 12:11:18 +0000
From:   Colin King <colin.king@canonical.com>
To:     Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][liquidio-next] liquidio: fix a couple of spelling mistakes
Date:   Thu,  4 Oct 2018 13:11:18 +0100
Message-Id: <20181004121118.18014-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistakes in dev_dbg warning messages

"Reloade" -> "Reload"
"chang" -> "change"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/cavium/liquidio/lio_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index eb96b0613cf6..825a28e5b544 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -1732,7 +1732,7 @@ int liquidio_set_fec(struct lio *lio, int on_off)
 	if (oct->props[lio->ifidx].fec !=
 	    oct->props[lio->ifidx].fec_boot) {
 		dev_dbg(&oct->pci_dev->dev,
-			"Reloade driver to chang fec to %s\n",
+			"Reload driver to change fec to %s\n",
 			oct->props[lio->ifidx].fec ? "on" : "off");
 	}
 
@@ -1796,7 +1796,7 @@ int liquidio_get_fec(struct lio *lio)
 	if (oct->props[lio->ifidx].fec !=
 	    oct->props[lio->ifidx].fec_boot) {
 		dev_dbg(&oct->pci_dev->dev,
-			"Reloade driver to chang fec to %s\n",
+			"Reload driver to change fec to %s\n",
 			oct->props[lio->ifidx].fec ? "on" : "off");
 	}
 
-- 
2.17.1

