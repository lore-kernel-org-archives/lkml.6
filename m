Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1285C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3E2218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeL1IKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:10:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52125 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731904AbeL1IKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:10:20 -0500
X-UUID: c261aa3ff6044103a4da42b802cb5175-20181228
X-UUID: c261aa3ff6044103a4da42b802cb5175-20181228
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 387816687; Fri, 28 Dec 2018 16:10:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Dec 2018 16:09:59 +0800
Received: from mtkslt303.mediatek.inc (10.21.14.116) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Dec 2018 16:09:59 +0800
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>, <eddie.huang@mediatek.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v5 4/6] dt-bindings: serial: Add compatible for Mediatek MT8183
Date:   Fri, 28 Dec 2018 16:09:39 +0800
Message-ID: <1545984581-25843-5-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
References: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds dt-binding documentation of uart for Mediatek MT8183 SoC
Platform.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 742cb47..bcfb131 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -16,6 +16,7 @@ Required properties:
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
+  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
   * "mediatek,mt6577-uart" for MT6577 and all of the above
 
 - reg: The base address of the UART register bank.
-- 
1.9.1

