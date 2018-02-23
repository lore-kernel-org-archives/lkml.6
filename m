Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751715AbeBWKRC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:17:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:10528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751580AbeBWKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:54 -0500
X-UUID: c22f924c396141b79d15615efa92bd1e-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 04/19] dt-bindings: arm: mediatek: add support for more mt7623 reference boards
Date: Fri, 23 Feb 2018 18:16:24 +0800
Message-ID: <e77690ea7f7332e9e1ee64204a4e72c759c41aa9.1519378871.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update binding document for more mt7623[A,N] reference boards being
supported.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 91d5178..7d21ab3 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -50,6 +50,15 @@ Supported boards:
 - Reference board variant 1 for MT7622:
     Required root node properties:
       - compatible = "mediatek,mt7622-rfb1", "mediatek,mt7622";
+- Reference board for MT7623a with eMMC:
+    Required root node properties:
+      - compatible = "mediatek,mt7623a-rfb-emmc", "mediatek,mt7623";
+- Reference board for MT7623a with NAND:
+    Required root node properties:
+      - compatible = "mediatek,mt7623a-rfb-nand", "mediatek,mt7623";
+- Reference board for MT7623n with eMMC:
+    Required root node properties:
+      - compatible = "mediatek,mt7623n-rfb-emmc", "mediatek,mt7623";
 - Reference  board for MT7623n with NAND:
     Required root node properties:
       - compatible = "mediatek,mt7623n-rfb-nand", "mediatek,mt7623";
-- 
2.7.4
