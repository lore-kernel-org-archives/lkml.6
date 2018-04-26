Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756877AbeDZRg2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 13:36:28 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:32285 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756839AbeDZRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 13:35:18 -0400
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
Subject: [PATCH v4 6/7] DTS: Bindings: pca953x add an optional vcc-supply property
Date: Thu, 26 Apr 2018 19:35:01 +0200
Message-Id: <2de38ca548c0513305d897c646f68a09f19bd1a1.1524764101.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
In-Reply-To: <cover.1524764101.git.hns@goldelico.com>
References: <cover.1524764101.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware can have a switchable Vcc supply, so let's add it to
the bindings (the current Linux driver code already supports it).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index d2a937682836..6a7cddb187c1 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -35,6 +35,7 @@ Required properties:
 Optional properties:
  - reset-gpios: GPIO specification for the RESET input. This is an
 		active low signal to the PCA953x.
+ - vcc-supply:	power supply regulator.
 
 Example:
 
-- 
2.12.2
