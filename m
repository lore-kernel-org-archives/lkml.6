Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeBWKV1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:21:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751568AbeBWKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:53 -0500
X-UUID: 3de189ceb2d94d50b0fc76e56de5be50-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v1 01/19] dt-bindings: pinctrl: mediatek: use - instead of _ in examples
Date: Fri, 23 Feb 2018 18:16:21 +0800
Message-ID: <44956252092b19ece67c5a0df1492a5baeaa4dab.1519378871.git.sean.wang@mediatek.com>
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

It should be good that no use "_" is in examples. Consequently,
those nodes in certain files which have an inappropriate name containing
"_" are all being replaced with "-".

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
index afa8a18..e7d6f81 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
@@ -76,12 +76,12 @@ Examples:
 
 ...
 {
-	syscfg_pctl_a: syscfg_pctl_a@10005000 {
+	syscfg_pctl_a: syscfg-pctl-a@10005000 {
 		compatible = "mediatek,mt8135-pctl-a-syscfg", "syscon";
 		reg = <0 0x10005000 0 0x1000>;
 	};
 
-	syscfg_pctl_b: syscfg_pctl_b@1020c020 {
+	syscfg_pctl_b: syscfg-pctl-b@1020c020 {
 		compatible = "mediatek,mt8135-pctl-b-syscfg", "syscon";
 		reg = <0 0x1020C020 0 0x1000>;
 	};
-- 
2.7.4
