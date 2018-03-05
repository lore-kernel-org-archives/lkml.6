Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeCECvj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 21:51:39 -0500
Received: from gateway30.websitewelcome.com ([192.185.152.11]:31657 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752036AbeCECvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 21:51:36 -0500
From: Matheus Castello <matheus@castello.eng.br>
To: stefan.wahren@i2se.com, linus.walleij@linaro.org
Cc: eric@anholt.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 1/3] pinctrl: bcm2835: switch to GENERIC_PINCONF
Date: Sun,  4 Mar 2018 22:29:18 -0400
Message-Id: <1520216960-19880-2-git-send-email-matheus@castello.eng.br>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
References: <431699005.307231.1520086916739@email.1und1.de>
 <1520216960-19880-1-git-send-email-matheus@castello.eng.br>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1esfse-002WAq-8E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [191.189.21.134]:25193
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 22
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable support for generic binding in the pinctrl-bcm2835 and use pinctrl
generic to parse properties the GENERIC_PINCONF have to be selected.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/pinctrl/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/bcm/Kconfig b/drivers/pinctrl/bcm/Kconfig
index e8c4e4f..0f38d51 100644
--- a/drivers/pinctrl/bcm/Kconfig
+++ b/drivers/pinctrl/bcm/Kconfig
@@ -20,6 +20,7 @@ config PINCTRL_BCM2835
 	bool
 	select PINMUX
 	select PINCONF
+	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP

 config PINCTRL_IPROC_GPIO
--
2.7.4
