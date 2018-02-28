Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeB1KhD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:37:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55902 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbeB1Kg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:36:58 -0500
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org
Cc: maxime.ripard@bootlin.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v5 4/6] dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
Date: Wed, 28 Feb 2018 11:35:59 +0100
Message-Id: <002a5a7730f8c8ca9b75147cb139cdcea6bb62f1.1519813976.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
References: <cover.07d02d245f44e63775b331815e9bf584598d2e9f.1519813976.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP813 can have a battery as power supply, so let's add it to the
list of compatibles.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt | 8 +++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
index c248866..41916f6 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
@@ -4,12 +4,12 @@ Required Properties:
  - compatible, one of:
 			"x-powers,axp209-battery-power-supply"
 			"x-powers,axp221-battery-power-supply"
+			"x-powers,axp813-battery-power-supply"
 
-This node is a subnode of the axp20x/axp22x PMIC.
+This node is a subnode of its respective PMIC DT node.
 
-The AXP20X and AXP22X can read the battery voltage, charge and discharge
-currents of the battery by reading ADC channels from the AXP20X/AXP22X
-ADC.
+The supported devices can read the battery voltage, charge and discharge
+currents of the battery by reading ADC channels from the ADC.
 
 Example:
 
-- 
git-series 0.9.1
