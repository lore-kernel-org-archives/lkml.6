Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeDYJgr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:36:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13791 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751271AbeDYJcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:32:55 -0400
X-UUID: f92e10b6a9384d149de1f18f6b749e8c-20180425
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <matthias.bgg@gmail.com>,
        <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 04/17] dt-bindings: mfd: mt6397: add a description for MT6323 power controller
Date: Wed, 25 Apr 2018 17:32:30 +0800
Message-ID: <317723e775d8de4aca70e17bf365db0c6b453666.1524646231.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a description for MT6323 power controller on MT6323 and link it to the
detailed binding documentation.

Cc: devicetree@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 11a748d..61115ea 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -8,6 +8,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 - Clock
 - LED
 - Keys
+- Power controller
 
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
@@ -48,6 +49,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
 	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 
+- power-controller
+	Required properties:
+		- compatible: "mediatek,mt6323-pwrc"
+	For details, see Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible = "mediatek,mt8135-pwrap";
-- 
2.7.4
