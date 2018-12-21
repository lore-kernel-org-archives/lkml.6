Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46EA21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbeLUM7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:59:08 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:24991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388154AbeLUM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:59:07 -0500
X-UUID: 2fd75f5eb17f479da78cdfbff685fa44-20181221
X-UUID: 2fd75f5eb17f479da78cdfbff685fa44-20181221
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 207524934; Fri, 21 Dec 2018 20:59:02 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Dec 2018 20:59:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 20:59:00 +0800
From:   qii wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <ryder.lee@mediatek.com>
Subject: [PATCH 1/6] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
Date:   Fri, 21 Dec 2018 20:58:26 +0800
Message-ID: <1545397111-24183-2-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2E9BCD794F771916ECDADFF385E8A151B40C745DC98EC84BEF11F9E66D477F412000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT7629 i2c binding to binding file.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index e199695..ee4c324 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -10,6 +10,7 @@ Required properties:
       "mediatek,mt6589-i2c": for MediaTek MT6589
       "mediatek,mt7622-i2c": for MediaTek MT7622
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
+      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
       "mediatek,mt8173-i2c": for MediaTek MT8173
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
-- 
1.7.9.5

