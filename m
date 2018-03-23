Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeCWMb1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 08:31:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:10382 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752281AbeCWMbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 08:31:21 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: net: ave: add PXs3 support
Date: Fri, 23 Mar 2018 21:30:36 +0900
Message-Id: <1521808237-3623-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1521808237-3623-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for ethernet controller on UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
index 270ea4e..96398cc 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -9,6 +9,7 @@ Required properties:
 	- "socionext,uniphier-pxs2-ave4" : for PXs2 SoC
 	- "socionext,uniphier-ld11-ave4" : for LD11 SoC
 	- "socionext,uniphier-ld20-ave4" : for LD20 SoC
+	- "socionext,uniphier-pxs3-ave4" : for PXs3 SoC
  - reg: Address where registers are mapped and size of region.
  - interrupts: Should contain the MAC interrupt.
  - phy-mode: See ethernet.txt in the same directory. Allow to choose
-- 
2.7.4
