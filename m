Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1152C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785522360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A785522360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeKMTik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:38:40 -0500
Received: from foss.arm.com ([217.140.101.70]:50282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbeKMTij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:38:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF1BA78;
        Tue, 13 Nov 2018 01:41:23 -0800 (PST)
Received: from sugar.kfn.arm.com (E110176.Arm.com [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28EA53F5CF;
        Tue, 13 Nov 2018 01:41:20 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yael Chemla <yael.chemla@foss.arm.com>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: crypto: ccree: add dt bindings for ccree 703
Date:   Tue, 13 Nov 2018 09:40:36 +0000
Message-Id: <1542102039-22256-3-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542102039-22256-1-git-send-email-gilad@benyossef.com>
References: <1542102039-22256-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings associating Arm TrustZone CryptoCell 703 with the
ccree driver.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
index 0ac06ec..6130e6e 100644
--- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
+++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
@@ -3,6 +3,7 @@ Arm TrustZone CryptoCell cryptographic engine
 Required properties:
 - compatible: Should be one of -
    "arm,cryptocell-713-ree"
+   "arm,cryptocell-703-ree"
    "arm,cryptocell-712-ree"
    "arm,cryptocell-710-ree"
    "arm,cryptocell-630p-ree"
-- 
2.7.4

