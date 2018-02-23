Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeBWKTV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:19:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43407 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751608AbeBWKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:57 -0500
X-UUID: 1d07c31217a9432eaece71d46f38aef9-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 10/19] arm: dts: mt7623: remove useless property pinctrl-names at node switch@0
Date: Fri, 23 Feb 2018 18:16:30 +0800
Message-ID: <9c8c23657d9812e24c6f07b7477a6ac0ebdd1c68.1519378872.git.sean.wang@mediatek.com>
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

The property pinctrl-names is totally superfluous. It would be good to
remove the property to keep the node neatness. There is actually
unnecessary to set up any pins for data path TRGMII between main SoC and
MT7530. Furthermore, it's more reasonable for the pin setup of control
path MDIO bus is being placed inside the node of ethernet controller.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 6b760be..f2d3cfb 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -151,7 +151,6 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			pinctrl-names = "default";
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
-- 
2.7.4
