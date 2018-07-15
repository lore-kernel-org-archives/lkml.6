Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FA7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E2A2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E2A2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeGOUqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:46:16 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:41982 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeGOUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:46:15 -0400
Received: from belgarion.home ([90.76.60.200])
        by mwinf5d60 with ME
        id B8My1y0044KClF6038N6kN; Sun, 15 Jul 2018 22:22:09 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 15 Jul 2018 22:22:09 +0200
X-ME-IP: 90.76.60.200
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: pxa: change serial node names
Date:   Sun, 15 Jul 2018 22:21:53 +0200
Message-Id: <20180715202153.7233-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change from xxuart to serial to normalize the devicetree pxa serial
support.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index f609dbb86abf..a5f9efdd2361 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -95,7 +95,7 @@
 			};
 		};
 
-		ffuart: uart@40100000 {
+		ffuart: serial@40100000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40100000 0x30>;
 			interrupts = <22>;
@@ -103,7 +103,7 @@
 			status = "disabled";
 		};
 
-		btuart: uart@40200000 {
+		btuart: serial@40200000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40200000 0x30>;
 			interrupts = <21>;
@@ -111,7 +111,7 @@
 			status = "disabled";
 		};
 
-		stuart: uart@40700000 {
+		stuart: serial@40700000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x40700000 0x30>;
 			interrupts = <20>;
@@ -119,7 +119,7 @@
 			status = "disabled";
 		};
 
-		hwuart: uart@41100000 {
+		hwuart: serial@41100000 {
 			compatible = "mrvl,pxa-uart";
 			reg = <0x41100000 0x30>;
 			interrupts = <7>;
-- 
2.11.0

