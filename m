Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D60FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58977214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 21:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58977214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJIE0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:26:18 -0400
Received: from mleia.com ([178.79.152.223]:35560 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbeJIEZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:25:56 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 8EF2341E2C8;
        Mon,  8 Oct 2018 22:12:14 +0100 (BST)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] MAINTAINERS: add entry for TI DS90Ux9xx FPD-Link III drivers
Date:   Tue,  9 Oct 2018 00:12:05 +0300
Message-Id: <20181008211205.2900-8-vz@mleia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008211205.2900-1-vz@mleia.com>
References: <20181008211205.2900-1-vz@mleia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181008_221214_607095_C4CB41BB 
X-CRM114-Status: UNSURE (   9.03  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record TI DS90Ux9xx series of serializer and deserializer ICs
and IC subcontrollers as maintained.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 29c08106bd22..3952035b6b71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14762,6 +14762,16 @@ S:	Maintained
 F:	drivers/media/platform/davinci/
 F:	include/media/davinci/
 
+TI DS90UX9XX FPD-LINK III SERDES DRIVERS
+M:	Vladimir Zapolskiy <vz@mleia.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	drivers/mfd/ds90ux9xx-core.c
+F:	drivers/mfd/ds90ux9xx-i2c-bridge.c
+F:	drivers/pinctrl/pinctrl-ds90ux9xx.c
+F:	include/linux/mfd/ds90ux9xx.h
+N:	ds90u[bhx]9*
+
 TI ETHERNET SWITCH DRIVER (CPSW)
 R:	Grygorii Strashko <grygorii.strashko@ti.com>
 L:	linux-omap@vger.kernel.org
-- 
2.17.1

