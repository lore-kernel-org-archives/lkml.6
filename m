Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDDTBt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:01:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:25755 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeDDTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:00:42 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0pA1dWeZVY=
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
Subject: [PATCH v2 4/5] DTS: Bindings: pca953x driver provides an optional vcc-supply property
Date: Wed,  4 Apr 2018 21:00:23 +0200
Message-Id: <e8e6fae4436e5390c7c4e831c9eb127d3f8cc65b.1522868423.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
In-Reply-To: <cover.1522868422.git.hns@goldelico.com>
References: <cover.1522868422.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So let's describe this property in the bindings.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
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
