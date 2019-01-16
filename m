Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D49C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C7C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAPCMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:12:13 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52671 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727932AbfAPCMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:12:13 -0500
X-UUID: 0847b23daaf04f27bb10b4a7d27f9cd7-20190116
X-UUID: 0847b23daaf04f27bb10b4a7d27f9cd7-20190116
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1381476297; Wed, 16 Jan 2019 10:12:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 10:12:06 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 10:12:06 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/3] dt-bindings: mtd: mtk-quadspi: update bindings for MT7629 SoC
Date:   Wed, 16 Jan 2019 10:12:03 +0800
Message-ID: <74d710ed89fd505a49bce53b51f6cb489e313dbb.1547538621.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates bindings for the MT7629 SPI-NOR controller.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v2: none.
Changes since v1: add a Reviewed-by tag. 
---
 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
index 56d3668..a12e3b5 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MTK MT81xx (and similar)
+* Serial NOR flash controller for MediaTek SoCs
 
 Required properties:
 - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
@@ -10,6 +10,7 @@ Required properties:
 		  "mediatek,mt2712-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt7622-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt7623-nor", "mediatek,mt8173-nor"
+		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
 - reg: 		  physical base address and length of the controller's register
 - clocks: 	  the phandle of the clocks needed by the nor controller
-- 
1.9.1

