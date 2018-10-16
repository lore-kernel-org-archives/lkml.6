Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EA920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EA920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJPV0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:26:19 -0400
Received: from foss.arm.com ([217.140.101.70]:36436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeJPV0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:26:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677A01596;
        Tue, 16 Oct 2018 06:35:48 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C84A3F5D3;
        Tue, 16 Oct 2018 06:35:45 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] crypto: ccree: add dt bindings for ccree 713
Date:   Tue, 16 Oct 2018 14:35:32 +0100
Message-Id: <1539696935-4433-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
References: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings associating Arm TrustZone CryptoCell 713 with the
ccree driver.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
index 999fb2a..880de07 100644
--- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
+++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
@@ -1,8 +1,9 @@
 Arm TrustZone CryptoCell cryptographic engine
 
 Required properties:
-- compatible: Should be one of: "arm,cryptocell-712-ree",
-  "arm,cryptocell-710-ree" or "arm,cryptocell-630p-ree".
+- compatible: Should be one of: "arm,cryptocell-713-ree",
+  "arm,cryptocell-712-ree", "arm,cryptocell-710-ree" or
+  "arm,cryptocell-630p-ree".
 - reg: Base physical address of the engine and length of memory mapped region.
 - interrupts: Interrupt number for the device.
 
-- 
2.7.4

