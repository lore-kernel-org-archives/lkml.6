Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314A4C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F4A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F4A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbeLKIFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:05:22 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38877 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeLKIFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:05:22 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43DXYX1134z1r2Rf;
        Tue, 11 Dec 2018 09:05:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43DXYW6vgMz1qrnD;
        Tue, 11 Dec 2018 09:05:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id xABLxzftpUdK; Tue, 11 Dec 2018 09:05:18 +0100 (CET)
X-Auth-Info: r7uLjtII2NG/e8XJbhZu1QMf2Ctx+CuSAK4CFdmJ/SQ=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 11 Dec 2018 09:05:18 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     manivannan.sadhasivam@linaro.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@cubietech.com, thomas.liau@actions-semi.com,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 1/4] dt-bindings: i2c: Add S700 support for Actions Semi Soc's
Date:   Tue, 11 Dec 2018 09:04:45 +0100
Message-Id: <20181211080448.24007-2-pn@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181211080448.24007-1-pn@denx.de>
References: <20181211080448.24007-1-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add s700 compatible string to Actions Semi SoC dt-bindings.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
 Documentation/devicetree/bindings/i2c/i2c-owl.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
index b743fe444e9f..54c05dbdb2e4 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
@@ -2,7 +2,9 @@ Actions Semiconductor Owl I2C controller
 
 Required properties:
 
-- compatible        : Should be "actions,s900-i2c".
+- compatible        : Should be one of the following:
+		      - "actions,s700-i2c" for S700 SoC
+		      - "actions,s900-i2c" for S900 SoC
 - reg               : Offset and length of the register set for the device.
 - #address-cells    : Should be 1.
 - #size-cells       : Should be 0.
-- 
2.17.2

