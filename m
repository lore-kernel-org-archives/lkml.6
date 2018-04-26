Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757066AbeDZRfg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:35:36 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:35488 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756784AbeDZRfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:35:16 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0Jfyqs9nA==
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: galak@codeaurora.org, andy.shevchenko@gmail.com,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v4 1/7] gpio: pca953x: convert register constants to hex
Date: Thu, 26 Apr 2018 19:34:56 +0200
Message-Id: <ee6da590a6053f190393d5e64d06b44fab886ecd.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

which makes it easier to match them with the data sheets.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d02964983b5b..bd0593afdae3 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -25,25 +25,25 @@
 
 #include <asm/unaligned.h>
 
-#define PCA953X_INPUT		0
-#define PCA953X_OUTPUT		1
-#define PCA953X_INVERT		2
-#define PCA953X_DIRECTION	3
+#define PCA953X_INPUT		0x00
+#define PCA953X_OUTPUT		0x01
+#define PCA953X_INVERT		0x02
+#define PCA953X_DIRECTION	0x03
 
 #define REG_ADDR_AI		0x80
 
-#define PCA957X_IN		0
-#define PCA957X_INVRT		1
-#define PCA957X_BKEN		2
-#define PCA957X_PUPD		3
-#define PCA957X_CFG		4
-#define PCA957X_OUT		5
-#define PCA957X_MSK		6
-#define PCA957X_INTS		7
-
-#define PCAL953X_IN_LATCH	34
-#define PCAL953X_INT_MASK	37
-#define PCAL953X_INT_STAT	38
+#define PCA957X_IN		0x00
+#define PCA957X_INVRT		0x01
+#define PCA957X_BKEN		0x02
+#define PCA957X_PUPD		0x03
+#define PCA957X_CFG		0x04
+#define PCA957X_OUT		0x05
+#define PCA957X_MSK		0x06
+#define PCA957X_INTS		0x07
+
+#define PCAL953X_IN_LATCH	0x22
+#define PCAL953X_PULL_EN	0x23
+#define PCAL953X_PULL_SEL	0x24
 
 #define PCA_GPIO_MASK		0x00FF
 #define PCA_INT			0x0100
-- 
2.12.2
