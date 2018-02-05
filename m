Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeBEIMP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:12:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46655 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeBEIMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:12:00 -0500
X-UUID: 59cd3242152246d7b55c600707fd316a-20180205
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <rui.zhang@intel.com>, <edubezval@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Shunli Wang <shunli.wang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: thermal: add binding for MT7622 SoC
Date: Mon, 5 Feb 2018 16:11:51 +0800
Message-ID: <0b7dabc3b2c7ed93b88ec0923c2cce2f84fba5b1.1517817887.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add devicetree bindings for MediaTek MT7622 thermal controller

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
index 0d73ea5..41d6a44 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -12,6 +12,7 @@ Required properties:
   - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
   - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
   - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
+  - "mediatek,mt7622-thermal" : For MT7622 SoC
 - reg: Address range of the thermal controller
 - interrupts: IRQ for the thermal controller
 - clocks, clock-names: Clocks needed for the thermal controller. required
-- 
2.7.4
