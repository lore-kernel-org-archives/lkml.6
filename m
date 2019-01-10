Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BD3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD6B206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfAJGgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 01:36:00 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:45169 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfAJGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 01:35:59 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 10 Jan 2019 15:35:57 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: neidhard.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.178.32.48)
        by 156.147.1.126 with ESMTP; 10 Jan 2019 15:35:57 +0900
X-Original-SENDERIP: 10.178.32.48
X-Original-MAILFROM: neidhard.kim@lge.com
From:   Jongsung Kim <neidhard.kim@lge.com>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, Jongsung Kim <neidhard.kim@lge.com>
Subject: [PATCH] bindings: net: stmmac: correct names of AXI properties
Date:   Thu, 10 Jan 2019 15:35:24 +0900
Message-Id: <20190110063524.21169-1-neidhard.kim@lge.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
---
 Documentation/devicetree/bindings/net/stmmac.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
index cb694062afff..988e56781fbd 100644
--- a/Documentation/devicetree/bindings/net/stmmac.txt
+++ b/Documentation/devicetree/bindings/net/stmmac.txt
@@ -68,11 +68,11 @@ Optional properties:
 	- snps,xit_frm: unlock on WoL
 	- snps,wr_osr_lmt: max write outstanding req. limit
 	- snps,rd_osr_lmt: max read outstanding req. limit
-	- snps,kbbe: do not cross 1KiB boundary.
+	- snps,axi_kbbe: do not cross 1KiB boundary.
 	- snps,blen: this is a vector of supported burst length.
-	- snps,fb: fixed-burst
-	- snps,mb: mixed-burst
-	- snps,rb: rebuild INCRx Burst
+	- snps,axi_fb: fixed-burst
+	- snps,axi_mb: mixed-burst
+	- snps,axi_rb: rebuild INCRx Burst
 - mdio: with compatible = "snps,dwmac-mdio", create and register mdio bus.
 - Multiple RX Queues parameters: below the list of all the parameters to
 				 configure the multiple RX queues:
-- 
2.20.1

