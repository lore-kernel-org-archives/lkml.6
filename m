Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeDZRfj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:35:39 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:26060 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756798AbeDZRfQ (ORCPT
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
Subject: [PATCH v4 3/7] gpio: pca953x: add more register definitions for pcal6524
Date: Thu, 26 Apr 2018 19:34:58 +0200
Message-Id: <3898304b792205255cf5859954c9953da9a8dffc.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcal6524 has another set of registers to fine control
the interrupt handling.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpio-pca953x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index fecd0e0aba93..2b667166e855 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -49,6 +49,12 @@
 #define PCAL953X_INT_STAT	0x26
 #define PCAL953X_OUT_CONF	0x27
 
+#define PCAL6524_INT_EDGE	0x28
+#define PCAL6524_INT_CLR	0x2a
+#define PCAL6524_IN_STATUS	0x2b
+#define PCAL6524_OUT_INDCONF	0x2c
+#define PCAL6524_DEBOUNCE	0x2d
+
 #define PCA_GPIO_MASK		0x00FF
 #define PCA_INT			0x0100
 #define PCA_PCAL		0x0200
-- 
2.12.2
