Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A024AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635A9275BD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635A9275BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967136AbeF1PUl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:20:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53358 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967065AbeF1PUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:20:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3845920DD7; Thu, 28 Jun 2018 17:20:05 +0200 (CEST)
Received: from localhost (nat.foo.tf [163.172.35.26])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0BFC4203EC;
        Thu, 28 Jun 2018 17:20:05 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: [PATCH 09/14] Documentation/bindings: crypto: inside-secure: eip197d support
Date:   Thu, 28 Jun 2018 17:15:39 +0200
Message-Id: <20180628151544.22134-10-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628151544.22134-1-antoine.tenart@bootlin.com>
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the new compatible used for the eip197d engine, as
this new engine is now supported by the Inside Secure SafeXcel
cryptographic driver.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 .../devicetree/bindings/crypto/inside-secure-safexcel.txt      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
index dc8678db52fa..3bbf144c9988 100644
--- a/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
+++ b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
@@ -1,7 +1,8 @@
 Inside Secure SafeXcel cryptographic engine
 
 Required properties:
-- compatible: Should be "inside-secure,safexcel-eip197b" or
+- compatible: Should be "inside-secure,safexcel-eip197b",
+	      "inside-secure,safexcel-eip197d" or
               "inside-secure,safexcel-eip97ies".
 - reg: Base physical address of the engine and length of memory mapped region.
 - interrupts: Interrupt numbers for the rings and engine.
-- 
2.17.1

