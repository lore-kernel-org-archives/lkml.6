Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81BC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB7321479
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB7321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeKTTJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:09:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:1887 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725899AbeKTTJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:09:22 -0500
X-UUID: e9b41163dc85464896f2324195fe21ba-20181120
X-UUID: e9b41163dc85464896f2324195fe21ba-20181120
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1561419167; Tue, 20 Nov 2018 16:41:19 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 20 Nov 2018 16:41:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 20 Nov 2018 16:41:19 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <ryder.lee@mediatek.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT7629 soc platform
Date:   Tue, 20 Nov 2018 16:41:07 +0800
Message-ID: <1542703268-17285-2-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
References: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for the MT7629 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 7940940..6cc4e87 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -6,6 +6,7 @@ Required properties:
     - mediatek,mt2712-spi: for mt2712 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
     - mediatek,mt7622-spi: for mt7622 platforms
+    - mediatek,mt7629-spi: for mt7629 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
-- 
1.7.9.5

