Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754293AbeDZIFp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:05:45 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:16171 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeDZIFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:05:24 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: net: meson-dwmac: new compatible name for AXG SoC
Date: Thu, 26 Apr 2018 16:05:07 +0000
Message-ID: <20180426160508.29380-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426160508.29380-1-yixun.lan@amlogic.com>
References: <20180426160508.29380-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to introduce a new compatible name for the Meson-AXG SoC
in order to support the RMII 100M ethernet PHY, since the PRG_ETH0
register of the dwmac glue layer is changed from previous old SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/net/meson-dwmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/meson-dwmac.txt b/Documentation/devicetree/bindings/net/meson-dwmac.txt
index 61cada22ae6c..1321bb194ed9 100644
--- a/Documentation/devicetree/bindings/net/meson-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/meson-dwmac.txt
@@ -11,6 +11,7 @@ Required properties on all platforms:
 			- "amlogic,meson8b-dwmac"
 			- "amlogic,meson8m2-dwmac"
 			- "amlogic,meson-gxbb-dwmac"
+			- "amlogic,meson-axg-dwmac"
 		Additionally "snps,dwmac" and any applicable more
 		detailed version number described in net/stmmac.txt
 		should be used.
-- 
2.17.0
