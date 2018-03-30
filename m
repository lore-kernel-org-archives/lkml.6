Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeC3Dvq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 23:51:46 -0400
Received: from mx.socionext.com ([202.248.49.38]:46792 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbeC3Dvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 23:51:43 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] dt-bindings: thermal: uniphier: add a compatible string for PXs3
Date: Fri, 30 Mar 2018 12:51:19 +0900
Message-Id: <1522381880-18892-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522381880-18892-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for thermal monitor implemented on
UniPhier PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
index 686c0b4..ceb92a9 100644
--- a/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible :
   - "socionext,uniphier-pxs2-thermal" : For UniPhier PXs2 SoC
   - "socionext,uniphier-ld20-thermal" : For UniPhier LD20 SoC
+  - "socionext,uniphier-pxs3-thermal" : For UniPhier PXs3 SoC
 - interrupts : IRQ for the temperature alarm
 - #thermal-sensor-cells : Should be 0. See ./thermal.txt for details.
 
-- 
2.7.4
