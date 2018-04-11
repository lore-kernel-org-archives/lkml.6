Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeDKFRL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 01:17:11 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.184]:22498 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbeDKFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 01:17:10 -0400
From: Matheus Castello <matheus@castello.eng.br>
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: wens@csie.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH] dt-bindings: pinctrl: sunxi: Fix reference to driver
Date: Wed, 11 Apr 2018 01:17:03 -0400
Message-Id: <1523423823-9115-1-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1f6885-002FaC-Fx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:21576
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 2
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings describe hardware, not drivers.
Use reference to hardware Allwinner A1X Pin Controller instead driver.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt         | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index ed5eb54..c854cf0 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -56,9 +56,9 @@ pins it needs, and how they should be configured, with regard to muxer
 configuration, drive strength and pullups. If one of these options is
 not set, its actual value will be unspecified.

-This driver supports the generic pin multiplexing and configuration
-bindings. For details on each properties, you can refer to
-./pinctrl-bindings.txt.
+Allwinner A1X Pin Controller supports the generic pin multiplexing and
+configuration bindings. For details on each properties, you can refer to
+ ./pinctrl-bindings.txt.

 Required sub-node properties:
   - pins
--
2.7.4
