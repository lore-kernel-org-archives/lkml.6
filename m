Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE86C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5823520865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0Fxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:53:55 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:42496 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeK0Fxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:53:53 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433bmV09z9z1r352;
        Mon, 26 Nov 2018 19:58:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433bmL73zGz1qtfJ;
        Mon, 26 Nov 2018 19:58:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Q-wPtYIouYex; Mon, 26 Nov 2018 19:58:41 +0100 (CET)
X-Auth-Info: lzrH6chVuQe5QvTlRKb4/F8RZPayxIDpeF0cf218tFQ=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 19:58:41 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2 1/4] dt-bindings: i2c: Add S700 support for Actions Semi Soc's
Date:   Mon, 26 Nov 2018 19:58:18 +0100
Message-Id: <20181126185821.2480449-2-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181126185821.2480449-1-pn@denx.de>
References: <20181126185821.2480449-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add s700 compatible string to Actions Semi SoC dt-bindings.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 Documentation/devicetree/bindings/i2c/i2c-owl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
index b743fe444e9f..dfa1197e0dbf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -2,7 +2,7 @@ Actions Semiconductor Owl I2C controller
 
 Required properties:
 
-- compatible        : Should be "actions,s900-i2c".
+- compatible        : Should be "actions,s700-i2c" or "actions,s900-i2c".
 - reg               : Offset and length of the register set for the device.
 - #address-cells    : Should be 1.
 - #size-cells       : Should be 0.
-- 
2.17.2

