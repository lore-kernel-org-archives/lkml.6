Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeCGOP2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:15:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754456AbeCGOP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:15:26 -0500
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "ASoC: wm8524: Remove unit address" to the regulator tree
In-Reply-To: 
Message-Id: <E1etZqm-0001c4-3g@debutante>
Date: Wed, 07 Mar 2018 14:15:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8524: Remove unit address

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 770981f5a8dc61a10c7e8248d07aa558079527a1 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Mar 2018 00:24:13 -0300
Subject: [PATCH] ASoC: wm8524: Remove unit address

WM8524 does not use I2C nor SPI, hence no 'reg' property is used,
so remove the unit address from the bindings example to conform.

This avoids users getting dtc warnings when they copy the
binding example to a real dts file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/wm8524.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
index 20c62002cbcd..0f0553563fc1 100644
--- a/Documentation/devicetree/bindings/sound/wm8524.txt
+++ b/Documentation/devicetree/bindings/sound/wm8524.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8524@0 {
+codec: wm8524 {
 	compatible = "wlf,wm8524";
 	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 };
-- 
2.16.2
